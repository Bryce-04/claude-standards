# claude-conventions

Reusable markdown conventions for keeping code written with Claude (Claude Code and Claude Projects) consistent and at a professional standard.

New here? Read [GUIDE.md](GUIDE.md) for a plain explanation of every part of this repo.

## How it's layered

```
core/         Always applies: Claude behavior, workflow, coding, security, testing, documentation, git/building, review checklist
stacks/       One per kind of project: web-frontend, mobile, node-api, python-backend,
              data-science, ios-swift, cli-library (add your own)
templates/    CLAUDE.md, README, and ADR templates to copy into projects
scripts/      init-project.sh: sets a project up in one command
```

Each stack folder can also hold a `tooling/` directory that mirrors a project root (CI workflow, `.gitignore`, Claude Code settings and formatter hook). `templates/common/` holds files every project gets (`.editorconfig`, PR/ADR templates, `CONTRIBUTING.md`, `SECURITY.md`, Dependabot config). `templates/LICENSE.MIT` is not copied automatically because the license is your choice..

**Precedence when rules conflict:** the project's real tooling config (ESLint, ruff, tsconfig) > the project's own `CLAUDE.md` notes > the stack file > core.

## Use with Claude Code

```bash
./scripts/init-project.sh web-frontend ~/code/my-app
```

This does four things:

1. Copies `core/*.md` and the chosen stack into `my-app/.claude/conventions/`.
2. Copies shared files and the stack's tooling (CI workflow, `.gitignore`, `.editorconfig`, PR and ADR templates, `.claude/settings.json` with a format-on-edit hook).
3. Creates `README.md` and a `CLAUDE.md` that imports the conventions.
4. Skips any file that already exists, so it never overwrites your project's own files.

Then fill in `CLAUDE.md` and `README.md`, check that the commands in `.github/workflows/ci.yml` match your package scripts, and commit.

On Windows, run the script from Git Bash or WSL.

Copies, rather than links, are on purpose: the project stays reproducible and a convention change here does not silently alter old projects. To update a project, re-run the script. It refreshes `.claude/conventions/` and leaves everything else alone.

Run `/memory` inside Claude Code to confirm the imported files are actually being loaded.

## Use with Claude Projects (claude.ai)

Upload everything in `core/` plus the one `stack.md` you need to the project's knowledge. Add a line to the project instructions such as: "Follow the uploaded conventions. Stack rules override core rules."

## Adding a new stack

1. `cp -r stacks/_template stacks/<new-stack>` (for example `ios-swift`, `node-api`, `data-science`)
2. Fill in `stack.md`. Keep it to roughly a page.
3. Optionally add `tooling/` next to it (CI, `.gitignore`, `.claude/settings.json`) laid out like a project root.
4. Run the init script with the new stack name.

## Keeping it good

- Every rule should be checkable in a code review. Cut anything vague.
- Keep each file to a page or two. Long rulebooks get partially ignored and cost context.
- When you correct Claude on the same thing twice, add a line.
- Enforce with tools (linters, formatters, CI, pre-commit) wherever possible. The markdown covers what tools cannot catch.
- Prune stale rules every so often.

The `stack.md` defaults (React, Expo, FastAPI) are starting points. Edit the sections marked **[edit]** to match what you actually use.
