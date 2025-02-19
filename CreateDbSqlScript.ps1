Write-Host ''
$dateTime = Get-Date -Format "yyyy-MM-dd HH:mm:ss"
Write-Host "=[ START $dateTime ]========================[ CreateDbSqlScript.ps1 ]=" -ForegroundColor Blue
Write-Host "Executing $PSCommandPath..." -ForegroundColor Yellow
if (-not (Test-Path -Path "$env:PROJECT_DIR\scripts"))
{
    New-Item -Path "$env:PROJECT_DIR\scripts" -ItemType Directory | Out-Null
}
$filePath = "./scripts/setup_db.sql"

# Define the contents of the file
$fileContent = @"
DROP DATABASE IF EXISTS ToDelete;
CREATE DATABASE IF NOT EXISTS $env:MYSQL_DATABASE;
CREATE USER IF NOT EXISTS '$env:INSTALLER_USER_ID'@'%' IDENTIFIED BY '$env:INSTALLER_USER_PWD';
GRANT ALL ON $env:MYSQL_DATABASE.* TO '$env:INSTALLER_USER_ID'@'%';
FLUSH PRIVILEGES;
"@

# Write the contents to the file
Set-Content -Path $filePath -Value $fileContent

# Output a confirmation message
Write-Host "File '$filePath' has been created with the specified contents."
Write-Host '-[ END CreateDbSqlScript ]------------------------------------------------------' -ForegroundColor Cyan
Write-Host ''
