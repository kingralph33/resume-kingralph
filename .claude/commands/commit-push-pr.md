# Commit, Push, and Create PR

Automates the complete git workflow from committing changes to opening a pull request against the `dev` branch.

## Allowed Tools

- `git checkout -b`
- `git add`
- `git status`
- `git push`
- `git commit`
- `gh pr create`

## Context

Before executing the workflow, gather this information:

```bash
git status
git diff HEAD
git branch --show-current
```

## Task

You MUST do all of the following in a single message (use multiple tool calls in parallel where possible):

1. **Create feature branch** (if currently on `dev`):
   - If on `dev`, create a new feature branch with a descriptive name based on the changes
   - If already on a feature branch, stay on it

2. **Commit changes**:
   - Stage all changes with `git add .`
   - Create a single commit with a clear, descriptive message following conventional commits format:
     - `feat: ...` for new features
     - `fix: ...` for bug fixes
     - `docs: ...` for documentation
     - `refactor: ...` for code refactoring
     - `test: ...` for tests
     - `chore: ...` for maintenance tasks

3. **Push to remote**:
   - Push the current branch to origin with `-u` flag to set upstream tracking

4. **Create pull request**:
   - Use `gh pr create` with these options:
     - `--base dev` (target branch)
     - `--title "..."` (descriptive title)
     - `--body "..."` (PR description with summary and test plan)
   - Include in the PR body:
     - Summary of changes (2-3 sentences)
     - Test plan or verification steps
     - Footer: "🤖 Generated with [Claude Code](https://claude.com/claude-code)"

5. **Execute without commentary**:
   - Run all commands in sequence
   - Do not use any other tools or write explanatory text between steps
   - Chain commands with `&&` where appropriate

## Example Flow

```bash
# If on dev, create feature branch
git checkout -b feat/add-user-authentication

# Stage and commit
git add . && git commit -m "feat: implement user authentication with JWT tokens"

# Push with upstream tracking
git push -u origin feat/add-user-authentication

# Create PR against dev
gh pr create --base dev --title "Add user authentication" --body "$(cat <<'EOF'
## Summary
Implements JWT-based user authentication including login, logout, and protected routes.

## Test plan
- [x] Login flow works correctly
- [x] Logout clears tokens
- [x] Protected routes redirect to login
- [x] All tests pass

🤖 Generated with [Claude Code](https://claude.com/claude-code)
EOF
)"
```

**Important:** Execute all five steps in a single response. Do not pause for user input between steps.
