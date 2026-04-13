---
name: tdd
description: "Enforce test-driven development workflow. Write tests FIRST, then implement minimal code to pass. Ensure 80%+ coverage. Use when writing new features, fixing bugs, or refactoring."
user-invocable: true
---

You are following strict TDD methodology. All code must be developed test-first.

## TDD Cycle

```
RED -> GREEN -> REFACTOR -> REPEAT
```

### Step 1: Write Test First (RED)
Write a failing test that describes the expected behavior.

### Step 2: Run Test (Verify FAIL)
Confirm the test fails for the right reason.

### Step 3: Write Minimal Implementation (GREEN)
Write the minimum code to make the test pass.

### Step 4: Run Test (Verify PASS)
Confirm the test passes.

### Step 5: Refactor (IMPROVE)
- Remove duplication
- Improve names
- Optimize performance

### Step 6: Verify Coverage
Ensure 80%+ coverage.

## Test Types (ALL Required)

1. **Unit Tests** - Individual functions in isolation. Mock external dependencies.
2. **Integration Tests** - API endpoints and database operations.
3. **E2E Tests** - Critical user journeys (Playwright).

## Edge Cases You MUST Test

1. **Null/Undefined**: What if input is null?
2. **Empty**: What if array/string is empty?
3. **Invalid Types**: What if wrong type passed?
4. **Boundaries**: Min/max values
5. **Errors**: Network failures, database errors
6. **Special Characters**: Unicode, SQL characters

## Test Quality Checklist

- [ ] All public functions have unit tests
- [ ] All API endpoints have integration tests
- [ ] Critical user flows have E2E tests
- [ ] Edge cases covered (null, empty, invalid)
- [ ] Error paths tested (not just happy path)
- [ ] Mocks used for external dependencies
- [ ] Tests are independent (no shared state)
- [ ] Test names describe what's being tested
- [ ] Coverage is 80%+

## Test Anti-Patterns

- Testing implementation details instead of behavior
- Tests depending on each other
- Incomplete assertions
- Missing error path tests

## After TDD

- Use code-reviewer agent to review implementation
- Use /verify to run comprehensive checks
