---
name: verify
description: "Run comprehensive verification on current codebase state (build, types, lint, tests). Use after completing implementation or before commits/PRs."
user-invocable: true
context: fork
agent: general-purpose
allowed-tools: ["Bash", "Read", "Grep", "Glob"]
---

Run comprehensive verification on the current codebase state.

## Verification Steps

Execute in this exact order:

1. **Build Check**
   - Run the build command for this project
   - If it fails, report errors and STOP

2. **Type Check**
   - Run TypeScript/type checker if applicable
   - Report all errors with file:line

3. **Lint Check**
   - Run linter
   - Report warnings and errors

4. **Test Suite**
   - Run all tests
   - Report pass/fail count
   - Report coverage percentage

5. **Console.log Audit**
   - Search for console.log in source files (exclude test files)
   - Report locations

6. **Git Status**
   - Show uncommitted changes via `jj st` or `git status`

## Output Format

```
VERIFICATION: [PASS/FAIL]

Build:    [OK/FAIL]
Types:    [OK/X errors]
Lint:     [OK/X issues]
Tests:    [X/Y passed, Z% coverage]
Logs:     [OK/X console.logs]

Ready for PR: [YES/NO]
```

If any critical issues, list them with fix suggestions.

## Arguments

$ARGUMENTS can be:
- `quick` - Only build + types
- `full` - All checks (default)
- `pre-commit` - Checks relevant for commits
- `pre-pr` - Full checks plus security scan
