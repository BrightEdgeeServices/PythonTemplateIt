# Release 0.6.0

Release Date: 2026-02-22 01:03:19 +02:00

## CI/CD and Workflow Changes

- Replaced the Docker-based publish workflow with dedicated PR validation and post-merge release workflows: `.github/workflows/py-temp-pr-pub-no_docker-def.yaml` and `.github/workflows/py-temp-publish-pub-build_release_notify_after_merge-def.yaml`.
- Removed `.github/workflows/py-temp-pypi-pub_with_docker-def.yaml`.
- Removed `.github/CODEOWNERS` from this repository template.

## Tooling and Configuration Updates

- Added `.dockerignore`.
- Refreshed `.gitignore` patterns for local tooling and generated artifacts.
- Updated `.pre-commit-config.yaml` hook sources and versions, including Black mirror and legacy exclusions.
- Simplified `.flake8` by removing archive-specific excludes.
- Updated `pyproject.toml` and regenerated `poetry.lock`, including Python requirement alignment to `>=3.12`, URL metadata cleanup, and pytest legacy-path ignores.
- Added `.junie/guidelines.md` and `AGENTS.md` for repository automation guidance.

## Environment and Script Improvements

- Updated `Install.ps1` to bootstrap Poetry installation and configure remote access from environment tokens.
- Updated `InstallDevEnv.ps1` to run no-cache Poetry lock/install/update/sync flow and clearer pre-commit setup steps.
- Updated `SetupDotEnv.ps1` variable names and expanded generated `.env` content with Google credentials and pytest MySQL variables.
- Updated `SetupPrivateRepoAccess.ps1` to support repository-specific Poetry sources and conditional activation.
- Updated `CreateDbSqlScript.ps1` and `scripts/setup_db.sql` grants to use `GRANT ALL PRIVILEGES ... WITH GRANT OPTION`.
- Updated `docker-compose.yaml` environment variable mapping for local MySQL startup.

## Documentation and Release Management

- Reworked `README.md` into a structured Markdown guide and removed `README.rst`.
- Updated `ReleaseNotes.md` with grouped sections, timestamps, and branch-diff summary statistics.
- Updated `LICENSE.txt` formatting and copyright text.

## Summary Statistics

- Branch Name: `hendrik/rte-275-mf-pythontemplateit-general-updates-of-scripts-and`
- Number of Files Changed: `25`
- Insertions: `1794`
- Deletions: `1351`
- Files Changed: `.dockerignore`, `.flake8`, `.github/CODEOWNERS`, `.github/workflows/py-temp-pr-pub-no_docker-def.yaml`, `.github/workflows/py-temp-publish-pub-build_release_notify_after_merge-def.yaml`, `.github/workflows/py-temp-pypi-pub_with_docker-def.yaml`, `.gitignore`, `.junie/guidelines.md`, `.pre-commit-config.yaml`, `AGENTS.md`, `CreateDbSqlScript.ps1`, `Install.ps1`, `InstallDevEnv.ps1`, `LICENSE.txt`, `README.md`, `README.rst`, `ReleaseNotes.md`, `SetupDotEnv.ps1`, `SetupPrivateRepoAccess.ps1`, `docker-compose.yaml`, `legacy/.readthedocs.yaml`, `legacy/docs/requirements_docs.txt`, `poetry.lock`, `pyproject.toml`, `scripts/setup_db.sql`.

______________________________________________________________________

# Release 0.5.0

Release Date: 2026-02-20 02:18:38 +02:00

## CI/CD and Workflow Changes

- Replaced the Docker-based publish workflow with dedicated PR validation and post-merge release workflows: `.github/workflows/py-temp-pr-pub-no_docker-def.yaml` and `.github/workflows/py-temp-publish-pub-build_release_notify_after_merge-def.yaml`.
- Removed `.github/workflows/py-temp-pypi-pub_with_docker-def.yaml`.
- Removed `.github/CODEOWNERS` from this repository template.

## Tooling and Configuration Updates

- Added `.dockerignore`.
- Refreshed `.gitignore` patterns for local tooling and generated artifacts.
- Updated `.pre-commit-config.yaml` hook sources and versions, including Black mirror and legacy exclusions.
- Simplified `.flake8` by removing archive-specific excludes.
- Updated `pyproject.toml` and regenerated `poetry.lock`, including Python requirement alignment to `>=3.12`, URL metadata cleanup, and pytest legacy-path ignores.
- Added `.junie/guidelines.md` and `AGENTS.md` for repository automation guidance.

## Environment and Script Improvements

- Updated `Install.ps1` to bootstrap Poetry installation and configure remote access from environment tokens.
- Updated `InstallDevEnv.ps1` to run no-cache Poetry lock/install/update/sync flow and clearer pre-commit setup steps.
- Updated `SetupDotEnv.ps1` variable names and expanded generated `.env` content with Google credentials and pytest MySQL variables.
- Updated `SetupPrivateRepoAccess.ps1` to support repository-specific Poetry sources and conditional activation.
- Updated `CreateDbSqlScript.ps1` and `scripts/setup_db.sql` grants to use `GRANT ALL PRIVILEGES ... WITH GRANT OPTION`.
- Updated `docker-compose.yaml` environment variable mapping for local MySQL startup.

## Documentation and Licensing

- Reworked `README.md` into a structured guide covering prerequisites, quick start, scripts, release-note process, and active workflows.
- Removed `README.rst` in favor of the Markdown README.
- Updated `LICENSE.txt` formatting and copyright text.

## Summary Statistics

- Branch Name: `hendrik/rte-275-mf-pythontemplateit-general-updates-of-scripts-and`
- Number of Files Changed: `24`
- Insertions: `1721`
- Deletions: `1352`
- Files Changed: `.dockerignore`, `.flake8`, `.github/CODEOWNERS`, `.github/workflows/py-temp-pr-pub-no_docker-def.yaml`, `.github/workflows/py-temp-publish-pub-build_release_notify_after_merge-def.yaml`, `.github/workflows/py-temp-pypi-pub_with_docker-def.yaml`, `.gitignore`, `.junie/guidelines.md`, `.pre-commit-config.yaml`, `AGENTS.md`, `CreateDbSqlScript.ps1`, `Install.ps1`, `InstallDevEnv.ps1`, `LICENSE.txt`, `README.md`, `README.rst`, `SetupDotEnv.ps1`, `SetupPrivateRepoAccess.ps1`, `docker-compose.yaml`, `legacy/.readthedocs.yaml`, `legacy/docs/requirements_docs.txt`, `poetry.lock`, `pyproject.toml`, `scripts/setup_db.sql`.

______________________________________________________________________

# Release 0.3.0

- Removed .github/ISSUE_TEMPLATE/bugfix.md, .github/ISSUE_TEMPLATE/config.yaml, .github/ISSUE_TEMPLATE/enhancement.md, .github/ISSUE_TEMPLATE/hotfix.md and .github/ISSUE_TEMPLATE/release.md. Now contained in .github repository as default.
- Removed .github/workflows/02-ci.yaml and .github/03-build-and-publish-to-pypi.yaml. Replaced by reusable workflows.
- Added reusable workflow .github/workflow/py-temp-pypi-pub_with_docker-def.yaml
- Add sample Dockerfile
- Updated .gitignore, pre-commit-config.yaml, CreateDbSqlScript.ps1, docker-compose.yaml, InstallDevEnv.ps1, Licence.txt, pyproject.toml, SetupDotEnv.ps1, SetupGitHubAccess.ps1 and SetupPrivateRepo.ps1
- Added SetupDocker.ps1,
-

______________________________________________________________________

# Release 0.2.0

- Replaced current GitHub Workflows with reusable workflows.
- Update PowerShell scripts with screen displays.
- Docker
  - Correct Docker file configuration.
  - Upgrade Python to 3.13
- Update pyproject.toml

______________________________________________________________________

# Release 0.1.1

- Remove private repository PoetryPrivate from workflow in Poetry configuration to allow publishing to PyPI.

______________________________________________________________________

# Release 0.1.0

- Minor update to bugfix.md, hotfix.md, 00-deployment-pipeline.yaml
- Update to .pre-commit-config.yaml
- Add .rstcheck.cfg
- Add SetupPrivateRepoAccess.ps1
- Add InstallDevEnv.ps1 to automate the development environment installation.
- Add SetupDotEnv.ps1
- SetupGitHubAccess.ps1
- Alter the workflow structure
- Update Python Version to 3.13
- Reinstated Codecov in Workflow
- Update Poetry Config in 03-build-and-publish-to-pypi.yaml
- Add a md version of the README.
- Update README.rst.
- Move rst and md checks to Pre-Commit
- Add rst check configuration.
- Update Install.ps1.
- Update pyproject.toml

______________________________________________________________________

# Release 0.0.1

## General Changes

- Initial setup and configuration.

______________________________________________________________________
