# Stack: Python Backend (FastAPI)

Defaults for Python web APIs and services. Swap FastAPI for Django or Flask by editing the sections marked **[edit]**. Overrides `core/` where they conflict.

## Tooling defaults **[edit]**
- Python 3.12+ (pin in `.python-version` and `pyproject.toml`).
- Package/env management: `uv` (or Poetry). Dependencies live in `pyproject.toml` with a committed lockfile.
- Lint/format: `ruff` (lint and format). Types: `mypy` or `pyright` in strict-ish mode.
- Tests: `pytest` with `pytest-cov`.
- Validation/config: Pydantic and `pydantic-settings`.
- Migrations: Alembic (or the ORM's built-in tool).

## Code
- Type hints on all function signatures. No bare `Any` without a reason.
- Follow PEP 8 naming (`snake_case` functions, `PascalCase` classes). Imports sorted by ruff.
- Layered structure: **routes** (HTTP only) call **services** (business logic) call **repositories** (data access). Routes never touch the database directly.
- Request and response bodies are Pydantic models. Never return raw ORM objects.
- Use dependency injection (FastAPI `Depends`) for DB sessions, settings, and auth.
- Use `async` consistently. Do not call blocking code inside async handlers.
- Raise domain-specific exceptions in services; translate them to HTTP responses in one place (exception handlers).
- Use `pathlib`, f-strings, context managers, and dataclasses/Pydantic over ad hoc dicts.

## Structure
```
src/app/
  api/          # routers
  services/
  repositories/
  models/       # ORM models
  schemas/      # Pydantic schemas
  core/         # config, logging, security
tests/          # mirrors src/app
migrations/
```

## Configuration and security
- All config via `pydantic-settings` from environment variables. Fail at startup if required values are missing.
- Hash passwords with a modern algorithm (argon2 or bcrypt). Never store plaintext.
- Authenticate and authorize every non-public endpoint. Check permissions in services, not only routes.
- Use parameterized queries via the ORM. Set CORS explicitly, not `*`, in production.
- Rate-limit public endpoints.

## Logging and errors
- Structured logging (JSON in production) with request IDs. No `print`.
- Consistent error response shape (`{"error": {"code": "...", "message": "..."}}`).
- Health check endpoint at `/health`.

## Testing
- Unit tests for services with fakes. Integration tests for routes against a real test database (transaction rollback per test).
- Use `pytest` fixtures and parametrization. Use `freezegun` or a clock fixture for time.
- Test auth paths: unauthenticated, unauthorized, and authorized.

## Docs
- FastAPI generates OpenAPI. Give every route a summary, response models, and documented error responses.
- Google-style docstrings on public services and utilities.

## Definition of done (additions to `review-checklist.md`)
- [ ] `ruff check`, `ruff format --check`, type checker, and `pytest` all pass
- [ ] Migration included and reversible if the schema changed
- [ ] New endpoint documented and has auth tests
