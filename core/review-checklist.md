# Self-Review Checklist

Run through this before reporting a task as done. Fix what fails, or say plainly what you could not fix.

## Correctness
- [ ] Does it do exactly what was asked, and nothing extra?
- [ ] Did I run it, and did the output match what I expect?
- [ ] Edge cases handled: empty, null, very large, invalid input, concurrent use?
- [ ] Error paths behave sensibly and give useful messages?

## Quality
- [ ] Formatter, linter, and type checker pass?
- [ ] Tests added or updated, and the full suite passes?
- [ ] Names are clear. No dead code, no commented-out code, no debug output?
- [ ] No duplicated logic, no unnecessary complexity?

## Safety
- [ ] No secrets, tokens, or personal data in code, logs, or fixtures?
- [ ] External input validated at the boundary?
- [ ] No new dependency added without approval?

## Docs and hygiene
- [ ] README, code docs, and changelog updated where behavior changed?
- [ ] Diff touches only files relevant to the task?
- [ ] Commit messages follow the conventions?

## Final report must include
1. What changed (short)
2. What was run and the results
3. What was not verified, and why
4. Noticed: unrelated issues spotted but left alone
