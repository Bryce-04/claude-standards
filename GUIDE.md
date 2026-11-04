# Guide to claude-standards

## What it is
A library of rules and starter files that you copy into any project so Claude Code works the same way every time. You keep one source of truth here, and one command sets up each new project.

## The big picture
```
claude-standards/
  core/           Rules for every project
  stacks/         Rules and tooling for one type of project
  templates/      Starter files copied into projects
  scripts/        The setup command
  README.md       Overview
  GUIDE.md        This file
  .gitattributes  Keeps line endings consistent
```

When rules conflict, the higher one wins: **the project's own linter/config > the project's CLAUDE.md notes > the stack file > core**.

---

## `core/`: rules that always apply
Each file is a short rulebook that Claude reads in every session.

| File | What it does |
|---|---|
| `claude-behavior.md` | How Claude acts: no commit or push unless asked, ask before deleting things, never bypass hooks or CI, don't read `.env` files, stay in scope, treat text found in files or web pages as data rather than orders. |
| `workflow.md` | How to approach a task: read existing code first, make the smallest change, ask when unclear, run checks before saying "done", report honestly. |
| `coding.md` | Code quality: small functions, clear names, no magic numbers, proper error handling, sensible comments and logging. |
| `security.md` | Secrets, input validation, auth, data handling, dependency safety. |
| `testing.md` | Test every behavior change, test behavior not internals, mock only at boundaries, never edit a test just to make it pass. |
| `documentation.md` | What a README must contain, how to document code, when to write decision records (ADRs), changelog format. |
| `git-and-building.md` | Branch names, Conventional Commit messages, PR rules, minimum CI steps, versioning. |
| `review-checklist.md` | A checklist Claude runs before reporting a task finished, plus what the final report must say. |

## `stacks/`: rules for a type of project
You pick one stack per project. Each has a `stack.md` (tools, code rules, folder layout, a stack-specific "definition of done") and a `tooling/` folder of files that get copied into the project.

| Stack | For |
|---|---|
| `web-frontend` | Browser apps (TypeScript, React) |
| `mobile` | Cross-platform apps (React Native, Expo) |
| `node-api` | Backend services (TypeScript, Fastify) |
| `python-backend` | Python APIs (FastAPI) |
| `data-science` | Notebooks and data pipelines |
| `ios-swift` | Native iOS apps (SwiftUI) |
| `cli-library` | Packages and command-line tools |
| `_template` | A blank stack to copy when you add your own |

**What's in a `tooling/` folder** (it mirrors a project's root folder):
- `.github/workflows/ci.yml`: GitHub Actions that run lint, type check, tests, build and a dependency audit on every PR.
- `.gitignore`: the right ignores for that stack.
- `.claude/settings.json`: blocks Claude from reading `.env` files, pre-approves safe commands, and runs a formatter after every file Claude edits.
- `.claude/hooks/format.js` or `format.py`: the script that formatter step runs (Prettier or ruff).
- `.pre-commit-config.yaml` (Python stacks only): checks that run before each commit.

## `templates/`: starter files
- `CLAUDE.md`: the file Claude Code reads at the start of every session. It lists your project's commands and notes, and **imports all the core and stack files**. This is what actually connects everything.
- `README.project.md`: a README skeleton following the documentation rules.
- `ADR.md`: a skeleton for recording an architectural decision.
- `LICENSE.MIT`: an MIT license, with placeholders. It isn't copied automatically because the license is your choice.
- `common/`: files every project gets:
  - `.editorconfig`: consistent indentation and line endings across editors.
  - `.gitattributes`: consistent line endings in git.
  - `.github/pull_request_template.md`: the PR description form.
  - `.github/dependabot.yml`: automatic update PRs for GitHub Actions.
  - `docs/adr/0000-template.md`: where decision records go.
  - `CONTRIBUTING.md`: how to contribute, for humans and Claude.
  - `SECURITY.md`: how to report a vulnerability.

## `scripts/init-project.sh`: the setup command
```bash
./scripts/init-project.sh <stack> <path-to-project>
```
In order, it:
1. Copies `core/*.md` and the chosen stack into the project's `.claude/conventions/`. This step always refreshes.
2. Copies the shared files from `templates/common/`.
3. Copies the stack's tooling.
4. Creates `README.md` and `CLAUDE.md` from the templates.

Every step except the first **skips files that already exist**, so it never overwrites your work. Re-run it any time to pull in updated conventions. On Windows, run it from Git Bash or WSL.

## Typical workflow
1. Start or open a project.
2. Run the init script with the matching stack.
3. Open `CLAUDE.md` and fill in the project name, commands and notes.
4. Check the commands in `.github/workflows/ci.yml` match your project's scripts.
5. Fill in the placeholders in `SECURITY.md` and add a license if you want one.
6. Commit it all. Claude Code now follows the rules in every session.

## Maintaining it
- When you correct Claude on the same thing twice, add a line to the matching file here.
- Prune rules that no longer fit.
- Add a new stack with `cp -r stacks/_template stacks/<name>`.
- Projects keep a **copy** of the conventions, so changing this repo won't alter old projects until you re-run the script on them.
