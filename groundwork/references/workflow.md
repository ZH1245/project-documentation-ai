# Groundwork — detailed workflow playbook

This is the step-by-step for each phase referenced by `SKILL.md`. Read the phase you need.
Copy scaffolds from `../templates/`.

Throughout: **detect the agent config filename first** (`CLAUDE.md`, `AGENTS.md`, or both) and
edit the one the repo already uses. If both exist and one `@`-imports the other, put durable
links in the imported one.

---

## Phase 0 — Bootstrap agent context

Goal: a cold agent (Claude, Codex, Cursor, anything) can open this repo and be immediately useful.

1. **Detect the stack.** Read the dependency manifest (`package.json`, `pyproject.toml`,
   `go.mod`, `Cargo.toml`, `composer.json`, etc.). Capture runtime version, top deps, and the
   run / test / build / lint commands.
2. **Check for an existing config file.** If `CLAUDE.md` / `AGENTS.md` exists, read it and only
   fill gaps. If none exists, create the one that fits the team's tooling (ask if unclear).
3. **Write the config** with these sections, kept short:
   - **What this is** — one paragraph: product, purpose, who uses it.
   - **Run / test / build** — the exact commands.
   - **Where things live** — top-level folders, and links to the knowledge base + rules once
     those exist (add placeholders now, wire them in phases 1–3).
   - **Dependencies & docs** — significant deps with a one-line purpose and a docs URL pinned to
     the major version in use. Skip trivial utilities.
   - **Decision log** — a link to `docs/decisions.md` (created in phase 5) so lessons stay in context.
4. **Do not** invent conventions here. Config describes reality; rules (phases 2–3) prescribe.

Output: the config file path and a one-line summary. Suggest phase 1 next.

---

## Phase 1 — Knowledge base

Goal: a human dev (and the agent) can understand the repo without reading all the code.

1. **Ask the two structure questions** (offer defaults):
   - Where should docs live? Default `docs/`. (Some teams prefer `/wiki`, `.notes/`, a Notion
     export folder, etc.)
   - Split technical docs **per feature** (user-facing flows) or **per module** (code units)?
     Default: match the repo — feature-first for product apps, module-first for libraries/services.
2. **Write the abstract overview** — `docs/knowledge-base.md` from `templates/knowledge-base.md`.
   Level: a new dev on day one. What the product is, the main pieces, how data/requests flow
   between them, the key external dependencies. No line-by-line detail.
3. **Write the layered technical docs** — one file per feature or per module, e.g.
   `docs/modules/auth.md`, using `templates/module-doc.md`. Each covers: responsibility, key
   files, public surface, data it owns, how it connects to neighbours, gotchas.
4. **Add a docs index** — `docs/README.md` listing every doc with a one-line hook. Link the
   index from the agent config (`## Where things live`).
5. Keep each doc **short and current**. A stale long doc is worse than a short accurate one.

Output: docs folder tree + index path. Suggest phase 2 next.

---

## Phase 2 — Code rules

Goal: conventions become short rule files the agent must follow, linked from the agent config.

1. **Read the stack** to pick relevant rules. Examples that apply widely:
   - **Single responsibility** — one concern per file/function (`templates/rules/single-responsibility.md`).
   - **TypeScript + TS/JSDoc** — explicit types on public APIs, JSDoc on exported functions,
     ban `any` (`templates/rules/typescript-jsdoc.md`). (Skip/replace if not a TS repo.)
   - **Small composed functions** — build behaviour from small named functions called inside
     larger ones, not one giant function; easier to debug and extend. (Covered inside the SRP
     and clean-architecture rule files.)
   - **Comment policy** — comment the *why*, not the *what*; delete dead code and stale comments.
2. **Adapt, don't paste blindly.** Rewrite examples in the repo's language and idioms.
3. **Store rules** where the team keeps them — commonly `.claude/rules/` or `docs/rules/`, or
   inline sections in `AGENTS.md`. Ask if unclear; default `docs/rules/`.
4. **Link every rule from the agent config** so it is always loaded. Add a `Rules` section with
   one line per rule + its path.

Output: rules folder + the config links. Suggest phase 3 next.

---

## Phase 3 — Global rules

Goal: architecture / code-division rules that outlive any single feature.

1. **Check what already exists** — read the config and any rules from phase 2. Only create rules
   that are missing. Don't duplicate.
2. **Candidate global rules** (create the ones the repo needs):
   - **Layer boundaries** — what may import what; where side effects live; pure core vs edges.
   - **Folder / code division** — where a new feature's files go, naming conventions.
   - **Error handling & validation** — validate at boundaries, throw with context, no bug-masking
     fallbacks.
   Start from `templates/rules/clean-architecture.md`.
3. **Link from the config** alongside the phase-2 rules.

Output: which global rules were added vs already present. Suggest phase 4 when a feature arrives.

---

## Phase 4 — Feature loop (per requirement)

Trigger: the user pastes a client ticket / requirement. This is the repeatable core loop.

1. **Understand the requirement.** If the pasted ticket is rough, restate it in one or two lines
   and confirm.
2. **Audit existing code for reuse FIRST.** Before proposing anything new, search the repo for
   functionality that already overlaps. Report:
   - what already exists that this could reuse or extend,
   - the dependencies / call sites that would be touched,
   - anything that would conflict.
   This prevents duplicate implementations and surfaces the real blast radius.
3. **Create the feature folder** `docs/<FEATURE>/` and write two docs:
   - `ticket.md` — from `templates/ticket.md`. Professional, **mostly abstract**, lightly
     technical: problem, goal, scope, acceptance criteria, out-of-scope. This is the shared
     source of truth for what was asked and why.
   - `implementation-plan.md` — from `templates/implementation-plan.md`. **What the agent will
     do** (files, steps, order) **and what it recommends** (trade-offs, options, the reuse it
     found in step 2). Written for a dev to review *before* code exists.
4. **Wait for the dev to review the plan.** Do not write feature code until acked. The plan is a
   checkpoint, not a formality.
5. **Build** to the acked plan. Keep the two docs updated if reality diverges — they are the
   running memory of this feature.

Output: the two doc paths + the reuse findings. After build, if a lesson emerged, go to phase 5.

---

## Phase 5 — Decision log (self-improving docs & rules)

Trigger: a problem was hit and the user says "avoid this next time", or a good approach is
confirmed worth keeping.

1. **Append to `docs/decisions.md`** (create from `templates/decision-log.md` if absent) a dated
   entry: what was decided, **why**, and what to do instead going forward. Newest on top.
2. **If the lesson is a hard rule**, also fold it into the relevant rule file (phase 2/3) so it is
   enforced, not just remembered.
3. **Keep the log linked from the agent config** so every future session loads it. This is what
   makes the setup self-improving: the repo remembers its own mistakes.
4. Do this **in the moment** — when the decision is made in conversation — not in a batch later.

Output: the decision entry + any rule file updated.
