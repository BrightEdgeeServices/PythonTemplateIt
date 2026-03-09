Write-Host ''
$dateTime = Get-Date -Format "yyyy-MM-dd HH:mm:ss"
Write-Host "=[ START $dateTime ]==============================[ SetupDotEnv.ps1 ]=" -ForegroundColor Blue
Write-Host "Executing $PSCommandPath..." -ForegroundColor Yellow

function Get-RequiredEnvValue {
    param (
        [Parameter(Mandatory = $true)]
        [string]$VariableName
    )
    $value = [Environment]::GetEnvironmentVariable($VariableName)
    if ([string]::IsNullOrWhiteSpace($value)) {
        throw "Required environment variable '$VariableName' is missing or empty."
    }
    return $value
}

$projectDir = Get-RequiredEnvValue -VariableName "PROJECT_DIR"
$filePath = Join-Path -Path $projectDir -ChildPath ".env"

# Define the contents of the file
$fileContent = @"
AUTHZ_CACHE_TTL_SEC=$(Get-RequiredEnvValue -VariableName "AUTHZ_CACHE_TTL_SEC")
AUTHZ_HOST=$(Get-RequiredEnvValue -VariableName "AUTHZ_HOST")
AUTHZ_MYSQL_DATABASE=$(Get-RequiredEnvValue -VariableName "AUTHZ_MYSQL_DATABASE" )
AUTHZ_MYSQL_HOST=$(Get-RequiredEnvValue -VariableName "AUTHZ_MYSQL_HOST")
AUTHZ_MYSQL_PASSWORD=$(Get-RequiredEnvValue -VariableName "AUTHZ_MYSQL_PASSWORD")
AUTHZ_MYSQL_ROOT_PASSWORD=$(Get-RequiredEnvValue -VariableName "AUTHZ_MYSQL_ROOT_PASSWORD")
AUTHZ_MYSQL_TCP_PORT=$(Get-RequiredEnvValue -VariableName "AUTHZ_MYSQL_TCP_PORT")
AUTHZ_MYSQL_USER=$(Get-RequiredEnvValue -VariableName "AUTHZ_MYSQL_USER")
AUTHZ_PORT=$(Get-RequiredEnvValue -VariableName "AUTHZ_PORT" )
AUTHZ_SERVICE_CLIENT_ID=$(Get-RequiredEnvValue -VariableName "AUTHZ_SERVICE_CLIENT_ID")
AUTHZ_SERVICE_CLIENT_SECRET=$(Get-RequiredEnvValue -VariableName "AUTHZ_SERVICE_CLIENT_SECRET")
ES_PORT=$( Get-RequiredEnvValue -VariableName "ES_PORT" )
GOOGLE_CREDENTIALS_PATH="$env:GOOGLE_CREDENTIALS_PATH"
INSTALLER_USERID=$(Get-RequiredEnvValue -VariableName "INSTALLER_USERID")
INSTALLER_PWD=$(Get-RequiredEnvValue -VariableName "INSTALLER_PWD")
MYSQL_DATABASE=$(Get-RequiredEnvValue -VariableName "MYSQL_DATABASE")
MYSQL_HOST=$(Get-RequiredEnvValue -VariableName "MYSQL_HOST")
MYSQL_PASSWORD=$( Get-RequiredEnvValue -VariableName "MYSQL_PASSWORD" )
MYSQL_PWD=$( Get-RequiredEnvValue -VariableName "MYSQL_PWD" )
MYSQL_ROOT_PASSWORD=$(Get-RequiredEnvValue -VariableName "MYSQL_ROOT_PASSWORD")
MYSQL_TCP_PORT=$(Get-RequiredEnvValue -VariableName "MYSQL_TCP_PORT")
MYSQL_TCP_PORT_EXTERNAL=$( Get-RequiredEnvValue -VariableName "MYSQL_TCP_PORT_EXTERNAL" )
MYSQL_USER=$(Get-RequiredEnvValue -VariableName "MYSQL_USER")
PROJECT_DIR=$(Get-RequiredEnvValue -VariableName "PROJECT_DIR")
PROJECT_NAME=$(Get-RequiredEnvValue -VariableName "PROJECT_NAME")
PYTEST_MYSQL_DATABASE=$(Get-RequiredEnvValue -VariableName "PYTEST_MYSQL_DATABASE")
PYTEST_MYSQL_HOST=$(Get-RequiredEnvValue -VariableName "PYTEST_MYSQL_HOST")
PYTEST_MYSQL_TCP_PORT=$(Get-RequiredEnvValue -VariableName "PYTEST_MYSQL_TCP_PORT")
RTEAPI_BASE_IMAGES_PATH=$(Get-RequiredEnvValue -VariableName "RTEAPI_BASE_IMAGES_PATH")
RTEAPI_ES_PRESENCE_TTL_S=$(Get-RequiredEnvValue -VariableName "RTEAPI_ES_PRESENCE_TTL_S")
RTEAPI_ES_SSE_HEARTBEAT_S=$(Get-RequiredEnvValue -VariableName "RTEAPI_ES_SSE_HEARTBEAT_S")
RTEAPI_ES_SSE_PUBSUB_POLL_TIMEOUT_S=$(Get-RequiredEnvValue -VariableName "RTEAPI_ES_SSE_PUBSUB_POLL_TIMEOUT_S")
RTEAPI_ES_WS_HEARTBEAT_S=$(Get-RequiredEnvValue -VariableName "RTEAPI_ES_WS_HEARTBEAT_S")
RTEAPI_ES_WS_PUBSUB_POLL_TIMEOUT_S=$(Get-RequiredEnvValue -VariableName "RTEAPI_ES_WS_PUBSUB_POLL_TIMEOUT_S")
RTEAPI_HOST=$(Get-RequiredEnvValue -VariableName "RTEAPI_HOST")
RTEAPI_LOG_REQUESTS = 1=$(Get-RequiredEnvValue -VariableName "RTEAPI_LOG_REQUESTS")
RTEAPI_PORT=$(Get-RequiredEnvValue -VariableName "RTEAPI_PORT")
RTEAPI_REDIS_PORT=$(Get-RequiredEnvValue -VariableName "RTEAPI_REDIS_PORT")
RTEAPI_REDIS_DB=$(Get-RequiredEnvValue -VariableName "RTEAPI_REDIS_DB")
RTEAPI_REDIS_HOST=$(Get-RequiredEnvValue -VariableName "RTEAPI_REDIS_HOST")
RTEAPI_URL=$(Get-RequiredEnvValue -VariableName "RTEAPI_URL")
UMS_MYSQL_DATABASE=$( Get-RequiredEnvValue -VariableName "UMS_MYSQL_DATABASE" )
UMS_MYSQL_HOST=$(Get-RequiredEnvValue -VariableName "UMS_MYSQL_HOST")
UMS_MYSQL_TCP_PORT=$(Get-RequiredEnvValue -VariableName "UMS_MYSQL_TCP_PORT")
UMS_SERVICE_CLIENT_ID=$(Get-RequiredEnvValue -VariableName "UMS_SERVICE_CLIENT_ID")
UMS_SERVICE_CLIENT_SECRET=$(Get-RequiredEnvValue -VariableName "UMS_SERVICE_CLIENT_SECRET")
UMS_PORT=$( Get-RequiredEnvValue -VariableName "UMS_PORT" )
VENV_ENVIRONMENT=$(Get-RequiredEnvValue -VariableName "VENV_ENVIRONMENT")
"@

# Write the contents to the file
Set-Content -Path $filePath -Value $fileContent -ErrorAction Stop

# Output a confirmation message
Write-Host "File '$filePath' has been created with the specified contents."
Write-Host '-[ END SetupDotEnv.ps1 ]--------------------------------------------------------' -ForegroundColor Cyan
Write-Host ''
