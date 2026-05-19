param (
    [Parameter(Mandatory = $true, Position = 0)]
    [string]$RepoName
)
poetry source add --priority=explicit $RepoName "https://github.com/RealTimeEvents/$RepoName.git"
poetry add --source $RepoName "git+https://github.com/RealTimeEvents/$RepoName.git#master"
