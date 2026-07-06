# <FEATURE> — Implementation plan

> What the agent will do, and what it recommends — for a developer to review BEFORE any code is
> written. Lives at `docs/<FEATURE>/implementation-plan.md`. Paired with `./ticket.md`.

- **Status:** Proposed | Approved | Building | Done
- **For ticket:** `./ticket.md`

## Reuse audit (existing code that already matches)

<Result of auditing the repo before proposing anything new.>

- **Can reuse / extend:** <existing functions, modules, endpoints that overlap>
- **Dependencies / call sites touched:** <what would be affected>
- **Conflicts / risks found:** <anything that clashes with the requirement>

## Approach

<The recommended approach in a few sentences, and WHY it was chosen over alternatives.>

### Alternatives considered

<Other options and the trade-off that ruled them out. Keep short.>

## Changes (files & order)

| # | File / area | Change | Notes |
| - | ----------- | ------ | ----- |
| 1 | `<path>` | <what changes> | <why / depends on> |
| 2 | `<path>` | <what changes> | |

## Testing

<What will be tested and how — the exact command where possible.>

## Risks & rollout

<What could go wrong, and how it's mitigated. Migrations, flags, backfill, etc.>

## Open decisions for the reviewer

<Anything the dev should confirm before build starts.>

---

_Reviewer: approve this plan (or request changes) before code is written._
