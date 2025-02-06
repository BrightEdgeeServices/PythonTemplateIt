Write-Host "--------------------------------------------------------------------------------" -ForegroundColor Cyan
Write-Host "Executing $PSCommandPath..." -ForegroundColor Yellow
git remote set-url origin https://$env:GH_REPO_ACCESS_BY_OWN_APPS@github.com/$env:VENV_ORGANIZATION_NAME/$env:PROJECT_NAME
(Invoke-WebRequest -Uri https://install.python-poetry.org -UseBasicParsing).Content | python -
poetry init
if (Test-Path -Path "$env:PROJECT_DIR\pyproject.toml")
{
    poetry install --with dev
}
pre-commit install
pre-commit autoupdate
