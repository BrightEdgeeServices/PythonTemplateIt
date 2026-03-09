#!/usr/bin/env bash
set -u
set -o pipefail

echo ""
date_time="$(date "+%Y-%m-%d %H:%M:%S")"
echo "=[ START ${date_time} ]==================================[ Install.sh ]="
echo "Executing ${BASH_SOURCE[0]}..."

script_dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
cd "$script_dir" || {
    echo "Failed to change directory to ${script_dir}" >&2
    exit 1
}

invoke_npm_command() {
    local description="$1"
    shift

    echo "$description"
    npm "$@"
}

if [[ "${VENV_ORGANIZATION_NAME:-}" == "rte" ]]; then
    export VENV_ORGANIZATION_NAME="RealTimeEvents"
elif [[ "${VENV_ORGANIZATION_NAME:-}" == "BEE" ]]; then
    export VENV_ORGANIZATION_NAME="BrightEdgeeServices"
fi

if [[ -n "${GH_REPO_ACCESS_BY_OWN_APPS:-}" && -n "${VENV_ORGANIZATION_NAME:-}" && -n "${PROJECT_NAME:-}" ]]; then
    if ! git remote set-url origin "https://${GH_REPO_ACCESS_BY_OWN_APPS}@github.com/${VENV_ORGANIZATION_NAME}/${PROJECT_NAME}"; then
        echo "Warning: failed to set git remote origin URL."
    fi
else
    echo "Skipping git remote setup: required GitHub environment variables are missing."
fi

if ! command -v npm >/dev/null 2>&1; then
    echo "npm is not available. Install Node.js (which includes npm) and run Install.sh again." >&2
    exit 1
fi

if [[ -f "${script_dir}/package-lock.json" ]]; then
    if ! invoke_npm_command "Installing Node dependencies with npm ci..." ci; then
        echo "npm ci failed. Retrying with --legacy-peer-deps due peer dependency conflicts..."
        if ! invoke_npm_command "Installing Node dependencies with npm ci --legacy-peer-deps..." ci --legacy-peer-deps; then
            echo "Dependency installation failed with npm ci." >&2
            exit 1
        fi
    fi
elif [[ -f "${script_dir}/package.json" ]]; then
    if ! invoke_npm_command "Installing Node dependencies with npm install..." install; then
        echo "npm install failed. Retrying with --legacy-peer-deps due peer dependency conflicts..."
        if ! invoke_npm_command "Installing Node dependencies with npm install --legacy-peer-deps..." install --legacy-peer-deps; then
            echo "Dependency installation failed with npm install." >&2
            exit 1
        fi
    fi
else
    echo "No package.json found in ${script_dir}. This install script expects a React/Node project." >&2
    exit 1
fi

if command -v pre-commit >/dev/null 2>&1; then
    pre-commit install
    pre-commit autoupdate
else
    echo "pre-commit is not installed. Skipping hook installation."
fi

echo "-[ END Install.sh ]-------------------------------------------------------------"
echo ""
