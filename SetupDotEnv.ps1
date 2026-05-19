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

function Get-EnvValueOrDefault {
    param (
        [Parameter(Mandatory = $true)]
        [string]$VariableName,
        [Parameter(Mandatory = $true)]
        [string]$DefaultValue
    )
    $value = [Environment]::GetEnvironmentVariable($VariableName)
    if ([string]::IsNullOrWhiteSpace($value)) {
        return $DefaultValue
    }
    return $value
}

$scriptDir = Split-Path -Parent $PSCommandPath
$filePath = Join-Path -Path $scriptDir -ChildPath ".env"

# Define the contents of the file
$fileContent = @"
INSTALLER_USERID=$(Get-RequiredEnvValue -VariableName "INSTALLER_USERID")
INSTALLER_PWD=$(Get-RequiredEnvValue -VariableName "INSTALLER_PWD")
LOG_BACKUP_COUNT=$(Get-RequiredEnvValue -VariableName "LOG_BACKUP_COUNT")
LOG_DIR=$(Get-RequiredEnvValue -VariableName "LOG_DIR")
LOG_LEVEL_CONSOLE=$(Get-RequiredEnvValue -VariableName "LOG_LEVEL_CONSOLE")
LOG_LEVEL_FILE=$(Get-RequiredEnvValue -VariableName "LOG_LEVEL_FILE")
LOG_WHEN=$(Get-RequiredEnvValue -VariableName "LOG_WHEN")
MYSQL_DATABASE=$(Get-RequiredEnvValue -VariableName "MYSQL_DATABASE")
MYSQL_HOST=$(Get-RequiredEnvValue -VariableName "MYSQL_HOST")
MYSQL_PASSWORD=$( Get-RequiredEnvValue -VariableName "MYSQL_PASSWORD" )
MYSQL_PWD=$( Get-RequiredEnvValue -VariableName "MYSQL_PWD" )
MYSQL_ROOT_PASSWORD=$(Get-RequiredEnvValue -VariableName "MYSQL_ROOT_PASSWORD")
MYSQL_ROOT_USER=$(Get-RequiredEnvValue -VariableName "MYSQL_ROOT_USER")
MYSQL_TCP_PORT=$(Get-RequiredEnvValue -VariableName "MYSQL_TCP_PORT")
MYSQL_USER=$(Get-RequiredEnvValue -VariableName "MYSQL_USER")
"@

# Write the contents to the file
Set-Content -Path $filePath -Value $fileContent -ErrorAction Stop

# Output a confirmation message
Write-Host "File '$filePath' has been created with the specified contents."
Write-Host '-[ END SetupDotEnv.ps1 ]--------------------------------------------------------' -ForegroundColor Cyan
Write-Host ''
