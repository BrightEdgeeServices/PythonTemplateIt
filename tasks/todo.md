- [x] Inspect the current branch against `master` and capture the relevant change set, file list, and diff statistics.
- [x] Add a new release entry at the top of `ReleaseNotes.md` that matches the established format, includes a Johannesburg timestamp, groups the changes under appropriate headings, excludes the deleted `dummy.txt` chore, and ends with a divider.
- [x] Bump the project version in `pyproject.toml` using SemVer based on the branch diff.
- [x] Update `README.md` with new relevant information while keeping the required Markdown sections in place.
- [x] Review the final diffs and add a short review section summarizing validation results and any assumptions.

## Review

- Verified the new release section starts at the top of `ReleaseNotes.md` and keeps the timestamp on line 3.
- Verified the branch statistics from `git diff --numstat master...HEAD -- . ':(exclude)dummy.txt'`: 14 files changed, 613 insertions, 613 deletions.
- Verified `dummy.txt` is omitted from the release notes and statistics list.
- Verified the project version was bumped from `0.6.0` to `0.7.0` in `pyproject.toml`.
- Verified `README.md` still contains the required Markdown sections and now documents `InstallPy.ps1`, `InstallReact.ps1`, `install_react.sh`, and the `src/pti/` package layout.
