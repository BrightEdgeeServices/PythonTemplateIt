Write-Host "--------------------------------------------------------------------------------" -ForegroundColor Cyan
Write-Host "Executing $PSCommandPath..." -ForegroundColor Yellow

if ($env:VENV_ORGANIZATION_NAME -eq "Citiq")
{
    $env:VENV_ORGANIZATION_NAME = "citiq-prepaid"
    if ($env:GH_APP_ACCESS_TOKEN_CITIQ_HDT)
    {
        $env:GH_REPO_ACCESS_BY_OWN_APPS = $env:GH_APP_ACCESS_TOKEN_CITIQ_HDT
    }
}
elseif ($env:VENV_ORGANIZATION_NAME -eq "BEE")
{
    $env:VENV_ORGANIZATION_NAME = "BrightEdgeeServices"
    if ($env:GH_APP_ACCESS_TOKEN_BEE_HDT)
    {
        $env:GH_REPO_ACCESS_BY_OWN_APPS = $env:GH_APP_ACCESS_TOKEN_BEE_HDT
    }
}
git remote set-url origin https://$env:GH_REPO_ACCESS_BY_OWN_APPS@github.com/$env:VENV_ORGANIZATION_NAME/$env:PROJECT_NAME
(Invoke-WebRequest -Uri https://install.python-poetry.org -UseBasicParsing).Content | python -
poetry init
if (Test-Path -Path "$env:PROJECT_DIR\pyproject.toml")
{
    poetry install --with dev
}
pre-commit install
pre-commit autoupdate
