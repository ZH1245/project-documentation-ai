# <Feature or module name>

> Technical doc for one feature or module. One responsibility per doc. Keep it accurate over complete.

## Responsibility

<What this unit is responsible for — and, briefly, what it is NOT responsible for.>

## Key files

| Path | Role |
| ---- | ---- |
| `<path>` | <what it does> |
| `<path>` | <what it does> |

## Public surface

<The functions / endpoints / components other parts of the codebase use to talk to this unit.
Signatures or route names, with a one-line purpose each.>

## Data it owns

<Entities, tables, or state this unit is the source of truth for.>

## How it connects

<Upstream: who calls into this. Downstream: what this calls out to. Note the contracts/interfaces
at each boundary.>

## Gotchas

<Non-obvious constraints, invariants, footguns, or historical decisions worth knowing before
changing this. Link related entries in `../decisions.md` where relevant.>
