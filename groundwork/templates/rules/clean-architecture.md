# Rule: Clean architecture & code division

> Global rule. Adapt the layer names and folders to the repo's real structure.

## Rule

- **Layer boundaries.** Keep a pure core (domain logic) separate from the edges (I/O: HTTP, DB,
  queues, third-party APIs). The core does not import the edges.
- **Side effects live at the edges.** Domain functions are pure where possible; effects (network,
  disk, DB writes) happen in thin adapter layers the core calls through interfaces.
- **Validate at boundaries.** Untrusted input (user, external API, network) is validated once, at
  entry. Internal code trusts already-validated data instead of re-checking everywhere.
- **Errors throw with context at boundaries.** No fallback values that mask bugs
  (`?? 0`, `|| []` used to swallow failures), no catch-log-and-continue that hides real errors.
- **Predictable code division.** A new feature's files go in a predictable place with predictable
  names, so the next dev (or agent) finds them without a map.

## Why

When the core is pure and effects are pushed to the edges, logic is testable without mocks, and a
change to one boundary (swap a DB, add an API) doesn't ripple into business rules. Validating once
at the boundary keeps internal code simple and trustworthy.

## Shape

```
src/
  domain/        # pure logic, no I/O imports
  services/      # orchestration; calls domain + adapters
  adapters/      # DB, HTTP clients, queues — the only place effects live
  api/ (or web/) # entry points; validate input here, then delegate
```

## Applying it

- A domain file importing a DB client is a smell — move the effect to an adapter and pass data in.
- If two features need the same helper, lift it to a shared module; don't copy it.
- Record architecture decisions and their reasons in `../../decisions.md` so boundaries aren't
  eroded by the next quick fix.
