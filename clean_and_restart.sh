#!/bin/bash

set -euo pipefail

POPULATE_REQUESTED="${1:-}"
POPULATE_DATABASE=false
if [[ "$POPULATE_REQUESTED" == "y" || "$POPULATE_REQUESTED" == "yes" ]]; then
    POPULATE_DATABASE=true
fi

get_service_container_name() {
    local service_name="$1"
    local container_id

    container_id=$(docker compose ps -q "$service_name")
    if [[ -z "$container_id" ]]; then
        echo "Error: Could not find '$service_name' service container." >&2
        docker compose ps >&2
        return 1
    fi

    docker inspect --format '{{.Name}}' "$container_id" | sed 's#^/##'
}

sync_postgres_env_from_container() {
    local service_name="$1"
    local container_id
    local postgres_user
    local postgres_password
    local postgres_db
    local port_mapping

    container_id=$(docker compose ps -q "$service_name")
    if [[ -z "$container_id" ]]; then
        echo "Error: Could not find '$service_name' service container for env sync." >&2
        docker compose ps >&2
        return 1
    fi

    postgres_user=$(docker exec "$container_id" printenv POSTGRES_USER || true)
    postgres_password=$(docker exec "$container_id" printenv POSTGRES_PASSWORD || true)
    postgres_db=$(docker exec "$container_id" printenv POSTGRES_DB || true)
    port_mapping=$(docker port "$container_id" 5432/tcp | head -n 1 || true)

    if [[ -n "$postgres_user" ]]; then
        export MYSQL_ROOT_USER="$postgres_user"
    fi
    if [[ -n "$postgres_password" ]]; then
        export MYSQL_ROOT_PASSWORD="$postgres_password"
    fi
    if [[ -n "$postgres_db" ]]; then
        export MYSQL_DATABASE="$postgres_db"
    fi
    if [[ -n "$port_mapping" ]]; then
        export MYSQL_HOST="127.0.0.1"
        export MYSQL_TCP_PORT
        MYSQL_TCP_PORT=$(awk -F: '{print $NF}' <<<"$port_mapping")
    fi

    #-----------------------------------
    # From here on is a temp fix until the DE_AUTO issue is resolved by Hendrik
    # rteapi settings in non-prod environments prefer DEV_AUTO_* unless
    # DEV_AUTO_OVERRIDE=true is set. Keep dbdef.py and the SQL populator
    # pointed at the same freshly recreated container instance.
    export DEV_AUTO_OVERRIDE="true"
    export DEV_AUTO_MYSQL_HOST="${MYSQL_HOST:-127.0.0.1}"
    export DEV_AUTO_MYSQL_TCP_PORT="${MYSQL_TCP_PORT:-5432}"
    export DEV_E2E_MYSQL_TCP_PORT="${MYSQL_TCP_PORT:-5432}"
    # To here
    #-----------------------------------
}

run_population_script() {
    local sql_path="$1"
    local db_container_name="$2"

    echo "Running population script: $sql_path (db=$MYSQL_DATABASE, container=$db_container_name)"
    # Use the synced container superuser explicitly so local shell INSTALLER_* values
    # cannot point the populator at a role that does not yet exist in the fresh container.
    INSTALLER_USERID="$MYSQL_ROOT_USER" \
    INSTALLER_PWD="$MYSQL_ROOT_PASSWORD" \
    bash ./scripts/integration/populator.sh "$sql_path" "$db_container_name"
}



wait_for_postgres_ready() {
    local service_name="$1"
    local container_id
    local container_name
    local postgres_user
    local postgres_db
    local attempts=0
    local max_attempts=60

    container_id=$(docker compose ps -q "$service_name")
    if [[ -z "$container_id" ]]; then
        echo "Error: Could not find '$service_name' service container."
        docker compose ps
        return 1
    fi

    container_name=$(docker inspect --format '{{.Name}}' "$container_id" | sed 's#^/##')
    postgres_user=$(docker exec "$container_id" printenv POSTGRES_USER 2>/dev/null || true)
    postgres_db=$(docker exec "$container_id" printenv POSTGRES_DB 2>/dev/null || true)
    postgres_user="${postgres_user:-${MYSQL_ROOT_USER:-root}}"
    postgres_db="${postgres_db:-${MYSQL_DATABASE:-postgres}}"

    while (( attempts < max_attempts )); do
        if ! docker ps -q --no-trunc | grep -q "^${container_id}$"; then
            echo "Error: Container '${container_name}' is not running."
            docker compose ps
            docker logs "$container_id" --tail 80 || true
            return 1
        fi

        if docker exec "$container_id" pg_isready -U "$postgres_user" -d "$postgres_db" >/dev/null 2>&1; then
            echo "PostgreSQL is ready in container: $container_name"
            return 0
        fi

        echo "Waiting for database server to start..."
        sleep 3
        attempts=$((attempts + 1))
    done

    echo "Error: Timed out waiting for PostgreSQL in '${container_name}'."
    docker compose ps
    docker logs "$container_id" --tail 120 || true
    return 1
}

run_rteapi_python_module() {
    local module_name="$1"
    local src_path

    src_path="$(pwd)/src"

    if PYTHONPATH="$src_path${PYTHONPATH:+:$PYTHONPATH}" python -c "import sqlalchemy" >/dev/null 2>&1; then
        PYTHONPATH="$src_path${PYTHONPATH:+:$PYTHONPATH}" python -m "$module_name"
        return
    fi

    if command -v poetry >/dev/null 2>&1; then
        PYTHONPATH="$src_path${PYTHONPATH:+:$PYTHONPATH}" poetry run python -m "$module_name"
        return
    fi

    echo "Error: Could not find a Python environment with rteapi dependencies. Activate the virtualenv or use Poetry." >&2
    return 1
}

read -r -p "Are you sure you want to run this script? This will remove volumes and restart the container. I.e. NUKE THE DATABASE Type 'yes' to continue: " confirmation
if [[ "$confirmation" != "yes" ]]; then
    echo "Operation cancelled by user."
    exit 1
fi

docker compose down -v
docker compose up -d

wait_for_postgres_ready "db"
sync_postgres_env_from_container "db"

echo "Creating rteapi database"
run_rteapi_python_module "rteapi.dbdef"

if [[ "$POPULATE_DATABASE" == "true" ]]; then
    sql_path="./scripts/integration/startup_population.sql"
    db_container_name=$(get_service_container_name "db")

    if [[ ! -f "$sql_path" ]]; then
        echo "Error: SQL file not found: $sql_path"
        exit 1
    fi

    if [[ -z "${MYSQL_DATABASE:-}" ]]; then
        echo "Error: MYSQL_DATABASE env var is not set. Cannot run $sql_path"
        exit 1
    fi

    run_population_script "$sql_path" "$db_container_name"
    echo "Population complete."
else
    echo "Skipping database population. Pass 'y' to populate: ./clean_and_restart.sh y"
fi
