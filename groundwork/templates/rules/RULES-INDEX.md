# Rules index

> Every rule the code follows. Link this index (and/or the individual files) from the agent config
> (`CLAUDE.md` / `AGENTS.md`) so the rules are always loaded. Keep each rule short and enforceable.
> Adapt these to the repo's actual stack — delete what doesn't apply, add what does.

## Code rules

- [Single responsibility](./single-responsibility.md) — one concern per file/function; compose
  small named functions inside larger ones.
- [TypeScript + TS/JSDoc](./typescript-jsdoc.md) — explicit types on public APIs, JSDoc on exports,
  no `any`. *(TypeScript repos only.)*

## Global / architecture rules

- [Clean architecture & code division](./clean-architecture.md) — layer boundaries, where side
  effects live, folder layout, error handling at boundaries.

## Git & commits

- [Commit message convention](./commit-convention.md) — Conventional Commits pattern the agent
  follows when committing. Pattern-only, no husky/hooks.
- [Git workflow](./git-workflow.md) — **optional**: branching, pull-before-work, push policy,
  notify-on-conflict, history safety. Pick what fits your team.

## How to add a rule

1. Write a short file here: what the rule is, why, and a good/bad example.
2. Link it from this index and from the agent config.
3. If the rule came from a lesson, cross-link the entry in `../../decisions.md`.
