# Check if Issue is Completed

Analyzes whether a GitHub issue has already been completed and is no longer needed. If so, adds a detailed comment explaining why and closes the issue.

## Allowed Tools

- `gh issue view`
- `gh issue list`
- `gh pr list`
- `gh api`
- `gh issue close`
- `git log`
- `git diff`
- File reading tools (Read, Grep, Glob)

## Context

You'll need the issue number to check. If not provided, ask the user for it.

## Task

When this command is run, you MUST:

1. **Gather issue information**:
   - View the issue details using `gh issue view <number>`
   - Understand what the issue is requesting

2. **Investigate completion status**:
   - Search for related PRs that may have addressed this issue
   - Check recent commits that might have resolved it
   - Examine the codebase to see if the requested feature/fix already exists
   - Look for related issues that may have superseded this one

3. **Determine if issue is complete**:
   - If the requested functionality exists, identify when/how it was implemented
   - If it was fixed in a PR, find that PR
   - If it's no longer relevant, understand why

4. **Add detailed comment**:
   If the issue is indeed complete or no longer needed, add a comment that includes:
   - **Status**: Clear statement that the issue is complete/resolved/no longer needed
   - **Evidence**: Links to PRs, commits, or code locations that addressed this
   - **Explanation**: Brief explanation of what was done and when
   - **Verification**: How to verify the issue is resolved (if applicable)

   Example comment format:
   ```markdown
   ## Issue Resolution

   This issue has been completed and is no longer needed.

   **Resolution**: [Describe what was implemented/fixed]

   **Evidence**:
   - PR #XX: [PR title] ([link])
   - Commit: [commit hash] - [commit message]
   - Code location: [file path and relevant line numbers]

   **When**: [Date or commit range when this was resolved]

   **Verification**: [How to verify this works now, if applicable]

   Closing this issue as completed.

   🤖 Analyzed by [Claude Code](https://claude.com/claude-code)
   ```

5. **Close the issue**:
   - Use `gh issue close <number> --comment "<comment text>"`
   - Or add comment first, then close separately

## Important Notes

- Be thorough in your investigation - don't close issues prematurely
- If you're uncertain whether an issue is complete, ask the user before closing
- If the issue is NOT complete, inform the user and explain what still needs to be done
- Always provide evidence for why you're closing the issue

## Example Workflow

```bash
# View the issue
gh issue view 42

# Check for related PRs
gh pr list --search "search terms from issue" --state all

# Check recent commits
git log --all --grep="keyword" --oneline -20

# If complete, close with detailed comment
gh issue close 42 --comment "## Issue Resolution
This issue has been completed...
[detailed explanation]"
```
