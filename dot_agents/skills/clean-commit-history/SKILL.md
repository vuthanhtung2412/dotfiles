---
name: clean-commit-history
description: >
  Curate a branch into a clean commit history. Propose a reviewable plan first
  (unless trust mode). Prefer fixup/squash. Use when the user asks to clean
  commit history, tidy a PR/branch, squash/fixup/WIP commits, split mixed
  commits, or rewrite history before review. Trust mode: user says "trust
  mode", "just clean it", or "don't ask — rewrite".
---

# Clean commit history

Sibling skills: `plan-by-commit` (plan before coding), `caveman-commit` (one message).

## Golden rules

1. **Propose first** (unless **trust mode**). Show the reviewable plan below. Wait for OK before reset/rebase/force-push.
2. **Mostly fixup + squash.** Default tool is fold: `fixup` / `squash` into the commit that **owns the intent** — often **not** the direct neighbor. Place the `fixup`/`squash` line **immediately under** that earlier `pick` (autosquash does this). Distant fold is normal, frequent, and still a quiet op.
3. **Highlight non-squash ops.** Call out anything that is *not* `pick` / `fixup` / `squash` — `reword`, `edit` (**SPLIT** / stop to restage), `drop`, moving a **`pick`** (**REORDER**), or full **RESET-rebuild**. Relocating a `fixup`/`squash` under its target is **not** surgery — optional `# → <targetsha>` comment is enough.
4. **One intent per commit.** Subject needs "and" → **SPLIT** (highlight).
5. **No dead-code commits.** New code must ship with its usage (endpoint, GraphQL resolver, frontend feature, caller). Schema/types/utils-only commits → **fixup/squash into** the commit that first uses them. Prefer fold over leaving an unused layer in history.
6. **Merge locals.** Commit touches one unit (one component / service / DB repository) → **fixup/squash into the earlier commit for that same unit**, wherever it sits in the stack (not only adjacent).
7. **Dependencies forward.** Shared types/schema/utils before (or folded into) consumers. Moving a **`pick`** for this = **REORDER** (highlight). Unused-only layer = fold (rule 5), not a standalone pick.
8. **Each SHA typechecks alone.** Tip lint/format clean is enough — no per-SHA lint hunt.
9. **Final tree unchanged** unless user asks to change code.
10. **No silent shared rewrite.** Pushed branch → explicit OK + `--force-with-lease`. Never force-push `main`/`master`. Trust mode covers plan approval, **not** force-push to shared `main`/`master`.

### Trust mode

On when user says e.g. `trust mode` / `just clean it` / `don't ask — rewrite`.

- Skip waiting for plan approval; still **print** the same reviewable plan, then execute.
- Still stop for: force-push to `main`/`master`, secrets in history, destructive drop of uncommitted work, ambiguous DROP of a commit with unique changes.
- Exit trust mode when user says stop / ask me again.

## Reviewable plan format

Always present (trust mode too) as three rebase-i blocks. Reader assumed fluent in `git rebase -i`. Oldest → newest. **Highlight** non-`pick`/`fixup`/`squash` in the staging todo (`reword` / `edit`/`e` / `drop` / moved `pick`).

```text
### Clean history plan
base: <base>  ANCHOR: <shortsha>  mode: ask|trust

# ── before (all pick) ─────────────────────────────────────────
pick a1b2c3d feat(db): add EditAction table           # dead until used
pick c0d1e2f feat(db): add EditAction types           # dead until used
pick e1e2e3e feat(api): persist actions on save
pick b7c8d9e feat: persist on save and show panel
pick d4e5f6a fix typo in migration
pick f0f1f2f tweak EditAction table naming
pick f9f0f1f WIP scratch

# ── staging (reorder + fixup; e = split) ───────────────────────
pick e1e2e3e feat(api): persist actions on save
fixup a1b2c3d feat(db): add EditAction table          # fold dead into first use
fixup c0d1e2f feat(db): add EditAction types
fixup d4e5f6a fix typo in migration
fixup f0f1f2f tweak EditAction table naming
edit b7c8d9e feat: persist on save and show panel    # e: SPLIT
#    → pick _ feat(api): persist on save
#    → pick _ feat(ui): show panel
drop f9f0f1f WIP scratch                             # DROP

# ── after (target log) ────────────────────────────────────────
pick _ feat(api): persist actions on save            # table+types+usage together
pick _ feat(api): persist on save
pick _ feat(ui): show panel
```

Notes:
- Distant `fixup` under its owning `pick` = normal (not surgery).
- Prefer `git commit --fixup=<sha>` + `--autosquash` when staging is only folds.
- Todo can’t express shape → `# RESET-rebuild` + mixed reset; still show the three blocks.

## Step by step

1. **Anchor** — save `HEAD` as ANCHOR; list `<base>..HEAD`; note dirty tree.
2. **Draft plan** — apply golden rules; fill reviewable format; highlight non-squash ops.
3. **Gate** — ask mode: stop for approval. Trust mode: print plan, continue.
4. **Rewrite** — prefer `git commit --fixup=<sha>` + `git rebase --autosquash <base>`; use `reset --mixed <base>` + restage only when plan needs **SPLIT** / complex **REORDER** / **RESET-rebuild**.
5. **Verify** — each SHA typechecks; tip lint OK; `git diff <ANCHOR>` empty.
6. **Push** — if remote + user OK: `git push --force-with-lease`.
