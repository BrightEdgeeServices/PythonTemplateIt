Write-Host ''
Write-Host ''
$dateTime = Get-Date -Format "yyyy-MM-dd HH:mm:ss"
Write-Host "=[ START $dateTime ]===========================[ install_dev_env.ps1 ]=" -ForegroundColor Blue
Write-Host "Running $env:PROJECT_DIR\install.ps1..."  -ForegroundColor Yellow

(Invoke-WebRequest -Uri https://install.python-poetry.org -UseBasicParsing).Content | python -
poetry init
& ./add_private_repo.ps1
if (Test-Path -Path "$env:PROJECT_DIR\pyproject.toml")
{
    poetry install --with dev
}
pre-commit install
pre-commit autoupdate
& ./create_dot_env.ps1
& ./docker-rebuild.ps1

Write-Host '-[ END ]------------------------------------------------------------------------' -ForegroundColor Cyan
Write-Host ''
Write-Host ''
