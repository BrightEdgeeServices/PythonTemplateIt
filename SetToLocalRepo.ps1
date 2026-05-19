param (
    [Parameter(Mandatory = $true, Position = 0)]
    [string]$RepoName
)

function Set-RepoToLocal {
    param (
        [Parameter(Mandatory = $true)]
        [string]$RepoName,

        [Parameter(Mandatory = $true)]
        [string]$RepoBaseDir
    )
    $RepoPath = Join-Path -Path $RepoBaseDir -ChildPath $RepoName
    Write-Host "Set $RepoPath to local" -ForegroundColor Green
    poetry source remove "$RepoName"
    poetry remove "$RepoName"
    poetry add --editable $RepoPath
}

function Set-NativeProject {
    param (
        [Parameter(Mandatory = $true)]
        [string]$ProjectName,

        [Parameter(Mandatory = $true)]
        [string]$OrgDir,

        [Parameter(Mandatory = $true)]
        [string[]]$LocalRepoNames,

        [Parameter(Mandatory = $false)]
        [string]$RelativeBaseDir = "..",
#
#        [Parameter(Mandatory = $false)]
#        [hashtable]$RepoBaseDirs = @{},

        [Parameter(Mandatory = $false)]
        [string]$Message = "Configure $ProjectName to local"
    )

    Write-Host $Message -ForegroundColor Yellow
    & "$env:VENV_BASE_DIR\$($ProjectName)_env\Scripts\activate.ps1"
    Set-Location (Join-Path -Path $OrgDir -ChildPath $ProjectName)

    foreach ($LocalRepoName in $LocalRepoNames) {
        Set-RepoToLocal -RepoName $LocalRepoName -RepoBaseDir $RelativeBaseDir
    }

    & deactivate
}

if($RepoName -eq "all") {
    Set-NativeProject `
        -ProjectName "fideratinglist" `
        -OrgDir "$env:PROJECTS_BASE_DIR\rte" `
        -LocalRepoNames @("fidewebtourparser")

    Set-NativeProject `
        -ProjectName "rteapi" `
        -OrgDir "$env:PROJECTS_BASE_DIR\rte\rteapi" `
        -LocalRepoNames @("fidewebtourparser", "fideratinglist", "rtecommon", "sample_data_factory") `

    Set-NativeProject `
        -ProjectName "event_service" `
        -OrgDir "$env:PROJECTS_BASE_DIR\rte" `
        -LocalRepoNames @("fidewebtourparser", "fideratinglist", "rtecommon")

    Set-NativeProject `
        -ProjectName "download_manager_app" `
        -OrgDir "$env:PROJECTS_BASE_DIR\rte" `
        -LocalRepoNames @("fidewebtourparser", "fideratinglist", "rtecommon", "sample_data_factory") `

    Set-NativeProject `
        -ProjectName "rte" `
        -OrgDir "$env:PROJECTS_BASE_DIR" `
        -LocalRepoNames @(
            "rtecommon",
            "sample_data_factory",
            "fidewebtourparser",
            "fideratinglist",
            "rteapi",
            "event_service",
            "download_manager_app"
        ) `
        -RelativeBaseDir "." `
        -Message "Finally configure rte to local"
    & "$env:VENV_BASE_DIR\rte_env\Scripts\activate.ps1"
    Set-Location (Join-Path -Path $env:PROJECTS_BASE_DIR -ChildPath "rte")
    poetry lock --no-cache --regenerate # Locks the project dependencies
    poetry install --with dev --no-cache # Installs the project dependencies
    poetry update --with dev --no-cache  # Update the dependencies as according to the pyproject.toml file
    poetry sync --with dev --no-cache # Update the project's environment according to the lockfile.
}
else {
    poetry source remove $RepoName
    poetry remove $RepoName
    poetry add --editable ../$RepoName
}
