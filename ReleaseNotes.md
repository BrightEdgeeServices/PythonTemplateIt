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
