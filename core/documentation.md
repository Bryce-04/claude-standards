# Documentation Conventions

Docs change in the same commit as the code they describe.

## Three layers
1. **README**: what it is and how to run it.
2. **Code docs**: how to use a function, class, or module.
3. **Decision records**: why it is built this way.

## README (required in every project)
Sections, in this order:
1. **Title and one-sentence description**
2. **Quick start**: copy-pasteable commands that work on a clean clone
3. **Configuration**: every environment variable, with purpose and an example (never real secrets)
4. **Scripts / commands**: install, dev, test, lint, build
5. **Project structure**: a short tree with one line per top-level folder
6. **Testing**: how to run tests and what kinds exist
7. **Deployment** (if applicable)
8. **Contributing / license**

Verify every command in the README by running it. Do not document commands you have not run.

## Code documentation
- Document every public function, class, and module: purpose, parameters, return value, errors thrown, and a short example when usage is not obvious.
- Use the language's native format (JSDoc/TSDoc, Python docstrings in Google style, KDoc, etc.).
- Skip docs for trivial private helpers. Good names beat comments.
- Generate API reference from source where possible (OpenAPI, TypeDoc, Sphinx). Do not hand-maintain what a tool can generate.

## Decision records (ADRs)
- Store in `docs/adr/NNNN-short-title.md` (see `templates/ADR.md`).
- Write one when choosing a framework, database, auth approach, or anything costly to reverse.
- Sections: Context, Decision, Alternatives considered, Consequences.
- Never edit an accepted ADR to change history. Supersede it with a new one.

## Changelog
- Keep `CHANGELOG.md` in the Keep a Changelog format (Added, Changed, Fixed, Removed) with an `Unreleased` section.
- Entries describe user-visible impact, not commit messages.

## Writing style
- Imperative, second person: "Run `npm test`", not "The user should run...".
- Short sentences. One idea per paragraph.
- Fenced code blocks always include a language tag.
- Use relative links between docs. Avoid screenshots of text.
- Define an acronym on first use.

## Larger projects
```
docs/
  architecture.md   # system overview and diagram
  setup.md          # full dev environment setup
  adr/              # decision records
```
