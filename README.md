# claude-conventions

Reusable markdown conventions for keeping code written with Claude (Claude Code and Claude Projects) consistent and at a professional standard.

## How it's layered

```
core/         Always applies: workflow, coding, testing, documentation, git/building, review checklist
stacks/       One per kind of project: web-frontend, mobile, python-backend (add your own)
templates/    CLAUDE.md, README, and ADR templates to copy into projects
scripts/      init-project.sh: sets a project up in one command
```

**Precedence when rules conflict:** the project's real tooling config (ESLint, ruff, tsconfig) > the project's own `CLAUDE.md` notes > the stack file > core.

## Use with Claude Code

```bash
./scripts/init-project.sh web-frontend ~/code/my-app
```

This copies `core/*.md` and the chosen stack into `my-app/.claude/conventions/` and creates a `CLAUDE.md` that imports them. Then open `CLAUDE.md`, fill in the project name, commands, and notes, and commit the whole thing.

Copies, rather than links, are on purpose: the project stays reproducible and a convention change here does not silently alter old projects. To update a project, re-run the script (it refreshes `.claude/conventions/` and leaves your `CLAUDE.md` alone).

Run `/memory` inside Claude Code to confirm the imported files are actually being loaded.

## Use with Claude Projects (claude.ai)

Upload everything in `core/` plus the one `stack.md` you need to the project's knowledge. Add a line to the project instructions such as: "Follow the uploaded conventions. Stack rules override core rules."

## Adding a new stack

1. `cp -r stacks/_template stacks/<new-stack>` (for example `ios-swift`, `node-api`, `data-science`)
2. Fill in `stack.md`. Keep it to roughly a page.
3. Run the init script with the new stack name.

## Keeping it good

- Every rule should be checkable in a code review. Cut anything vague.
- Keep each file to a page or two. Long rulebooks get partially ignored and cost context.
- When you correct Claude on the same thing twice, add a line.
- Enforce with tools (linters, formatters, CI, pre-commit) wherever possible. The markdown covers what tools cannot catch.
- Prune stale rules every so often.

The `stack.md` defaults (React, Expo, FastAPI) are starting points. Edit the sections marked **[edit]** to match what you actually use.
