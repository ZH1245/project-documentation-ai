# project-documentation-ai

> Skills for setting up a repo for documentation and knowledge.

An **agent-agnostic** methodology (packaged as the `groundwork` playbook) that sets up and maintains
an AI-friendly development workflow on **any repository** — so an agent **and** a new human dev can
both work in the repo productively, and it stays that way as the project grows.

**Works with any agent that can read files and run shell commands** — Claude Code, Codex, Cursor,
and others. It's just markdown: a playbook (`groundwork/SKILL.md` + `references/workflow.md`) and
copy-paste `templates/`. Nothing here depends on a Claude-only feature. Claude Code *can* expose it
as a `/`-slash command for convenience, but that's optional — every other agent runs the exact same
methodology by reading the playbook.

It turns one repeatable methodology into phases you run **one at a time**:

| Phase | What it does |
| ----- | ------------ |
| **0 · Bootstrap agent context** | Generate/complete the repo's agent config (`AGENTS.md` / `CLAUDE.md`) so a cold agent is instantly useful. |
| **1 · Knowledge base** | An abstract project overview **+** layered per-feature/per-module docs **+** a `dependencies.md` linking each package's official docs so the agent looks up real APIs. |
| **2 · Code rules** | Short, enforceable convention files (SRP, TS/JSDoc, small composed functions, comment policy) linked from the agent config. |
| **3 · Global rules** | Architecture & code-division rules that outlive any single feature. |
| **4 · Feature loop** | From a client ticket: **reuse audit** → `ticket.md` + `implementation-plan.md` for dev review → build only after ack. |
| **5 · Decision log** | Record lessons (date + why), linked from the config, so the repo teaches the next session. |

The docs it produces keep the agent on track: it always knows **what was asked, when, and why**. And
they're **self-maintaining** — the playbook writes a rule into your agent config so that whenever
documented code (a module, a feature, a dependency) changes, its doc is updated in the same change.

---

## Use it with any agent (no install)

This is the universal path — works in Claude Code, Codex, Cursor, anything. Paste this into your
agent's chat **in the repo you want to set up**:

```
Set up this repo using the "groundwork" methodology at
https://github.com/ZH1245/project-documentation-ai :
git clone it to a temp dir, read groundwork/SKILL.md and groundwork/references/workflow.md,
then run the FULL SETUP in one flow (Phases 0-3) — ask me all your questions up front,
then run straight through without stopping between phases. Use groundwork/templates/.
```

The agent clones the repo, reads the playbook, asks the setup questions **once**, then runs Phases
0→3 end to end. Nothing is installed; it just follows the markdown.

Prefer to go one phase at a time instead? Say `follow Phase 0 to onboard this repo` and it stops
after each phase and suggests the next. Either way, **Phase 4** (a feature ticket) and **Phase 5**
(record a lesson) run on demand later — e.g. `run Phase 4 for this ticket: <paste ticket>`.

## Make it durable in a repo (any agent)

So every future session of any agent finds it automatically, keep the playbook **in the repo** and
point the agent config at it:

```bash
# from inside your target repo
git clone https://github.com/ZH1245/project-documentation-ai.git /tmp/gw
mkdir -p .groundwork && cp -R /tmp/gw/groundwork/. .groundwork/
```

Then add one line to the repo's `AGENTS.md` (and/or `CLAUDE.md`) — the file every agent already reads:

```markdown
## Repo setup & docs workflow
Follow `.groundwork/SKILL.md` (detail in `.groundwork/references/workflow.md`) for onboarding,
knowledge-base docs, rules, the feature ticket→plan loop, and the decision log.
```

Now "follow the groundwork workflow to onboard this repo" works for Claude Code, Codex, or Cursor,
because they all load `AGENTS.md`.

---

## Optional: Claude Code slash-command skill

If you use **Claude Code**, you can install `groundwork` as a discoverable `/`-slash command. This is
a convenience wrapper on the same playbook — skip it if you're on another agent.

```bash
git clone https://github.com/ZH1245/project-documentation-ai.git
cd project-documentation-ai
./install.sh                 # -> /groundwork
./install.sh docsetup        # -> /docsetup (choose your own command name)
```

`install.sh` copies `groundwork/` into `~/.claude/skills/<name>` and rewrites the skill's `name:` so
it's invoked as `/<name>`. Restart Claude Code, then:

```
/groundwork onboard this repo — the agent knows nothing about it yet
```

To commit the skill for one repo's Claude Code users instead: `cp -R groundwork .claude/skills/groundwork`
inside that repo and commit it.

---

## Repo layout

```
project-documentation-ai/
  README.md
  install.sh                     # optional: installs the Claude Code slash-command skill
  LICENSE
  groundwork/                    # the playbook (self-contained, agent-agnostic)
    SKILL.md                     # phase router + operating principles (readable by any agent)
    references/workflow.md       # detailed step-by-step for every phase
    templates/                   # copy-paste scaffolds
      knowledge-base.md
      module-doc.md
      dependencies-and-docs.md
      ticket.md
      implementation-plan.md
      decision-log.md
      rules/
        RULES-INDEX.md
        single-responsibility.md
        typescript-jsdoc.md
        clean-architecture.md
        commit-convention.md         # Conventional Commits pattern (no husky)
        git-workflow.md              # optional git rules (push/pull/conflict)
```

---

## Using it (the phases)

Drive it one phase at a time. The starting instruction tells the playbook **which phase to run**:

- **Claude Code (skill installed):** `/<name> <prompt>`
- **Any agent:** tell it in plain language, e.g. *"follow the groundwork workflow, Phase 2, to set
  up code rules for this repo."*

| Goal                            | Instruction                                                            |
| ------------------------------- | --------------------------------------------------------------------- |
| **Full setup, one flow**        | **set everything up in one flow — ask me all questions up front**      |
| Onboard a new repo (one phase)  | onboard this repo, the agent knows nothing about it                    |
| Build the knowledge base        | build a knowledge base, split technical docs per module               |
| Add code rules                  | set up code rules for this React + TS repo                            |
| Add architecture rules          | add global architecture and code-division rules                      |
| Plan a feature from a ticket    | new feature — `<paste the client ticket here>`                        |
| Record a lesson                 | remember: always use idempotency keys on the payments API — it caused double charges |

A new repo usually flows **0 → 1 → 2 → 3** once, then repeats **Phase 4** per feature and **Phase 5**
whenever a lesson appears. The playbook **asks before assuming** structure choices (docs location,
per-feature vs per-module), so each repo is set up its own way.

---

## Choose your own command name (Claude Code)

`install.sh` sets the slash command name for you:

```bash
./install.sh docsetup      # /docsetup instead of /groundwork
```

Name rules: lowercase letters, digits, hyphens. To change it later, re-run `install.sh` with a new
name. (Other agents don't use slash commands, so this only matters for Claude Code.)

---

## License

MIT — see [LICENSE](./LICENSE).
