param(
    [string]$ComposeVariant = ""
)

# Load repository .env values into the current PowerShell process so
# docker/psql/bash helpers see the same settings as the Python code.
function Import-DotEnvFile {
    param(
        [Parameter(Mandatory = $true)]
        [string]$Path
    )

    if (-not (Test-Path $Path)) {
        throw ".env file not found: $Path"
    }

    foreach ($line in Get-Content $Path) {
        if ([string]::IsNullOrWhiteSpace($line)) {
            continue
        }

        $trimmedLine = $line.Trim()
        if ($trimmedLine.StartsWith("#")) {
            continue
        }

        $separatorIndex = $trimmedLine.IndexOf("=")
        if ($separatorIndex -lt 1) {
            continue
        }

        $name = $trimmedLine.Substring(0, $separatorIndex).Trim()
        $value = $trimmedLine.Substring($separatorIndex + 1).Trim()

        if (
            ($value.StartsWith('"') -and $value.EndsWith('"')) -or
            ($value.StartsWith("'") -and $value.EndsWith("'"))
        ) {
            $value = $value.Substring(1, $value.Length - 2)
        }

        Set-Item -Path "Env:$name" -Value $value
    }
}

function ConvertTo-BashLiteral {
    param(
        [AllowEmptyString()]
        [string]$Value
    )

    $escapedValue = $Value.Replace('\', '\\').Replace('"', '\"').Replace('$', '\$').Replace('`', '\`')
    return "`"$escapedValue`""
}

function Get-DockerComposeArguments {
    param(
        [Parameter(Mandatory = $true)]
        [string]$ComposeFilePath,
        [Parameter(Mandatory = $true)]
        [string]$EnvFilePath,
        [Parameter(Mandatory = $true)]
        [string]$ProjectName
    )

    return @(
        "--project-name", $ProjectName,
        "--env-file", $EnvFilePath,
        "-f", $ComposeFilePath
    )
}

function Get-ComposeFilePath {
    param(
        [string]$Variant
    )

    if ([string]::IsNullOrWhiteSpace($Variant)) {
        return Join-Path $PSScriptRoot "docker-compose.yaml"
    }

    return Join-Path $PSScriptRoot ("docker-compose-{0}.yaml" -f $Variant)
}

function Get-ComposeProjectName {
    param(
        [string]$Variant
    )

    $baseProjectName = $env:COMPOSE_PROJECT_NAME
    if ([string]::IsNullOrWhiteSpace($baseProjectName)) {
        throw "COMPOSE_PROJECT_NAME env var must be set before running clean_and_restart.ps1."
    }

    if ([string]::IsNullOrWhiteSpace($Variant)) {
        return $baseProjectName
    }

    return "{0}_{1}" -f $baseProjectName, $Variant.Trim()
}

function Get-DbServiceName {
    param(
        [string]$ComposeFilePath,
        [string]$Variant
    )

    $normalizedVariant = if ([string]::IsNullOrWhiteSpace($Variant)) { "dev" } else { $Variant.Trim() }
    $preferredServiceName = "{0}_db" -f $normalizedVariant
    $composeContent = Get-Content -Path $ComposeFilePath -Raw

    if ($composeContent -match "(?m)^\s*$([regex]::Escape($preferredServiceName))\s*:") {
        return $preferredServiceName
    }

    if ($normalizedVariant -eq "dev" -and $composeContent -match "(?m)^\s*db\s*:") {
        return "db"
    }

    throw "Could not find a matching database service in compose file: $ComposeFilePath"
}

$composeFilePath = Get-ComposeFilePath -Variant $ComposeVariant
if (-not (Test-Path $composeFilePath)) {
    throw "Docker compose file not found: $composeFilePath"
}

$envFile = Join-Path $PSScriptRoot ".env"
Import-DotEnvFile -Path $envFile
$composeProjectName = Get-ComposeProjectName -Variant $ComposeVariant
$dockerComposeArgs = Get-DockerComposeArguments -ComposeFilePath $composeFilePath -EnvFilePath $envFile -ProjectName $composeProjectName

# Confirm before proceeding
$confirmation = Read-Host "Are you sure you want to run this script? This will remove volumes and restart the container. I.e. NUKE THE DATABASE Type 'yes' to continue"

if ($confirmation -ne 'yes') {
    Write-Host "Operation cancelled by user."
    exit
}

$dbServiceName = Get-DbServiceName -ComposeFilePath $composeFilePath -Variant $ComposeVariant

Write-Host "Using docker compose file: $composeFilePath"
Write-Host "Using database service: $dbServiceName"
Write-Host "Using environment file: $envFile"
Write-Host "Using compose project name: $composeProjectName"

docker compose @dockerComposeArgs down -v
docker compose @dockerComposeArgs up -d

# Get the last deployed container name for the selected database service.
$containerName = docker compose @dockerComposeArgs ps -q $dbServiceName | ForEach-Object { docker inspect --format '{{.Name}}' $_ } | ForEach-Object { $_.TrimStart('/') }

if (-not $containerName) {
    throw "Could not find '$dbServiceName' service container for compose file: $composeFilePath"
}

do {
    Write-Host "Waiting for database server to start..."
    Start-Sleep -Seconds 5
    docker exec $containerName pg_isready -U $env:MYSQL_ROOT_USER -d $env:MYSQL_DATABASE *> $null
    $logLine = $LASTEXITCODE -eq 0
} while (-not $logLine)

Write-Host "PostgreSQL is ready in container: $containerName"

python .\src\es\dbdef.py


# --- Populate DB with integration test baseline data ---

$response = Read-Host "`nDo you want to populate the database? (yes/no)"

if ($response -eq "yes") {
    $sqlPath = Join-Path $PSScriptRoot "scripts\integration\startup_population.sql"
    $relativeSqlPath = "./scripts/integration/startup_population.sql"
    $relativeExecPath = "./scripts/integration/execute_sql.sh"
    if (-not (Test-Path $sqlPath)) {
        throw "SQL file not found: $sqlPath"
    }

    $dbName = $env:MYSQL_DATABASE
    if (-not $dbName) {
        throw "MYSQL_DATABASE env var is not set. Cannot run $sqlPath"
    }

    Write-Host "Running population script: $sqlPath (db=$dbName)"
    $mysqlRootUser = $env:MYSQL_ROOT_USER
    $mysqlRootPassword = $env:MYSQL_ROOT_PASSWORD
    if (-not $mysqlRootUser -or -not $mysqlRootPassword) {
        throw "MYSQL_ROOT_USER and MYSQL_ROOT_PASSWORD must be set before running $sqlPath"
    }

    $bashCommand = @(
        "export MYSQL_DATABASE=$(ConvertTo-BashLiteral $env:MYSQL_DATABASE)"
        "export MYSQL_HOST=$(ConvertTo-BashLiteral $env:MYSQL_HOST)"
        "export MYSQL_TCP_PORT=$(ConvertTo-BashLiteral $env:MYSQL_TCP_PORT)"
        "export MYSQL_ROOT_USER=$(ConvertTo-BashLiteral $mysqlRootUser)"
        "export MYSQL_ROOT_PASSWORD=$(ConvertTo-BashLiteral $mysqlRootPassword)"
        "$relativeExecPath $relativeSqlPath"
    ) -join "; "

    Push-Location $PSScriptRoot
    try {
        bash -lc $bashCommand
        if ($LASTEXITCODE -ne 0) {
            throw "Failed to run population script: $sqlPath"
        }
        Write-Host "Population complete."
    }
    finally {
        Pop-Location
    }
} else {
    Write-Host "Skipping database population." -ForegroundColor Yellow
}
