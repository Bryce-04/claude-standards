# Working Agreement

How to approach any task, in any project.

## Before coding
- Read the relevant code and the project's existing config first. Match what is already there.
- If the request is ambiguous or has a major design fork, ask one focused question before building. For small ambiguities, pick the sensible default and say which one you picked.
- For a change that touches several files, write a short plan first (files to touch, order, risks) and then proceed. Do not wait for approval unless the plan hits a stop condition.
- Stop and ask before continuing if the plan includes: a real design fork with no obvious default, a change to a public interface, API contract, or data schema, a migration or data deletion, or a new dependency.

## While coding
- Make the smallest change that fully solves the task.
- Do not refactor unrelated code. List it under "Noticed" in your report instead.
- Work in small steps and run the project's checks between steps.
- Do not add a dependency without saying why and asking first.

## Large or multi-file changes
- Split the work into slices that each leave the project working (builds, tests pass). Finish and verify one slice before starting the next.
- Keep a short checklist of the slices and tick them off as you go, so progress survives a long session.
- Do the riskiest or most uncertain slice first, so surprises show up early.
- Run the project's checks after every slice, not only at the end.
- Keep each slice commit-ready: one logical change that could be reviewed on its own. Only commit if asked.
- If you discover the plan was wrong midway, say so, update the plan, and continue. Do not silently drift.
- Re-read the changed files at the end, and report the slices completed, the ones skipped, and anything left unverified.

## Before saying "done"
- Run the formatter, linter, type checker, and tests (commands are in the project's `CLAUDE.md`). Fix every failure you caused.
- Walk through `review-checklist.md`.

## Reporting
- State what changed, what you ran and what it showed, and anything you did not verify.
- Never claim something works unless you ran it.
- If you are blocked, or a check fails and you cannot fix it, say so plainly.
- Never make errors disappear by deleting tests, disabling lint rules, or silencing the type checker (`any`, `# type: ignore`, `@ts-ignore`) without explaining why and getting approval.
