# Testing Conventions

## What to test
- Every behavior change ships with tests in the same change.
- A bug fix starts with a failing test that reproduces the bug, then the fix.
- Test behavior (inputs and outputs), not implementation details. Refactors should not break tests.
- Cover the edges: empty, null/undefined, boundary values, invalid input, error paths.

## Structure
- Arrange, Act, Assert. One reason for a test to fail.
- Name tests as behavior: `returns_empty_list_when_no_users_match` / `it('shows an error when the email is invalid')`.
- Keep tests next to the code or in a mirrored `tests/` tree. Follow what the project already does.
- Share setup with fixtures/factories, not copy-paste. Keep tests readable without jumping around.

## Test pyramid
- Many fast unit tests, a moderate number of integration tests, a few end-to-end tests for critical user flows.
- Prefer a real test database over mocking the data layer.

## Mocking
- Mock at system boundaries only: network, clock, randomness, filesystem, third-party services.
- Do not mock the code under test or things you own when a real one is cheap.
- Prefer fakes over deep mock chains.

## Reliability
- Deterministic: no `sleep`-based waits, no reliance on test order, no real network calls, no shared mutable state.
- Fix or delete flaky tests. Never retry-until-green.

## Coverage
- Do not chase a percentage. ~80% line coverage on new code is a sanity floor, not a goal.
- Make sure the branches that matter (auth, money, data loss, validation) are covered.

## For Claude specifically
- Run the tests before reporting done, and report the actual result.
- Never edit or delete an existing test just to make it pass. If a test is wrong, say why and ask.
- If you cannot run the tests, say so explicitly.
