# PythonTemplateIt

| **Category** | **Status and Links**                                                                                                                                                                                                   |
| ------------ | ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| General      | [![][general_maintenance_y_img]][general_maintenance_y_lnk] [![][general_semver_pic]][general_semver_link] [![][general_license_img]][general_license_lnk] [![][general_release_notes_img]][general_release_notes_lnk] |
| CD/CI        | [![][gh_pr_workflow_img]][gh_pr_workflow_lnk] [![][gh_release_workflow_img]][gh_release_workflow_lnk] [![][cicd_codestyle_img]][cicd_codestyle_lnk] [![][codecov_img]][codecov_lnk]                                    |
| PyPI         | [![][pypi_release_img]][pypi_release_lnk] [![][pypi_py_versions_img]][pypi_py_versions_lnk] [![][pypi_format_img]][pypi_format_lnk] [![][pypi_downloads_img]][pypi_downloads_lnk]                                      |
| GitHub       | [![][gh_issues_img]][gh_issues_lnk] [![][gh_language_img]][gh_language_lnk] [![][gh_last_commit_img]][gh_last_commit_lnk] [![][gh_deployment_img]][gh_deployment_lnk]                                                  |

______________________________________________________________________

## Short description

PythonTemplateIt is a reusable template for Python projects with standardized packaging, linting, testing, environment bootstrapping, and GitHub workflow automation.

______________________________________________________________________

## Module Overview

### Key Features

- Poetry-based project packaging and dependency management.
- Published package layout rooted under `src/pti/` for template imports such as `import pti.pythontemplateit`.
- Pre-configured quality tooling (`black`, `isort`, `flake8`, `pytest`, `pre-commit`).
- PowerShell and shell scripts for Python setup, optional React setup, private repository access, and Docker-assisted database provisioning.
- Dependabot automation for Poetry dependencies, GitHub Actions workflows, and Docker image updates.
- Local Docker workflows provision MySQL and Redis services with health checks for template-based projects that need backing services.
- Reusable CI/CD workflows for pull request validation and post-merge release/publish handling.
- Release note and versioning conventions aligned to SemVer.

### Project Structure

- `src/pti/`: Template Python package source used by the published distribution.
- `src/`: Application modules and package source code.
- `tests/`: Unit and functional test suites with fixtures and test data.
- `scripts/`: SQL/bootstrap assets.
- `docker-compose.yaml`: Local MySQL and Redis service definitions for development and end-to-end environments.
- `legacy/`: Archived or excluded legacy resources.
- `*.ps1`: Setup and automation scripts for environment and toolchain tasks.

______________________________________________________________________

## Getting Started

### Prerequisites

- Python 3.12+
- Poetry
- Docker (optional, for local MySQL and Redis services)
- GitHub access token(s) for private package sources when needed

### Setup

```powershell
# 1) Generate .env from the SetupDotEnv script
.\SetupDotEnv.ps1

# 2) Configure private repository access for Poetry
.\SetupPrivateRepoAccess.ps1

# 3) Install Python tooling and project dependencies
.\InstallPy.ps1

# 4) Optional: configure GitHub CLI access
.\SetupGitHubAccess.ps1

# 5) Refresh development dependencies directly when needed
.\InstallDevEnv.ps1

# 6) Optional: start the local service stack
.\SetUpDocker.ps1
# or
# docker compose up -d db

# 7) Run tests
poetry run pytest
```

### Optional Frontend Bootstrap

```powershell
# Use these only in repos that also contain a Node/React app
.\InstallReact.ps1
# or
bash ./install_react.sh
```

### Common Commands

```powershell
poetry install
poetry run pytest
poetry run pytest --cov=src --cov=tests --cov-report=term-missing
poetry run black src tests
poetry run isort src tests
poetry run flake8 src tests
poetry run pre-commit run --all-files
```

______________________________________________________________________

## Automation Scripts

- `InstallPy.ps1`: Bootstraps Poetry tooling, updates the repository remote when credentials are available, and installs Python dependencies.
- `InstallDevEnv.ps1`: Installs development dependencies and configures pre-commit tooling.
- `InstallReact.ps1`: Installs Node dependencies for React projects on Windows and configures pre-commit when available.
- `install_react.sh`: Bash equivalent of the React installer for non-PowerShell environments.
- `SetupDotEnv.ps1`: Generates `.env` values from environment variables.
- `SetupPrivateRepoAccess.ps1`: Configures private package source credentials.
- `SetupGitHubAccess.ps1`: Configures GitHub authentication for local automation.
- `SetUpDocker.ps1`: Recreates the local compose stack in detached mode and is intended for workflows where resetting local database state is acceptable.
- `CreateDbSqlScript.ps1`: Generates SQL bootstrap scripts for MySQL setup.

______________________________________________________________________

## Active Workflows

- `.github/workflows/py-temp-pr-pub-no_docker-def.yaml`: Pull request validation workflow.
- `.github/workflows/py-temp-publish-pub-build_release_notify_after_merge-def.yaml`: Release build, publish, and notification workflow after merge to `master`, excluding Dependabot-triggered merges.
- `.github/dependabot.yaml`: Automated dependency update checks for Poetry packages, GitHub Actions workflows, and Docker assets.

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
