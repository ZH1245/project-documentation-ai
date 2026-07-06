# <Project name> — Knowledge base

> Abstract overview for a developer's first day. What the product is and how the big pieces fit.
> Keep it short and current. Detailed per-feature/per-module docs live alongside this file.

## What it is

<One short paragraph: the product, its purpose, and who uses it.>

## The big pieces

<The main components/services/modules, one line each. Not files — concepts.>

- **<Piece A>** — <what it does>
- **<Piece B>** — <what it does>
- **<Piece C>** — <what it does>

## How a request / action flows

<Describe the main happy path end to end in a few steps, so a reader sees how the pieces talk.>

1. <entry point> ->
2. <what handles it> ->
3. <where data goes> ->
4. <what comes back>

## Data it owns

<The core entities/tables/models and what they represent. One line each.>

## External dependencies

<Third-party services, APIs, or infra the product relies on, and why.>

## Where to go next

- Per-feature / per-module detail: `./modules/` (see `./README.md` for the index)
- Rules the code follows: <link to rules folder>
- Decisions & lessons: `./decisions.md`
