# Rule: Git workflow (optional)

> **Optional — pick what fits your team.** These govern how an agent (or dev) uses git day to day.
> During setup, the playbook asks which of these to enable; delete the ones you don't want. Pair
> with the commit-message convention (see `./commit-convention.md`).

## Branching

- **Never commit directly to the default branch** (`main` / `master`). Branch first:
  `feat/<slug>`, `fix/<slug>`, `chore/<slug>`.
- One branch per ticket/feature; keep it focused.

## Pull / stay current

- **Pull (rebase) the latest default branch before starting work** and again **before pushing**, so
  you build on current code and surface conflicts early:
  `git pull --rebase origin <default>`.
- Prefer rebase over merge for local catch-up to keep history linear (team may choose otherwise).

## Push

Choose one policy and state it here:

- **Manual (default, safest):** the agent pushes **only when the dev explicitly asks**.
- **Auto-push:** the agent pushes the working branch after a successful commit + green checks.
  Never auto-push to the default/protected branch.

## Merge & conflicts — notify, don't guess

- On merging a branch (or rebasing onto default), **if there are conflicts, STOP and notify the
  dev** with the conflicting files. Do **not** auto-resolve conflicts or pick a side silently.
- Report when the remote branch has **diverged** (someone else pushed) before you force anything.

## History safety

- **No `--force` / `--force-with-lease` on shared or already-pushed branches.** Force-push only a
  branch that is exclusively yours and unpushed, and only when asked.
- **Don't rewrite pushed commits** (no rebase/amend of commits already on the remote).
- Don't delete branches you didn't create without confirming.

## Notifications (surface these to the dev)

- Merge conflicts on a new-branch merge.
- Remote diverged from local before a push.
- A push that would target a protected/default branch.
- A destructive op requested (`reset --hard`, `clean -f`, branch delete, force-push).

## Applying it

- Default to the conservative choice on any ambiguity (manual push, notify on conflict, no force).
- Record the team's chosen push/merge policy explicitly above so the agent doesn't re-ask each time.
