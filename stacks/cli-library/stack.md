# Stack: CLI and Library (TypeScript or Python)

Defaults for reusable packages and command-line tools. Examples use TypeScript/npm; for Python use `pyproject.toml`, `ruff`, `pytest`, and `uv build`. Edit the sections marked **[edit]**. Overrides `core/` where they conflict.

## Tooling defaults **[edit]**
- Language: TypeScript `strict: true` (or Python 3.12+ with type hints).
- Build: `tsup` or `tsc` (Python: `uv build`).
- Lint/format: ESLint + Prettier (Python: ruff).
- Tests: Vitest (Python: pytest).
- Publish: npm with provenance (Python: PyPI trusted publishing).

## Public API
- The public API is exactly what the entry point exports. Everything else is private and free to change.
- Keep the surface small. Every export is a promise you must keep.
- Document every exported symbol with purpose, parameters, return value, errors, and an example.
- Prefer one options object over long positional parameter lists.
- Do not expose internal types, errors from dependencies, or mutable internal state.

## Versioning and compatibility
- Strict Semantic Versioning. Removing or changing an export, or changing behavior callers rely on, is a MAJOR bump.
- Deprecate before removing: mark deprecated, document the replacement, keep it for at least one MINOR release.
- Every release updates `CHANGELOG.md` and is tagged.
- Declare supported runtime versions (`engines` / `requires-python`) and test them in CI.
- Minimize dependencies. Each one is inherited by every consumer.

## CLI behavior
- `--help` and `--version` always work. Help text has usage and examples.
- Exit code `0` on success, non-zero on failure. Errors go to stderr, results to stdout.
- Support non-interactive use: no prompts when stdin is not a TTY, `--yes` to skip confirmation, `--json` for machine-readable output.
- Destructive operations require confirmation or `--force`, and support `--dry-run`.
- Error messages say what failed, why, and how to fix it.

## Packaging
- Ship only what is needed (`files` allowlist, or sdist/wheel config). Verify with `npm pack --dry-run`.
- Install and run the built package in CI from a clean directory, not just from source.
- Never publish from a developer machine. Publish from CI on a tag.

## Structure
```
src/
  index.ts      # the public API, exports only
  cli.ts        # argument parsing, thin wrapper over the library
  core/         # implementation
tests/
```
Keep the CLI a thin layer over library functions so the logic is testable without spawning processes.

## Definition of done (additions to `review-checklist.md`)
- [ ] No unintended change to the public API (check the diff of exports)
- [ ] Changelog entry; version bump matches the change type
- [ ] Docs and examples still run
