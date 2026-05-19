# Hendrik du TOit use this script.  it is a temporary measure the create a simulation
# URS prod environment outside of the current defined environmentenvironments.
# Once the cloud system is fully functional, this will be removed.
[CmdletBinding()]
param(
    [switch]$Reset
)

$ErrorActionPreference = "Stop"

function Get-AdjustedValue {
    param(
        [Parameter(Mandatory = $true)]
        [string]$VariableName,
        [Parameter(Mandatory = $true)]
        [int]$Delta
    )

    $currentValue = [Environment]::GetEnvironmentVariable($VariableName)
    if ([string]::IsNullOrWhiteSpace($currentValue)) {
        throw "Required environment variable '$VariableName' is missing or empty."
    }

    $parsedValue = 0
    if (-not [int]::TryParse($currentValue, [ref]$parsedValue)) {
        throw "Environment variable '$VariableName' must be an integer. Current value: '$currentValue'."
    }

    return $parsedValue + $Delta
}

$delta = 10
if ($Reset) {
    $delta = -10
}

$variablesToUpdate = @(
    "MYSQL_TCP_PORT",
    "ES_PORT",
    "FPS_PORT"
)

foreach ($variableName in $variablesToUpdate) {
    $newValue = Get-AdjustedValue -VariableName $variableName -Delta $delta
    [Environment]::SetEnvironmentVariable($variableName, $newValue.ToString(), "Process")
    Set-Item -Path "Env:$variableName" -Value $newValue.ToString()
    Write-Host "$variableName=$newValue"
}

$repoRoot = Split-Path -Parent $PSScriptRoot
$setupDotEnvScriptPath = Join-Path $repoRoot "SetupDotEnv.ps1"
if (-not (Test-Path $setupDotEnvScriptPath)) {
    throw "SetupDotEnv.ps1 not found: $setupDotEnvScriptPath"
}

& $setupDotEnvScriptPath
