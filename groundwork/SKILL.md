---
name: groundwork
description: >-
  Set up and maintain an AI-friendly development workflow on any repository.
  Bootstraps agent context (CLAUDE.md / AGENTS.md), builds layered knowledge-base
  docs, defines code + architecture rules linked to the agent config, runs the
  ticket -> implementation-plan -> build feature loop with a reuse audit, and keeps
  docs and rules self-updating through a dated decision log. Use when starting work
  on a new or existing repo, when the user says "set up docs/rules", "groundwork",
  "onboard this repo", when a new feature ticket needs planning, or when a decision
  should be recorded so a mistake is not repeated.
---

# Groundwork

A repeatable way to make **any repo easy for an AI agent (and a new human dev) to work in**,
and to keep it that way as the project grows. Works with Claude Code, Codex, Cursor, or any
agent that reads a project config file.

The skill runs in **phases**. You rarely run all of them at once. The prompt you pass
(`/groundwork <prompt>`) is the starting instruction — it tells the skill *which phase to run*
and *what the goal is*. If the prompt is vague, ask one clarifying question, then proceed.

## First: read the playbook

Before doing anything, read `references/workflow.md` in this skill folder — it is the detailed
step-by-step for every phase. This file is the map; that file is the terrain. Copy scaffolds
from `templates/`.

## Phase router

Match the user's prompt to a phase. When in doubt, state which phase you picked and why.

| If the prompt is about...                                             | Run phase                    |
| --------------------------------------------------------------------- | ---------------------------- |
| A fresh repo, "onboard", "get started", "the agent knows nothing"     | **0 — Bootstrap agent context** |
| "explain the repo", "knowledge base", "docs for a new dev"            | **1 — Knowledge base**       |
| "code rules", "readability", "SRP", "conventions", "linting-by-rules" | **2 — Code rules**           |
| "architecture rules", "how we structure", "global rules"             | **3 — Global rules**         |
| A feature/ticket, "new requirement", pasted client requirements       | **4 — Feature loop**         |
| "we decided X", "avoid this next time", "record this", a fix to remember | **5 — Decision log**      |

A new repo usually flows 0 → 1 → 2 → 3 once, then repeats phase 4 per feature and phase 5 whenever
a lesson appears.

## Core operating principles (apply in every phase)

1. **Ask, don't assume, on structure choices.** Docs location (`docs/`, `/wiki`, `.notes/`),
   split strategy (per-feature vs per-module), and rule set depend on the repo and the team.
   Offer a sensible default, but let the user pick.
2. **Explain before you edit.** For any non-trivial change: findings → plan → wait for ack.
   Trivial/mechanical → just do it. Never silently write then narrate after.
3. **Detect the agent config filename first.** Some stacks use `CLAUDE.md`, some `AGENTS.md`,
   some both (one `@`-imports the other). Match what exists; don't create a competing file.
4. **Everything links back.** Rules link from the agent config. Feature docs link from a
   docs index. The decision log links from the agent config so it is always in context.
5. **Docs keep the agent on track.** The ticket + implementation-plan pair is not bureaucracy —
   it is the memory of *what was asked, when, and why*, so the agent (and the next dev) can
   extend behaviour instead of re-deriving it.
6. **Docs track code (self-maintaining).** When code that a doc describes changes — a module's
   behaviour, a feature flow, a dependency — update that doc in the **same change**, never as a
   follow-up. The skill writes this rule into the agent config so every future session enforces
   it. This is what keeps the knowledge base, module/feature docs, and dependency list from
   drifting, and pairs with the Phase 5 decision log to make the whole setup self-improving.

## Phase summaries

Full steps live in `references/workflow.md`. Quick shape:

- **Phase 0 — Bootstrap agent context.** Detect stack + config file. If none, generate
  `CLAUDE.md` / `AGENTS.md`: what the project is, how to run/test/build it, dep + docs links,
  where the knowledge base and rules live. Enough for a cold agent to be useful.

- **Phase 1 — Knowledge base.** Two layers. (a) One **abstract** overview for a dev:
  what the product is, the big pieces, how they talk. (b) **Technical docs split per feature
  or per module** (ask which). Use `templates/knowledge-base.md` and `templates/module-doc.md`.
  Also scan the dependency manifest, **resolve each significant package's official docs URL**
  (pinned to the major version in use), and write `docs/dependencies.md` so the agent can look
  up a library's docs instead of guessing its API. Use `templates/dependencies-and-docs.md`.
  Add a docs index and link everything from the agent config.

- **Phase 2 — Code rules.** Turn conventions into short, enforceable rule files linked from the
  agent config, e.g. single responsibility, TypeScript + TS/JSDoc, comment policy, small
  functions composed inside larger ones (debuggable + extendable). Seed from `templates/rules/`;
  adapt to the repo's actual stack.

- **Phase 3 — Global rules.** Architecture and code-division rules that outlive any one feature
  (layer boundaries, where side effects live, folder layout). Create only the ones that don't
  already exist. Use `templates/rules/clean-architecture.md` as a starting point.

- **Phase 4 — Feature loop.** Paste the client ticket. **Audit the existing code first** for
  functionality that already matches, to reuse/extend instead of duplicating (report the
  dependencies you found). Then produce two docs in `docs/<FEATURE>/`:
  `ticket.md` (professional, mostly abstract, lightly technical) and `implementation-plan.md`
  (what the agent will do + what it recommends) for the dev to review **before** any code is
  written. Build only after ack. Templates: `templates/ticket.md`, `templates/implementation-plan.md`.

- **Phase 5 — Decision log (self-improving).** When a problem is hit and the user says "don't do
  this again" — or confirms a good approach — record it in the decision log with **date + why**.
  Link the log from the agent config so it is always loaded. This is how the repo teaches the
  next session. Template: `templates/decision-log.md`.

## When you finish a phase

Tell the user, in one or two lines: what you created/changed, where it lives, and the natural
next phase. Don't dump full file contents into chat — point to the paths.
