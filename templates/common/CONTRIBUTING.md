# Contributing

## Setup
See the Quick start in `README.md`. A clean clone must run with the documented commands.

## Workflow
1. Branch from `main`: `type/short-description` (`feat/`, `fix/`, `docs/`, `refactor/`, `test/`, `chore/`).
2. Make one focused change. Add or update tests and docs in the same change.
3. Run lint, type check, and tests locally. CI runs the same checks.
4. Commit with Conventional Commits: `type(scope): subject`.
5. Open a pull request using the template. Keep it small and describe how you tested it.

## Standards
Code, testing, documentation, and security conventions live in `.claude/conventions/`. Those files apply to human contributors too.

## Decisions
Record significant architectural decisions as ADRs in `docs/adr/` (copy `0000-template.md`).

## Reporting security issues
Follow `SECURITY.md`. Do not use public issues.
