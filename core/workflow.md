# Working Agreement

How to approach any task, in any project.

## Before coding
- Read the relevant code and the project's existing config first. Match what is already there.
- If the request is ambiguous or has a major design fork, ask one focused question before building. For small ambiguities, pick the sensible default and say which one you picked.
- If the change touches more than ~3 files or any public interface, outline the plan first and wait for a go-ahead.

## While coding
- Make the smallest change that fully solves the task.
- Do not refactor unrelated code. List it under "Noticed" in your report instead.
- Work in small steps and run the project's checks between steps.
- Do not add a dependency without saying why and asking first.

## Before saying "done"
- Run the formatter, linter, type checker, and tests (commands are in the project's `CLAUDE.md`). Fix every failure you caused.
- Walk through `review-checklist.md`.

## Reporting
- State what changed, what you ran and what it showed, and anything you did not verify.
- Never claim something works unless you ran it.
- If you are blocked, or a check fails and you cannot fix it, say so plainly.
- Never make errors disappear by deleting tests, disabling lint rules, or silencing the type checker (`any`, `# type: ignore`, `@ts-ignore`) without explaining why and getting approval.
