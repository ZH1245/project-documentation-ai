# Dependencies & docs

> The libraries this project depends on, each with a link to its **official documentation** pinned
> to the major version in use. The agent consults this page before writing code against a library,
> so it uses the real current API instead of guessing. Keep it in sync when deps are added/removed.

**Runtime:** <e.g. Node 20, TypeScript 5.x>

## Core

| Package (version) | Used for | Docs |
| ----------------- | -------- | ---- |
| `<name>` (`<major>.x`) | <what the project uses it for> | <official docs URL for that major version> |
| `<name>` (`<major>.x`) | <purpose> | <url> |

## Dev

| Package (version) | Used for | Docs |
| ----------------- | -------- | ---- |
| `<name>` (`<major>.x`) | <purpose> | <url> |

## Build / tooling

| Package (version) | Used for | Docs |
| ----------------- | -------- | ---- |
| `<name>` (`<major>.x`) | <purpose> | <url> |

---

_How to resolve a docs link:_ prefer the `homepage` / `repository` / `docs` field in the manifest,
then the official site, then the GitHub README, then the registry page (npm / PyPI / crates.io) as
a fallback. Always pin to the **major version** the project uses. Skip trivial utilities with no
useful docs.
