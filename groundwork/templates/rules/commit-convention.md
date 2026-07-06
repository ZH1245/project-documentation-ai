# Rule: Commit message convention

> Pattern-only. No husky, no commitlint, no git hooks — the agent (and dev) simply follow this
> shape when writing commits. Enforced by habit + review, not tooling.

## Rule

Every commit subject follows **Conventional Commits**:

```
<type>(<scope>): <subject>
```

- **type** — one of: `feat`, `fix`, `refactor`, `perf`, `docs`, `test`, `build`, `ci`, `chore`, `revert`.
- **scope** — optional, the area touched (module/feature/package), lowercase, e.g. `auth`, `api`.
- **subject** — imperative mood ("add", not "added"/"adds"), lowercase start, **no trailing period**,
  aim for ≤ 50 chars (hard cap 72).
- **body** (optional) — blank line, then the **why**, wrapped ~72 cols. Add only when the reason
  isn't obvious from the diff.
- **breaking change** — add `!` after type/scope (`feat(api)!: ...`) and a `BREAKING CHANGE:` footer.

Reference pattern (for humans, not a hook):

```
^(feat|fix|refactor|perf|docs|test|build|ci|chore|revert)(\([a-z0-9-]+\))?!?: .{1,72}$
```

## Why

A consistent, machine-readable subject makes history skimmable, lets you generate changelogs later,
and forces each commit to name *what kind of change* it is. The body carries the reasoning the diff
can't.

## Good

```
feat(auth): add refresh-token rotation
fix(api): stop double-charging when idempotency key is reused
refactor(cart): split checkout into priced/charge/order steps
docs(deps): pin prisma docs link to v6
```

## Bad

```
Update stuff              # no type, vague
fixed the bug.            # past tense, trailing period, no scope, no detail
feat: Added a huge feature that does X and Y and also Z and refactors W  # too long, past tense
```

## Applying it (agent committing)

- One logical change per commit; don't mix a refactor with a feature.
- Pick the `type` by the change's intent, not the files touched.
- If the "why" isn't clear from the diff, write a one-paragraph body. Otherwise subject only.
- Follow the team's authorship/trailer policy (e.g. whether to include co-author trailers) — keep it
  consistent across commits.
