Write-Host ''
$dateTime = Get-Date -Format "yyyy-MM-dd HH:mm:ss"
Write-Host "=[ START $dateTime ]==============================[ SetupDotEnv.ps1 ]=" -ForegroundColor Blue
Write-Host "Executing $PSCommandPath..." -ForegroundColor Yellow
$filePath = "$env:PROJECT_DIR\.env"

# Define the contents of the file
$fileContent = @"
GOOGLE_CREDENTIALS_PATH="$env:GOOGLE_CREDENTIALS_PATH"
INSTALLER_USERID=$env:INSTALLER_USERID
INSTALLER_PWD=$env:INSTALLER_PWD
MYSQL_DATABASE=$env:MYSQL_DATABASE
MYSQL_HOST=$env:MYSQL_HOST
MYSQL_PASSWORD=$env:MYSQL_PASSWORD
MYSQL_ROOT_PASSWORD=$env:MYSQL_ROOT_PASSWORD
MYSQL_TCP_PORT=$env:MYSQL_TCP_PORT
MYSQL_USER=$env:MYSQL_USER
PROJECT_DIR=$env:PROJECT_DIR
PROJECT_NAME=$env:PROJECT_NAME
VENV_ENVIRONMENT=$env:VENV_ENVIRONMENT

PYTEST_MYSQL_DATABASE=$env:PYTEST_MYSQL_DATABASE
PYTEST_MYSQL_HOST=$env:PYTEST_MYSQL_HOST
PYTEST_MYSQL_TCP_PORT=$env:PYTEST_MYSQL_TCP_PORT

"@

# Write the contents to the file
Set-Content -Path $filePath -Value $fileContent

# Output a confirmation message
Write-Host "File '$filePath' has been created with the specified contents."
Write-Host '-[ END SetupDotEnv.ps1 ]--------------------------------------------------------' -ForegroundColor Cyan
Write-Host ''
