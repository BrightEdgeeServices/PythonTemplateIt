# Repository Guidelines for Codex

You are an expert in Python and scalable web application development. You write secure, maintainable, and
performant code following Python best practices.

## Project Structure & Module Organization

- Core application code lives in `src/[repo]/` where "repo" is the name of the specific repo or according to the pyproject.toml
- The envorinment are driven by environment variables. The $env:PROJECT_DIR holds the base directory for all repos.
- Tests are in `tests/` (`unit/`, `functional`, `helpers/`, `test_data/`).
- Legacy/archived code is in `legacy/` and `tests/legacy/` (excluded from normal test runs).
- SQL/bootstrap assets are in `scripts/` and `data/`.

## Build, Test, and Development Commands

- `poetry install` installs project and dev dependencies.
- `poetry run python src/dma/main.py` runs the main downloader flow.
- `poetry run pytest` runs the active test suite.
- `poetry run pytest --cov=src --cov=tests --cov-report=term-missing` runs tests with coverage output.
- `poetry run black src tests` formats Python code.
- `poetry run isort src tests` sorts imports (Black-compatible profile).
- `poetry run flake8 src tests` runs lint checks.
- `poetry run pre-commit run --all-files` runs the same hooks used in CI.
- `.env` file is created by the `SetupDotEnv.ps1` in the repo root directory. Do not edit the `.env` file direct. Amend the `SetupDotEnv.ps1` script and then run it to update the `.env` file.
- External Docker is only used for functional (end-to-end) testing. Units test will create its own Docker container and
  database instance for testing.
- External Docker container is created by running the `SetUpDocker.ps1` script, which calls several other scripts. This script can be amended as needed.
- SQL/bootstrap assets are in `scripts/` and `data/`.

## Python Best Practices

- Follow PEP 8 with a 120-character line limit
- Use double quotes for Python strings
- Sort imports with `isort`
- Use f-strings for string formatting
- Methods, functions, and classes must always be sorted alphabetically on and in the relevant level.
- Only use CamelCase for class names.
- Use snake_case for everything other than class names.

**Explanation:**

- Double quotes are preferred by [Black](https://black.readthedocs.io/en/stable/the_black_code_style/current_style.html)
- [isort](https://github.com/PyCQA/isort) automatically sorts imports for you

## Testing

**General Guidelines**

- Use the `pytest` framework
- Pytest is configured in `pyproject.toml` (`testpaths = tests`, `pythonpath = src,tests`). `tests/legacy/` is intentionally ignored.
- Use `pytest-cov` to check test coverage
- Use `pytest-xdist` to run tests in parallel
- Use `pytest-sugar` to make the test output more readable
- Group multiple tests in a class
- The file name for the test is a combination of the module directory name in the dma directory and the module name in
  snake_case.
- The class test name is the name of the class in CamelCase.
- The test method name is the name of the test function followed by a description in snake_case.
- Tests must be named in the format `test_*.py`.
- Prefer deterministic unit tests
- Use fixtures from `tests/conftest.py` and `tests/test_data/`.
- Use the working_dir fixture to create a temporary directory for testing.
- Do not assign default values to any variable. If the actual value is not available, the code must crash.

**Unit Testing Guidelines**

- Always write unit tests for all new code and check that they pass for new features.
- Use `pytest-mock` to mock external dependencies for unit tests.
- Do not mock database connections ir sessions.
- Do not mock Google dependencies e.g. GoogleDriveManager. Use the
- Do not mick any functions within the module under test or in the same repo.
  tests.conftest.setup_self_destruct_urs_rating_files_def fixture.
- Each unit test must test a single functionality.
- Unit tests must only test the code in the relevant module.
- Unit tests must reside in the `tests/unit` directory.

**Functionality Testing Guidelines**

- Only write functional tests on request.
- Do not use `pytest-mock` to mock external dependencies for functional tests.
- Functional tests must test the integration of multiple modules.
- Functional tests must reside in the `tests/functional` directory.

## Security and Credentials

- Each repo have a `.env` file that contains the relevant environment variables, secrets and credentials for that repo.
- GitHub can be accessed by using the $env:GH_REPO_ACCESS_RTE_LOCAL_USER token
- The default port for MySQL are in the environment variable $env:MYSQL_TCP_PORT
- The default database name for MySQL are in the environment variable $env:MYSQL_DATABASE
- The default password for MySQL are in the environment variable $env:MYSQL_PASSWORD
- The default host for MySQL are in the environment variable $env:MYSQL_HOST
- The default user name for MySQL are in the environment variable $env:MYSQL_USER
- The default root password for MySQL are in the environment variable $env:MYSQL_ROOT_PASSWORD
