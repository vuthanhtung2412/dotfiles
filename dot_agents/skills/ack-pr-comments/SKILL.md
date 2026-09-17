---
name: ack-pr-comments
description: How to acknoledge PR comments correctly
---

## Scope / hard rules

- Apply fixes in local repo.
- If comment problematic, create **one fix commit per comment**.
- **Do not** post replies/comments on GitHub (no thread reply, no review comment, no issue comment).
- Do not resolve threads on GitHub unless user explicitly asks. (Local commits only.)

## Workflow

1. Use `~/.agents/skills/ack-pr-comments/pr-discussion.sh` to pretty print the unresolve reviews and discussion
  + Most of the time the script already contain everything you need if needed more info use `gh` CLI

2. Build a fix queue
   - For each thread/comment, capture:
     - file path + line (if available)
     - requested change / concern
     - whether multiple comments map to same code change
   - Group only when same edit satisfies multiple comments; otherwise keep 1:1.

3. For each queued item (repeat)
   - Read relevant files locally.
   - Implement minimal code change satisfying the comment and repo conventions.
   - Run smallest relevant check (lint/test/targeted command) if obvious and fast; otherwise skip.
   - Create a commit with conventional commits format:
     - Prefer `fix:` for bug/behavior, `refactor:` for cleanup, `test:` for tests, `docs:` for docs, `chore:` for tooling.
     - Subject <= 50 chars.
     - Body only when "why" not obvious.
   - Ensure working tree clean and user approval before moving to the next item
     - you can write a markdown to track your progress


## Output to user

- Provide short checklist of what got fixed and the commit for each comments.
- If any comment cannot be resolved without further input ask the user
