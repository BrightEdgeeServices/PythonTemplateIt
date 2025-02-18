Write-Host ''
Write-Host ''
$dateTime = Get-Date -Format "yyyy-MM-dd HH:mm:ss"
Write-Host "=[ START $dateTime ]============================[ docker-rebuild.ps1 ]=" -ForegroundColor Blue

& ./create_db_sql_script.ps1
docker compose down
#docker rm --force resultcollector
#docker rmi --force resultcollector-db1
docker volume prune -f
docker compose create
docker compose start

Write-Host '-[ END ]------------------------------------------------------------------------' -ForegroundColor Cyan
Write-Host ''
Write-Host ''
