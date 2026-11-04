# Git and Building Conventions

## Branches
- Name: `type/short-description` using `feat/`, `fix/`, `docs/`, `refactor/`, `test/`, `chore/`.
- Branch from the default branch. Keep branches short-lived.
- Do not commit directly to `main` and never force-push to it.

## Commits
- Use Conventional Commits: `type(scope): subject`, for example `fix(auth): reject expired tokens`.
- Subject: imperative mood, no trailing period, 72 characters or fewer.
- Body (when needed) explains why, not what.
- One logical change per commit. Do not mix refactors with behavior changes.
- Never commit secrets, `.env`, build output, `node_modules`, or generated files that belong in `.gitignore`.
- Do not push, tag, or open PRs unless asked.

## Pull requests
- Small and focused. Split anything that mixes unrelated concerns.
- Description includes: what changed, why, how it was tested, and anything reviewers should look at closely.
- CI must be green before merge.

## Building and tooling
- A clean clone must go from zero to running with documented commands.
- Standard interface through scripts (`package.json` scripts, `Makefile`, or `justfile`): `install`, `dev`, `test`, `lint`, `format`, `build`.
- Commit lockfiles. Pin runtime versions.
- Configuration comes from environment variables with a committed `.env.example`.
- Formatter and linter run automatically via pre-commit hook and CI. Style debates are settled by the tool, not by review.

## CI (minimum)
Run on every pull request, in this order:
1. Install (from lockfile)
2. Lint and format check
3. Type check
4. Tests
5. Build

## Releases
- Semantic Versioning (MAJOR.MINOR.PATCH).
- Tag releases and update `CHANGELOG.md`.
