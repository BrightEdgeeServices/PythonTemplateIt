# Release 0.8.0

Release Date: 2026-03-28 09:48:46 +02:00

## Packaging and Dependency Updates

- Moved the published template module from `src/pythontemplateit.py` to `src/pti/pythontemplateit.py`, updated `pyproject.toml` package declarations, and aligned `tests/test_pytontemplateit.py` to import through `pti`.
- Regenerated `poetry.lock` after refreshing the project metadata, dependency declarations, and development tooling package set.

## Tooling and Repository Automation

- Added `.github/dependabot.yaml` coverage for Poetry, GitHub Actions, and Docker version updates.
- Updated `.github/workflows/py-temp-publish-pub-build_release_notify_after_merge-def.yaml` so Dependabot merges do not trigger the post-merge release/publish workflow.
- Refreshed `.gitignore` and `.pre-commit-config.yaml` for workspace artifacts, LF-normalized Markdown formatting, the end-of-file fixer, consistent `legacy/` exclusions, and the removal of the active `rstcheck` hook configuration.
- Removed `.readthedocs.yaml`, `.rstcheck.cfg`, and the root `Dockerfile` as part of the repository tooling and documentation cleanup.
- Expanded `AGENTS.md` and refreshed `README.md` and `ReleaseNotes.md` to match the updated workflow, packaging, and release-management conventions.

## Environment and Local Service Updates

- Renamed `Install.ps1` to `InstallPy.ps1`.
- Added `InstallReact.ps1` and `install_react.sh` to bootstrap React and Node dependencies, retry npm installs with legacy peer dependency handling, and install pre-commit hooks when available.
- Hardened `SetupDotEnv.ps1` so `.env` is generated from the repository root, required environment variables must be present, and the generated file includes the expanded service and logging configuration set.
- Updated `SetupPrivateRepoAccess.ps1` to use a repository-local Poetry temp directory when needed, adjust repository activation defaults, and include `sample_data_factory` in the managed source list.
- Updated `SetUpDocker.ps1` and `docker-compose.yaml` to start the stack with `docker compose up -d`, tune the MySQL container, add service health checks, and provision a Redis container for local workflows.

## Summary Statistics

- Branch Name: `hendrik/wip_ever_green_branch`
- Number of Files Changed: `22`
- Insertions: `915`
- Deletions: `656`
- Files Changed: `.github/dependabot.yaml`, `.github/workflows/py-temp-publish-pub-build_release_notify_after_merge-def.yaml`, `.gitignore`, `.pre-commit-config.yaml`, `.readthedocs.yaml`, `.rstcheck.cfg`, `AGENTS.md`, `Dockerfile`, `Install.ps1 => InstallPy.ps1`, `InstallReact.ps1`, `README.md`, `ReleaseNotes.md`, `SetUpDocker.ps1`, `SetupDotEnv.ps1`, `SetupPrivateRepoAccess.ps1`, `docker-compose.yaml`, `install_react.sh`, `poetry.lock`, `pyproject.toml`, `src/pythontemplateit.py => src/pti/pythontemplateit.py`, `tasks/todo.md`, `tests/test_pytontemplateit.py`.

______________________________________________________________________

# Release 0.7.0

Release Date: 2026-03-09 22:16:32 +02:00

## Packaging and Module Layout

- Moved the template module from `src/pythontemplateit.py` to `src/pti/pythontemplateit.py`, updated `pyproject.toml` package metadata, and aligned `tests/test_pytontemplateit.py` to import through `pti`.
- Regenerated `poetry.lock` to reflect the package layout and dependency configuration updates.

## Tooling and Documentation Configuration

- Refreshed `.gitignore` patterns for local tooling, generated artifacts, and workspace-specific directories.
- Updated `.pre-commit-config.yaml` to normalize Markdown files to LF line endings, add the end-of-file fixer, exclude `legacy/` consistently, and disable the active `rstcheck` hook configuration.
- Removed `.readthedocs.yaml` and `.rstcheck.cfg` as part of the Markdown-first documentation and tooling cleanup.
- Expanded `AGENTS.md` with repository-specific guidance for workflow orchestration, testing, safety, and task management.

## Environment and Installer Script Updates

- Renamed `Install.ps1` to `InstallPy.ps1`.
- Added `InstallReact.ps1` and `install_react.sh` to support Node and React dependency bootstrapping, fallback npm install modes, and optional pre-commit setup.
- Hardened `SetupDotEnv.ps1` so required environment variables must be present before generating `.env`, and expanded the generated variable set.
- Updated `SetupPrivateRepoAccess.ps1` to change repository activation defaults and add `sample_data_factory` to the managed repository list.

## Summary Statistics

- Branch Name: `hendrik/wip_ever_green_branch`
- Number of Files Changed: `14`
- Insertions: `613`
- Deletions: `613`
- Files Changed: `.gitignore`, `.pre-commit-config.yaml`, `.readthedocs.yaml`, `.rstcheck.cfg`, `AGENTS.md`, `Install.ps1 => InstallPy.ps1`, `InstallReact.ps1`, `SetupDotEnv.ps1`, `SetupPrivateRepoAccess.ps1`, `install_react.sh`, `poetry.lock`, `pyproject.toml`, `src/pythontemplateit.py => src/pti/pythontemplateit.py`, `tests/test_pytontemplateit.py`.

______________________________________________________________________

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
