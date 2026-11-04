# Security Conventions

Applies to every project. A stack file may add rules but not relax these.

## Secrets
- No secrets in code, tests, fixtures, logs, or git history. Use environment variables and commit a `.env.example` with fake values.
- Never read, print, or paste the contents of `.env` files or key files into a response, commit, or issue.
- If a secret is committed, treat it as leaked: rotate it first, then clean history.
- Use separate credentials per environment. Least privilege for every token, key, and role.

## Input and output
- Treat all external input (requests, files, env vars, webhooks, third-party responses, LLM output) as untrusted. Validate at the boundary with a schema.
- Parameterized queries only. Never build SQL, shell commands, or file paths by string concatenation with user input.
- Escape or encode output for its context (HTML, SQL, shell, URL). No `eval`-style execution of dynamic strings.
- Validate file uploads: type, size, and name. Store them outside the web root.

## Authentication and authorization
- Do not write your own crypto or auth. Use the framework's or a vetted library.
- Hash passwords with a slow algorithm (argon2, bcrypt, scrypt). Never store or log plaintext.
- Check authorization on the server for every request, on the resource being accessed, not just at login.
- Sessions and tokens expire. Cookies are `HttpOnly`, `Secure`, and `SameSite`.
- Rate-limit login, password reset, and other abuse-prone endpoints.

## Data
- Collect and store only the personal data you need. Never log it.
- Encrypt in transit (HTTPS/TLS only). Encrypt sensitive data at rest.
- Error responses to clients never include stack traces, SQL, or internal paths.

## Dependencies and supply chain
- Run the ecosystem audit (`npm audit`, `pip-audit`, `cargo audit`) in CI. Fix or document high and critical findings.
- Enable automated dependency updates (Dependabot or Renovate) and review them like any other change.
- Pin versions with a lockfile. Install from the lockfile in CI.
- Prefer well-maintained packages. Be wary of new packages with names similar to popular ones.

## Reporting
- Every project has a `SECURITY.md` saying how to report a vulnerability privately (see `templates/common/SECURITY.md`).
- Security fixes ship with a regression test.
