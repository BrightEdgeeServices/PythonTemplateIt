Write-Host ''
$dateTime = Get-Date -Format "yyyy-MM-dd HH:mm:ss"
Write-Host "=[ START $dateTime ]==================================[ Install.ps1 ]=" -ForegroundColor Blue
Write-Host "Executing $PSCommandPath..." -ForegroundColor Yellow

$scriptDir = Split-Path -Parent $PSCommandPath
Set-Location $scriptDir

function Invoke-NpmCommand
{
    param(
        [Parameter(Mandatory = $true)]
        [string]$Description,
        [Parameter(Mandatory = $true)]
        [string[]]$NpmArguments
    )

    Write-Host $Description -ForegroundColor Yellow
    & npm @NpmArguments

    return ($LASTEXITCODE -eq 0)
}

if ($env:VENV_ORGANIZATION_NAME -eq "rte") {
    $env:VENV_ORGANIZATION_NAME = "RealTimeEvents"
}
elseif ($env:VENV_ORGANIZATION_NAME -eq "BEE"){
    $env:VENV_ORGANIZATION_NAME = "BrightEdgeeServices"
}
if ($env:GH_REPO_ACCESS_BY_OWN_APPS -and $env:VENV_ORGANIZATION_NAME -and $env:PROJECT_NAME) {
    git remote set-url origin https://$env:GH_REPO_ACCESS_BY_OWN_APPS@github.com/$env:VENV_ORGANIZATION_NAME/$env:PROJECT_NAME
}
else {
    Write-Host "Skipping git remote setup: required GitHub environment variables are missing." -ForegroundColor DarkYellow
}

if (-not (Get-Command npm -ErrorAction SilentlyContinue)) {
    throw "npm is not available. Install Node.js (which includes npm) and run Install.ps1 again."
}

if (Test-Path -Path "$scriptDir\package-lock.json") {
    $installSucceeded = Invoke-NpmCommand -Description "Installing Node dependencies with npm ci..." -NpmArguments @("ci")
    if (-not $installSucceeded)     {
        Write-Host "npm ci failed. Retrying with --legacy-peer-deps due peer dependency conflicts..." -ForegroundColor DarkYellow
        $installSucceeded = Invoke-NpmCommand -Description "Installing Node dependencies with npm ci --legacy-peer-deps..." -NpmArguments @("ci", "--legacy-peer-deps")
    }

    if (-not $installSucceeded)     {
        throw "Dependency installation failed with npm ci."
    }
}
elseif (Test-Path -Path "$scriptDir\package.json") {
    $installSucceeded = Invoke-NpmCommand -Description "Installing Node dependencies with npm install..." -NpmArguments @("install")
    if (-not $installSucceeded)
    {
        Write-Host "npm install failed. Retrying with --legacy-peer-deps due peer dependency conflicts..." -ForegroundColor DarkYellow
        $installSucceeded = Invoke-NpmCommand -Description "Installing Node dependencies with npm install --legacy-peer-deps..." -NpmArguments @("install", "--legacy-peer-deps")
    }

    if (-not $installSucceeded)     {
        throw "Dependency installation failed with npm install."
    }
}
else {
    throw "No package.json found in $scriptDir. This install script expects a React/Node project."
}

if (Get-Command pre-commit -ErrorAction SilentlyContinue) {
    pre-commit install
    pre-commit autoupdate
}
else {
    Write-Host "pre-commit is not installed. Skipping hook installation." -ForegroundColor DarkYellow
}
Write-Host '-[ END Install.ps1 ]------------------------------------------------------------' -ForegroundColor Cyan
Write-Host ''
