Write-Host ''
Write-Host ''
$dateTime = Get-Date -Format "yyyy-MM-dd HH:mm:ss"
Write-Host "=[ START $dateTime ]==========================[ add_private_repo.ps1 ]=" -ForegroundColor Blue

Write-Host "Remove configuration" -ForegroundColor Magenta

$private_repository_name = 'fidewebtourparser'
$private_repository_username = '__token__'
$private_repository_password = $env:GH_REPO_ACCESS_BY_OWN_APPS
$private_repository_organization = 'RealTimeEvents'

$branch_private_repository_name = 'fideratinglist'
$branch_repository_organization = 'RealTimeEvents'

git remote set-url origin https://$env:GH_REPO_ACCESS_BY_OWN_APPS@github.com/$branch_repository_organization/$branch_private_repository_name

poetry config http-basic.$private_repository_name --unset
poetry source remove $private_repository_name
poetry remove $private_repository_name

Write-Host "Add configuration" -ForegroundColor Yellow
poetry config http-basic.$private_repository_name $private_repository_username $private_repository_password
poetry source add --priority=explicit $private_repository_name https://github.com/$private_repository_organization/$private_repository_name.git
poetry add git+https://github.com/$private_repository_organization/$private_repository_name.git

Write-Host '-[ END ]------------------------------------------------------------------------' -ForegroundColor Cyan
Write-Host ''
Write-Host ''
