---
name: comment-code
description: >
  Lightly comment a function: one concise docstring, then concise
  step-by-step inline comments only where steps are not self-explanatory.
  Use when user says "/comment-code", "comment code", "add comments",
  "comment this function", or asks to document a function lightly.
disable-model-invocation: true
---

# Comment Code

Light touch only. Explain *why* / non-obvious intent. Never narrate obvious code.

## Workflow (2 steps)

Apply both to the target function(s). Do nothing else (no refactors, renames, logic changes).

### 1. Concise docstring

- One short sentence: what the function guarantees / fails on / returns.
- Prefer outcome over mechanics.
- Match language convention (`"""..."""` Python, `/** ... */` / JSDoc TS when file already uses it).
- Skip if existing docstring already good; tighten if verbose.

### 2. Concise step-by-step inline comments

- Numbered `# 1. …`, `# 2. …` only for non-self-explanatory steps.
- One line each. Why / constraint / domain rule — not "loop over X".
- Skip trivial / obvious steps. Prefer fewer.

## Style (canonical)

Mirror `_require_role_applicable` in
`backend/.../domain/tracking_review/tracking_review_service.py`:

```python
def _require_role_applicable(...) -> None:
    """Fail the whole batch if `role` cannot land on every review."""
    # 1. Reject never creates/keeps a lesion — nowhere to put a role.
    if state == TrackingReviewState.REJECTED:
        raise TrackingReviewGuardrailError(...)

    # 2. Source-less + non-graduating verdict → no lifeline.
    ...

    # 3. Role rewrite/stamp is patient-scoped (TARGET caps especially).
    ...
```

## Do / Don't

| Do | Don't |
|----|--------|
| Outcome docstring | Restate signature / param list |
| Number non-obvious decision stages | Narrate obvious code |
| Keep existing good comments | Wipe docs unless asked |

## Scope

- Default: function(s) user pointed at (cursor, selection, named symbol).
- If unclear which function: ask once.
- Edit file in place. No separate doc file.
