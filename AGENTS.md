# AGENTS.md

## Purpose

Project-specific instructions for Codex when working in this repository.

## Scope

These instructions apply to the entire repository rooted at this file.

## Repository

- Core application code lives in `src/[repo]/`.
- The environment is driven by environment variables. The $env:PROJECT_DIR holds the base directory for each repo.
- Tests are in `tests/` (`unit/`, `e2e/`, `helpers/`, `test_data/`).
- Legacy/archived code is in `legacy/` and `tests/legacy/` (excluded from normal test runs).
- SQL/bootstrap assets are in `scripts/` and `data/`.

## Working norms

- Prefer minimal, targeted edits over broad refactoring.
- Do not change behaviour unless explicitly requested.
- Keep naming, code style, and structure consistent with nearby files.
- If requirements are unclear, ask before making irreversible changes.

## Safety

- Each repo has a `.env` file that contains the relevant environment variables, secrets, and credentials for that repo.
- Never commit secrets or API keys.
- Do not modify deployment or infrastructure config unless asked.
- Avoid destructive git operations unless explicitly requested.
- GitHub can be accessed by using the $env:GH_REPO_ACCESS_RTE_LOCAL_USER token

## Environment Variables

- The default port for MySQL is in the environment variable $env:MYSQL_TCP_PORT
- The default database name for MySQL is in the environment variable $env:MYSQL_DATABASE
- The default password for MySQL is in the environment variable $env:MYSQL_PASSWORD
- The default host for MySQL are in the environment variable $env:MYSQL_HOST
- The default user name for MySQL is in the environment variable $env:MYSQL_USER
- The default root password for MySQL is in the environment variable $env:MYSQL_ROOT_PASSWORD

## Build, Test, and Development Commands

- `poetry install` installs project and dev dependencies.
- `poetry run python src/ums/main.py` starts the service.
- `poetry run pytest` runs the active test suite.
- `poetry run pytest --cov=src --cov=tests --cov-report=term-missing` runs tests with coverage output.
- `poetry run black src tests` formats Python code.
- `poetry run isort src tests` sorts imports (Black-compatible profile).
- `poetry run flake8 src tests` runs lint checks.
- `poetry run pre-commit run --all-files` runs the same hooks used in CI.
- `.env` file is created by the `SetupDotEnv.ps1` in the repo root directory. Do not edit the `.env` file direct. Amend
  the `SetupDotEnv.ps1` script and then run it to update the `.env` file.

## Docker

If a docker configuration is present:

- An external Docker is used for end-to-end testing.
- Units test creates its own Docker container and database instance for testing.
- IF in a Windows environment, the external Docker container is created by running the `SetUpDocker.ps1` script, which calls several other scripts. This
  script can be amended as needed. BE careful, this will destroy the database and might not be desirable. Ask before running this script.
- SQL/bootstrap assets are in `scripts/` and `data/`.

## Testing for Python

**General Guidelines**

- Use the `pytest` framework
- Pytest is configured in `pyproject.toml` (`testpaths = tests`, `pythonpath = src,tests`).
- Group multiple tests in a class
- The file name for the test is a combination of the module directory name in the dma directory and the module name in
  snake_case.
- The class test name is the name of the class in CamelCase.
- The test method name is the name of the test function followed by a description in snake_case.
- Tests must be named in the format `test_*.py`.
- Prefer deterministic unit tests
- Use fixtures from `tests/conftest.py` and `tests/test_data/fixture_data.py`.
- Do not assign default values to any variable. If the actual value is not available, the code must crash.

**Unit Testing Guidelines**

- Always write at least one positive unit test for all new functions and check that they pass for new features.
- Use `pytest-mock` to mock external dependencies for unit tests.
- Never mock database connections or sessions.
- Never mock Google dependencies e.g. GoogleDriveManager.
- Never mock any functions within the same repo.
- Each unit test must test a single functionality.
- Unit tests must only test the code in the relevant module.
- Unit tests must reside in the `tests/unit` directory.

**end-to-end Testing Guidelines**

- Only write e2e tests on request.
- Do not use `pytest-mock` to mock external dependencies for e2e tests, unless absolutely necessary.
- e2e tests must test the full functionality of the module.
- e2e tests must test the integration of relevant modules.
- e2e tests must reside in the `tests/e2e` directory.

## Output expectations

- Provide a short summary of what changed and why.
- Include file paths for modified files.
- Call out risks, assumptions, and next steps when relevant.

## Workflow Orchestration

### 1. Plan Mode Default

- Enter plan mode for ANY non-trivial task (3+ steps or architectural decisions)
- If something goes sideways, STOP and re-plan immediately; don't keep pushing
- Use plan mode for verification steps, not just building
- Write detailed steps to reduce ambiguity
- Plan in small steps that are broken up that can be given to an LLM
- When asked to plan, look for a rondfok file within the project you are working on, and create a .md file in there containing the plan

### 2. Subagent Strategy

- Use subagents liberally to keep the main context window clean
- Offload research, exploration, and parallel analysis to subagents
- For complex problems, throw more at it via subagents
- One task per subagent for focused execution

### 3. Self-Improvement Loop

- After any correction from the user: update `tasks/lessons.md` with the pattern
- Write rules for yourself that prevent the same mistake
- Ruthlessly iterate on these lessons until the mistake rate drops
- Review lessons at session start for a relevant project

### 4. Verification Before Done

- Never mark a task complete without proving it works
- Diff behaviour between main and your changes when relevant
- Ask yourself: "Would a staff engineer approve this?"
- Run tests, check logs, demonstrate correctness

### 5. Demanding Elegance (Balanced)

- For non-trivial changes: pause and ask "is there a more elegant way?"
- If a fix feels hacky: "Knowing everything I know now, implement the elegant solution"
- Skip this for simple, obvious fixes; don't overengineer
- Challenge your own work before presenting it

### 6. Autonomous Bug Fixing

- When given a bug report: fix it. Don't ask for hand-holding
- Point at logs, errors, failing tests; then resolve them
- Zero context switching required from the user
- Go fix failing CI tests without being told

## Task Management

1. **Plan First**: Write plan to `tasks/todo.md` with checkable items
1. **Verify Plan**: Check in before starting implementation
1. **Track Progress**: Mark items complete as you go
1. **Explain Changes**: High-level summary at each step
1. **Document Results**: Add a review section to `tasks/todo.md`
1. **Capture Lessons**: Update `tasks/lessons.md` after corrections

## Core Principles

- **Simplicity First**: Make every change as simple as possible. Impact minimal code.
- **No Laziness**: Find root causes. No temporary fixes. Senior developer standards.
- **Minimal Impact**: Changes should only touch what's necessary. Avoid introducing bugs.

## Python Standards

- Follow PEP 8 with a 120-character line limit
- Add docstrings for new Python functions.
- Add brief comments for complex code that is not easily understandable.
- Use double quotes for Python strings
- Use f-strings for string formatting
- Methods, functions, and classes must always be sorted alphabetically on and in the relevant level.
- Only use CamelCase for class names.
- Use snake_case for everything other than class names.

## Logging Standards

- Add useful and clear log statements for debugging at `trace` or `debug` level where appropriate.
- Use the file-handler logger patterns already established in the project.
- Log errors or warnings when exceptions occur.
- Do not include stack traces unless explicitly required; log the error itself.
