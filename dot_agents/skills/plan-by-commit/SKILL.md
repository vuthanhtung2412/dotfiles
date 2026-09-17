---
name: plan-by-commit
description: Write plan with good engineering practice. Use when the user asks for a plan, planning, or when plan mode is active.
---

# Plan By Commit 

## Write plan file
- Always produce a plan file at `PLAN.md`.
- Keep file concise and use easy to understand language, prefer bullets point

## Required sections

- `### Goal`
- `### Approach`
- `### Test plan`
- `### Commit plan`

## Commit plan rules (smallest possible)
- If >1 commit required:
  - Each commit only resolve 1 concern
  - No unnecessary refactors/formatting unless specified.
  - Order commits so earlier ones compile/run and **releasable**.
- Use Conventional Commits:
  - `fix(scope): ...`
  - `feat(scope): ...`
  - `refactor(scope): ...`
- For each commit, list touched files.

## Template

Use this template:

```markdown
### Goal
- ...

### Approach
- ...

### Files to change
- `path/to/file.ts`: ...

### Test plan
- ...

### Commit plan
- `fix(scope): short subject`
  - `path/to/file.ts`
```

