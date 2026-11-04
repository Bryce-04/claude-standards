# Stack: Node API (TypeScript + Fastify)

Defaults for backend HTTP services in TypeScript. Swap Fastify for Express or NestJS by editing the sections marked **[edit]**. Overrides `core/` where they conflict.

## Tooling defaults **[edit]**
- Language: TypeScript with `strict: true`, Node LTS pinned in `.nvmrc`.
- Framework: Fastify (or Express/Hono).
- Validation and config: Zod, parsed once at startup for env vars.
- Database: PostgreSQL with a migration tool (Drizzle, Prisma, or Knex). Migrations are committed.
- Lint/format: ESLint + Prettier.
- Tests: Vitest with Supertest or the framework's inject helper.

## Code
- Layers: **routes** (HTTP only) call **services** (business logic) call **repositories** (data access). Routes never touch the database.
- Every request body, query, and params object is validated with a schema. Types are inferred from schemas, not written twice.
- Responses are explicit DTOs. Never return raw database rows.
- Errors: throw typed domain errors in services; map them to status codes in one error handler. Never leak stack traces to clients.
- No blocking work in request handlers. Move long jobs to a queue.
- `async` everywhere, no unhandled promise rejections, no floating promises.

## API design
- Resource-based URLs, plural nouns (`/users/:id`). Correct status codes (201 create, 204 empty, 400 invalid, 401/403 auth, 404, 409 conflict).
- Consistent error shape: `{ "error": { "code": "...", "message": "..." } }`.
- List endpoints are paginated with a hard maximum page size.
- Version breaking changes (`/v2/...`). Never change a released response shape silently.
- Publish an OpenAPI document generated from the schemas.

## Database
- Schema changes only through migrations. Never edit an applied migration.
- Migrations are backwards compatible for one release (add, then backfill, then drop).
- Index columns used in filters and joins. Use transactions for multi-step writes.

## Operations
- Structured JSON logs with a request ID. Never log bodies containing secrets or personal data.
- `/health` (liveness) and `/ready` (dependencies) endpoints.
- Graceful shutdown on `SIGTERM`. Timeouts on every outbound call.

## Structure
```
src/
  routes/
  services/
  repositories/
  schemas/      # Zod schemas and inferred types
  lib/          # config, logger, errors
  server.ts
migrations/
tests/
```

## Definition of done (additions to `review-checklist.md`)
- [ ] Input validated by schema; auth checked on the resource
- [ ] Migration included and reversible where practical
- [ ] OpenAPI output updated
- [ ] Tests cover success, validation failure, and auth failure
