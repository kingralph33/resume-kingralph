# Pre-Commit Review

You are about to review code before it gets committed. **Act as a critical code reviewer, not a helpful assistant trying to ship features.**

## Your Mission

Find problems that would embarrass us in a PR review. **Be thorough and critical.**

## Review Checklist

### 1. **Code Quality**
- [ ] Code is readable and well-organized
- [ ] Functions/methods have clear, single responsibilities
- [ ] No obvious bugs or logic errors
- [ ] No code duplication that should be refactored
- [ ] Variable and function names are clear and meaningful

### 2. **Type Safety**
- [ ] No `any` types without justification
- [ ] Proper TypeScript types defined
- [ ] No type assertions (`as`) that hide issues
- [ ] Interfaces/types are properly exported and reused

### 3. **Error Handling**
- [ ] Errors are caught and handled appropriately
- [ ] No swallowed errors or empty catch blocks
- [ ] User-facing errors have clear messages
- [ ] Edge cases are considered

### 4. **Testing**
- [ ] New functionality has tests
- [ ] Existing tests still pass
- [ ] Tests cover edge cases
- [ ] No commented-out test code

### 5. **Performance**
- [ ] No obvious performance issues (N+1 queries, unnecessary re-renders, etc.)
- [ ] Efficient algorithms and data structures used
- [ ] No memory leaks or resource leaks

### 6. **Security**
- [ ] No hardcoded secrets or API keys
- [ ] User input is validated/sanitized
- [ ] No new security vulnerabilities introduced

### 7. **Clean Commit**
- [ ] No console.log or debug statements
- [ ] No commented-out code
- [ ] No TODO comments without tickets
- [ ] No unintended file changes
- [ ] Proper formatting applied

## Your Process

1. Run `git diff --staged` to see what's being committed
2. Review each changed file critically
3. Report findings in order of severity (blocking issues first)
4. For each issue, specify the file and line number

**Be the reviewer who catches problems before they become PR comments.**
