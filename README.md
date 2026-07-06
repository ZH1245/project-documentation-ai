# project-documentation-ai

> Skills for setting up a repo for documentation and knowledge.

A Claude Code **skill** (`groundwork`) that sets up and maintains an AI-friendly development
workflow on **any repository** — so an agent (Claude, Codex, Cursor, …) and a new human dev can
both work in the repo productively, and it stays that way as the project grows.

It turns one repeatable methodology into phases you run **one at a time**:

| Phase | What it does |
| ----- | ------------ |
| **0 · Bootstrap agent context** | Generate/complete `CLAUDE.md` / `AGENTS.md` so a cold agent is instantly useful. |
| **1 · Knowledge base** | An abstract project overview **+** layered per-feature/per-module technical docs **+** a `dependencies.md` that links each package's official docs so the agent looks up real APIs. |
| **2 · Code rules** | Short, enforceable convention files (SRP, TS/JSDoc, small composed functions, comment policy) linked from the agent config. |
| **3 · Global rules** | Architecture & code-division rules that outlive any single feature. |
| **4 · Feature loop** | From a client ticket: **reuse audit** → `ticket.md` + `implementation-plan.md` for dev review → build only after ack. |
| **5 · Decision log** | Record lessons (date + why), linked from the config, so the repo teaches the next session. |

The docs the skill produces keep the agent on track: it always knows **what was asked, when, and why**.
And they're **self-maintaining** — the skill writes a rule into your agent config so that whenever
documented code (a module, a feature, a dependency) changes, its doc is updated in the same change.

---

## Quickstart

```bash
git clone https://github.com/ZH1245/project-documentation-ai.git
cd project-documentation-ai
./install.sh          # copies the skill into ~/.claude/skills/groundwork
```

Restart Claude Code, open the repo you want to set up, and run:

```
/groundwork onboard this repo — the agent knows nothing about it yet
```

---

## Repo layout

```
project-documentation-ai/
  README.md
  install.sh                     # copies the skill into ~/.claude/skills
  LICENSE
  groundwork/                    # the skill (self-contained)
    SKILL.md                     # phase router + operating principles
    references/workflow.md       # detailed step-by-step for every phase
    templates/                   # copy-paste scaffolds
      knowledge-base.md
      module-doc.md
      ticket.md
      implementation-plan.md
      decision-log.md
      rules/
        RULES-INDEX.md
        single-responsibility.md
        typescript-jsdoc.md
        clean-architecture.md
```

---

## Install

A skill is just a folder containing `SKILL.md`. Claude Code discovers it in either location:

- **Personal** (`~/.claude/skills/`) — available in every repo you work in.
- **Project** (`<repo>/.claude/skills/`) — committed with one repo, shared with its team.

### Option A — let your agent install it from this URL (no manual steps)

Paste this into Claude Code (or Codex) chat **in the repo you want to set up**:

```
Install the Claude Code skill at https://github.com/ZH1245/project-documentation-ai:
git clone it to a temp dir, then ASK ME what command name I want it installed under
(default: groundwork). Run `./install.sh <that-name>`, then `/<that-name> onboard this repo`.
```

The agent has shell access, so it clones the repo, asks your preferred command name, installs the
skill under it, and starts Phase 0. (There's no native "install a skill straight from a URL" command
yet — the agent does the clone + install for you. See
[How the paste-URL method works](#how-the-paste-url-method-works).)

### Option B — one command

```bash
git clone https://github.com/ZH1245/project-documentation-ai.git
cd project-documentation-ai && ./install.sh          # or: ./install.sh <your-command-name>
```

### Option C — manual, personal

```bash
mkdir -p ~/.claude/skills
cp -R groundwork ~/.claude/skills/groundwork
```

### Option D — install into a specific repo (commit for the team)

Run from inside the target repo:

```bash
mkdir -p .claude/skills
cp -R /path/to/project-documentation-ai/groundwork .claude/skills/groundwork
git add .claude/skills/groundwork && git commit -m "Add groundwork skill"
```

### Option E — organization-wide

Bundle `groundwork/` in a Claude Code **plugin** and publish it to your team's plugin marketplace;
teammates install the plugin and get the skill automatically. (Interim: everyone uses Option A or B.)

> Restart Claude Code (or start a new session) after installing so the skill is picked up.

---

## How the paste-URL method works

Claude Code and Codex can run shell commands, so "install from a URL" is really: *the agent clones
this repo and copies the skill folder into a skills directory.* That's exactly what the Option A
prompt tells it to do. You can make it a project install instead by changing the destination to
`.claude/skills/groundwork` inside the target repo. Once the folder with `SKILL.md` is in place and
the session restarts, `/groundwork` is available.

---

## Using it (init in your repo)

Invoke the skill by name and pass a starting instruction — the prompt tells it **which phase to run**:

```
/groundwork <prompt>
```

| Goal                            | Prompt                                                                 |
| ------------------------------- | ---------------------------------------------------------------------- |
| Onboard a new repo              | `/groundwork onboard this repo, the agent knows nothing about it`      |
| Build the knowledge base        | `/groundwork build a knowledge base, split technical docs per module`  |
| Add code rules                  | `/groundwork set up code rules for this React + TS repo`               |
| Add architecture rules          | `/groundwork add global architecture and code-division rules`          |
| Plan a feature from a ticket    | `/groundwork new feature — <paste the client ticket here>`             |
| Record a lesson                 | `/groundwork remember: always use idempotency keys on the payments API — it caused double charges` |

A new repo usually flows **0 → 1 → 2 → 3** once, then repeats **Phase 4** per feature and **Phase 5**
whenever a lesson appears. You can also just describe the task in plain language — the skill's
`description` lets Claude trigger it automatically (e.g. "set up docs and rules for this repo").

The skill **asks before assuming** structure choices (docs location, per-feature vs per-module), so
each repo is set up its own way.

---

## Choose your own command name

The skill is invoked by its **name** — the folder under `~/.claude/skills/` and the `name:` field in
`SKILL.md`. `install.sh` sets both for you:

```bash
./install.sh docsetup      # installs as /docsetup instead of /groundwork
```

Name rules: lowercase letters, digits, and hyphens. In the paste-URL flow (Option A) the agent
**asks you** which name to use, then installs under it. To change the name later, just re-run
`install.sh` with the new one.

---

## License

MIT — see [LICENSE](./LICENSE).
