# Duplicate Issue Finder

Identifies duplicate GitHub issues using AI-powered semantic search and multi-strategy analysis.

## Allowed Tools

**ONLY these `gh` commands are permitted:**
- `gh issue view <issue-number>`
- `gh search issues <query>`
- `gh issue comment <issue-number> --body "..."`

**Explicitly forbidden:**
- Web fetching
- File editing
- Any non-GitHub tools

## Workflow

Execute these five stages sequentially:

### Stage 1: Validation ✅

Determine if the issue should be processed by checking:

1. **Is the issue already closed?**
   - If yes, exit immediately (no need to find duplicates)

2. **Does the issue have specific details?**
   - If too vague or lacks information, exit
   - Issues like "it doesn't work" can't be matched

3. **Does a duplicate comment already exist?**
   - Check if someone (human or bot) already identified duplicates
   - If yes, exit to avoid redundant comments

**If any check fails, stop processing and explain why.**

---

### Stage 2: Issue Summary 📝

Read and summarize the target issue:

```bash
gh issue view <issue-number>
```

Extract:
- **Problem description**: What's broken or requested?
- **Key symptoms**: Error messages, behavior descriptions
- **Context**: Environment, steps to reproduce, affected features
- **Keywords**: Technical terms, component names, error types

Create a 3-5 sentence summary that captures the essence of the issue.

---

### Stage 3: Parallel Multi-Strategy Search 🔎

Launch **5 concurrent search strategies** using different approaches to maximize duplicate detection:

**Strategy 1: Direct keyword search**
- Use exact technical terms from the issue (error messages, function names)
- Example: `gh search issues "TypeError: Cannot read property" repo:kingralph33/kingralphdev-website`

**Strategy 2: Symptom-based search**
- Search for described behaviors or symptoms
- Example: `gh search issues "navigation broken after update" repo:kingralph33/kingralphdev-website`

**Strategy 3: Component/feature search**
- Focus on affected components or features mentioned
- Example: `gh search issues "SearchBar component" repo:kingralph33/kingralphdev-website`

**Strategy 4: Broad semantic search**
- Use generalized terms related to the problem domain
- Example: `gh search issues "search functionality not working" repo:kingralph33/kingralphdev-website`

**Strategy 5: Similar issue patterns**
- Search for common patterns or related issues
- Example: `gh search issues "state not updating" repo:kingralph33/kingralphdev-website`

**Important:** Each search should use `is:issue` to filter only issues (not PRs).

---

### Stage 4: Result Filtering 🎯

Review all search results and eliminate false positives:

1. **Read each candidate issue** using `gh issue view <issue-number>`

2. **Evaluate similarity** based on:
   - Same root cause or underlying bug
   - Same symptoms or error messages
   - Same affected feature or component
   - Same reproduction steps

3. **Eliminate false positives:**
   - Different symptoms with similar keywords
   - Related but distinct problems
   - Fixed issues that don't apply anymore

4. **Rank duplicates** by confidence:
   - **High confidence**: Nearly identical symptoms and context
   - **Medium confidence**: Same feature/component with similar issues
   - **Low confidence**: Possibly related but unclear

**Select up to 3 best duplicate candidates** (prioritize high confidence matches).

---

### Stage 5: Post Duplicate Comment 💬

If duplicates were found, post a formatted comment:

```bash
gh issue comment <issue-number> --body "$(cat <<'EOF'
👋 Hi! This issue appears to be a duplicate of:

- #<issue-number> - <Brief description>
- #<issue-number> - <Brief description>
- #<issue-number> - <Brief description>

**Next Steps:**
- If you agree this is a duplicate, please close this issue
- If you believe this is NOT a duplicate, add a 👍 reaction to this comment and explain why
- If you have additional information not covered in the duplicate issues, please add it as a comment there instead

---
🤖 Automated duplicate detection via Claude Code
EOF
)"
```

**Comment format rules:**
- List 1-3 duplicates maximum (most relevant first)
- Include issue numbers as `#123` format for auto-linking
- Include brief descriptions so users understand the match
- Provide clear next steps for users to take action
- Include the automation footer

**If no duplicates found:**
- Do NOT post any comment
- Simply report "No duplicates found" to the user

---

## Example Usage

```bash
# User invokes: /dedupe https://github.com/kingralph33/kingralphdev-website/issues/42

# Stage 1: Check if issue #42 is valid for processing
gh issue view 42

# Stage 2: Summarize the issue
# (Creates internal summary)

# Stage 3: Run 5 parallel searches
gh search issues "SearchBar debouncing" repo:kingralph33/kingralphdev-website is:issue
gh search issues "input lag typing" repo:kingralph33/kingralphdev-website is:issue
gh search issues "SearchBar component" repo:kingralph33/kingralphdev-website is:issue
gh search issues "performance search input" repo:kingralph33/kingralphdev-website is:issue
gh search issues "state update delay" repo:kingralph33/kingralphdev-website is:issue

# Stage 4: Review results and identify #18 and #31 as duplicates

# Stage 5: Post comment
gh issue comment 42 --body "..."
```

---

## Important Constraints

1. **No tool restrictions bypassing**: Only use listed `gh` commands
2. **Process all stages**: Don't skip validation or filtering
3. **Conservative commenting**: Only comment if confident duplicates exist
4. **Respect existing work**: Don't duplicate if already commented
5. **Clear reasoning**: When reporting results, explain why issues are duplicates

---

## Success Criteria

✅ Valid issue processed through all stages
✅ Multiple search strategies employed
✅ False positives filtered out
✅ Clear, actionable comment posted (if duplicates found)
✅ No comment posted if no duplicates found
