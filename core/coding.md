# Coding Conventions

Language-agnostic rules. A stack file overrides this file where they conflict. The project's own linter/formatter config overrides both.

## Structure
- A function does one thing. If you need "and" to describe it, split it. Aim for under ~40 lines.
- Maximum nesting depth of 3. Use early returns and guard clauses.
- No magic numbers or strings. Use named constants.
- Consider splitting any file over ~300 lines.
- Prefer composition over inheritance. Prefer pure functions where practical.
- Do not duplicate logic a third time. Two copies are tolerable; three means extract.

## Naming
- Names describe intent, not type or implementation (`activeUsers`, not `list2`).
- Booleans read as questions: `isLoading`, `hasAccess`, `canEdit`.
- Functions are verbs, types and classes are nouns.
- No abbreviations except universal ones (`id`, `url`, `db`, `http`).
- Follow the language's casing convention (camelCase JS/TS, snake_case Python, PascalCase types and classes).

## Errors
- Never swallow errors silently. Catch only where you can actually handle the error.
- Error messages say what failed and with which input, never including secrets.
- Validate input at boundaries (API requests, forms, files, env vars, third-party responses). Trust typed internal values.
- Fail fast on invalid config at startup.

## Security
- No secrets in code or git history. Use environment variables and commit a `.env.example`.
- Parameterized queries only. Never build SQL by string concatenation.
- Treat all external input as untrusted. Escape output, never use `eval`-style execution.
- Least privilege for tokens, keys, and permissions.

## Comments
- Comment why, not what. If a comment explains what, rename or restructure instead.
- Delete commented-out code (git remembers).
- TODOs name an owner and context: `TODO(owner): handle pagination once API supports it`.

## Dependencies
- Prefer the standard library and existing dependencies before adding a new one.
- Commit the lockfile. Pin runtime versions (`.nvmrc`, `.python-version`, etc.).
- Check that a new dependency is maintained and has a compatible license.

## Logging
- Log at the right level (`error` = needs action, `warn` = unexpected but handled, `info` = key events, `debug` = diagnostics).
- Never log secrets, tokens, or personal data.
- No stray `console.log` / `print` debugging in committed code.
