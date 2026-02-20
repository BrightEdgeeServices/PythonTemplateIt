# PythonTemplateIt

| **Category** | **Status and Links**                                                                                                                                                                                                   |
| ------------ | ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| General      | [![][general_maintenance_y_img]][general_maintenance_y_lnk] [![][general_semver_pic]][general_semver_link] [![][general_license_img]][general_license_lnk] [![][general_release_notes_img]][general_release_notes_lnk] |
| CD/CI        | [![][gh_pr_workflow_img]][gh_pr_workflow_lnk] [![][gh_release_workflow_img]][gh_release_workflow_lnk] [![][cicd_codestyle_img]][cicd_codestyle_lnk] [![][codecov_img]][codecov_lnk]                                    |
| PyPI         | [![][pypi_release_img]][pypi_release_lnk] [![][pypi_py_versions_img]][pypi_py_versions_lnk] [![][pypi_format_img]][pypi_format_lnk] [![][pypi_downloads_img]][pypi_downloads_lnk]                                      |
| Github       | [![][gh_issues_img]][gh_issues_lnk] [![][gh_language_img]][gh_language_lnk] [![][gh_last_commit_img]][gh_last_commit_lnk] [![][gh_deployment_img]][gh_deployment_lnk]                                                  |

Template for Python projects with standardized tooling, automation scripts, and reusable GitHub workflows.

______________________________________________________________________

## Overview

This repository is a starter template for Python services in the BrightEdgeeServices and RealTimeEvents ecosystem.
It provides a baseline for packaging, linting, testing, environment provisioning, and release automation.

______________________________________________________________________

## Requirements

- Python 3.12+
- Poetry
- Docker (optional, for local MySQL service)
- Pre-commit
- GitHub access token(s) for private dependency repositories

______________________________________________________________________

## Quick Start

```powershell
# 1) Prepare local environment variables
.\SetupDotEnv.ps1

# 2) Configure private dependency access
.\SetupPrivateRepoAccess.ps1

# 3) (Optional) Configure GitHub CLI access for repository tasks
.\SetupGitHubAccess.ps1

# 4) Install project and dev dependencies
.\InstallDevEnv.ps1

# 5) Start local database (optional)
docker compose up -d db

# 6) Run tests
poetry run pytest
```

______________________________________________________________________

## Script Overview

- `Install.ps1`: Initializes Poetry tooling and installs dependencies.
- `InstallDevEnv.ps1`: Installs dev dependencies, syncs Poetry environment, and updates pre-commit hooks.
- `SetupDotEnv.ps1`: Generates a `.env` file from current environment variables.
- `SetupPrivateRepoAccess.ps1`: Configures Poetry sources and credentials for private repositories.
- `SetupGitHubAccess.ps1`: Configures GitHub authentication for local automation tasks.
- `SetUpDocker.ps1`: Installs and configures Docker support on development machines.
- `CreateDbSqlScript.ps1`: Creates SQL bootstrap script for local MySQL setup.

______________________________________________________________________

## Release Notes Update Process

1. Commit the current implementation or stage all intended release changes.

1. Compare the current branch against `master`:

   ```powershell
   git rev-parse --abbrev-ref HEAD
   git diff --name-status master...HEAD
   git diff --shortstat master...HEAD
   ```

1. Add a new top section in `ReleaseNotes.md` using grouped headings, a timestamp, and summary statistics.
   Git-tracked diffs already exclude `.gitignore` entries.

1. Update the package version in `pyproject.toml` using SemVer.

1. Push changes and create a PR.

______________________________________________________________________

## Active Workflows

- `.github/workflows/py-temp-pr-pub-no_docker-def.yaml`: Pull request validation workflow.
- `.github/workflows/py-temp-publish-pub-build_release_notify_after_merge-def.yaml`: Release build/publish and notification on merge to `master`.

[cicd_codestyle_img]: https://img.shields.io/badge/code%20style-black-000000.svg "Black"
[cicd_codestyle_lnk]: https://github.com/psf/black "Black"
[codecov_img]: https://img.shields.io/codecov/c/gh/BrightEdgeeServices/PythonTemplateIt "CodeCov"
[codecov_lnk]: https://app.codecov.io/gh/BrightEdgeeServices/PythonTemplateIt "CodeCov"
[general_license_img]: https://img.shields.io/pypi/l/PythonTemplateIt "License"
[general_license_lnk]: https://github.com/BrightEdgeeServices/PythonTemplateIt/blob/master/LICENSE.txt "License"
[general_maintenance_y_img]: https://img.shields.io/badge/Maintenance%20Intended-%E2%9C%94-green.svg?style=flat-square "Maintenance - intended"
[general_maintenance_y_lnk]: http://unmaintained.tech/ "Maintenance - intended"
[general_release_notes_img]: https://img.shields.io/badge/Release%20Notes-Available-blue "Release Notes"
[general_release_notes_lnk]: https://github.com/BrightEdgeeServices/PythonTemplateIt/blob/master/ReleaseNotes.md "Release Notes"
[general_semver_link]: https://semver.org/ "Semantic Versioning - 2.0.0"
[general_semver_pic]: https://img.shields.io/badge/Semantic%20Versioning-2.0.0-brightgreen.svg?style=flat-square "Semantic Versioning - 2.0.0"
[gh_deployment_img]: https://img.shields.io/github/deployments/BrightEdgeeServices/PythonTemplateIt/pypi "GitHub - PyPI Deployment"
[gh_deployment_lnk]: https://github.com/BrightEdgeeServices/PythonTemplateIt/deployments/pypi "GitHub - PyPI Deployment"
[gh_issues_img]: https://img.shields.io/github/issues-raw/BrightEdgeeServices/PythonTemplateIt "GitHub - Issue Counter"
[gh_issues_lnk]: https://github.com/BrightEdgeeServices/PythonTemplateIt/issues "GitHub - Issue Counter"
[gh_language_img]: https://img.shields.io/github/languages/top/BrightEdgeeServices/PythonTemplateIt "GitHub - Top Language"
[gh_language_lnk]: https://github.com/BrightEdgeeServices/PythonTemplateIt "GitHub - Top Language"
[gh_last_commit_img]: https://img.shields.io/github/last-commit/BrightEdgeeServices/PythonTemplateIt/master "GitHub - Last Commit"
[gh_last_commit_lnk]: https://github.com/BrightEdgeeServices/PythonTemplateIt/commits/master "GitHub - Last Commit"
[gh_pr_workflow_img]: https://img.shields.io/github/actions/workflow/status/BrightEdgeeServices/PythonTemplateIt/py-temp-pr-pub-no_docker-def.yaml?label=PR%20workflow "PR Workflow"
[gh_pr_workflow_lnk]: https://github.com/BrightEdgeeServices/PythonTemplateIt/blob/master/.github/workflows/py-temp-pr-pub-no_docker-def.yaml "PR Workflow"
[gh_release_workflow_img]: https://img.shields.io/github/actions/workflow/status/BrightEdgeeServices/PythonTemplateIt/py-temp-publish-pub-build_release_notify_after_merge-def.yaml?label=Release%20workflow "Release Workflow"
[gh_release_workflow_lnk]: https://github.com/BrightEdgeeServices/PythonTemplateIt/blob/master/.github/workflows/py-temp-publish-pub-build_release_notify_after_merge-def.yaml "Release Workflow"
[pypi_downloads_img]: https://img.shields.io/pypi/dm/PythonTemplateIt "Monthly downloads"
[pypi_downloads_lnk]: https://pypi.org/project/PythonTemplateIt/ "Monthly downloads"
[pypi_format_img]: https://img.shields.io/pypi/wheel/PythonTemplateIt "PyPI - Format"
[pypi_format_lnk]: https://pypi.org/project/PythonTemplateIt/ "PyPI - Format"
[pypi_py_versions_img]: https://img.shields.io/pypi/pyversions/PythonTemplateIt "PyPI - Supported Python Versions"
[pypi_py_versions_lnk]: https://pypi.org/project/PythonTemplateIt/ "PyPI - Supported Python Versions"
[pypi_release_img]: https://img.shields.io/pypi/v/PythonTemplateIt "PyPI release"
[pypi_release_lnk]: https://pypi.org/project/PythonTemplateIt/ "PyPI release"
