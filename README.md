# suspec-skills

> The skills catalog for [Suspec](https://github.com/jcosta33/suspec) — the complete methodology family plus universal engineering disciplines, in the open Agent Skills format, installable into any agent CLI.

Each skill is a self-contained folder under [`skills/`](./skills/): one `SKILL.md` with a trigger description and the working rules, plus bundled `references/` where a skill ships a fillable session frame. No scripts, no runtime — markdown an agent loads when the work matches.

The catalog has two groups:

- **The Suspec methodology** — the skills that run the Suspec loop: authoring specs and the other typed artifacts, implementing task packets, reviewing output against the spec, splitting work, saving findings. Install these **globally** — the methodology travels with you, not with any one repo.
- **Universal disciplines** — market/review methods, evidence disciplines, and code-lifecycle fundamentals. Framework-free; each stands alone in any repo.

**The zero-overlap rule:** globally installed skills carry the methodology; a repo's own `.agents/skills/` carries only repo-specific guides (its conventions, its architecture rules). The two tiers never ship the same guide — that is what keeps a repo's guides from skewing against an evolving methodology.

## Install

### Global (recommended)

With the [Vercel skills CLI](https://github.com/vercel-labs/skills) (works with Claude Code, Cursor, Codex, OpenCode, Gemini CLI):

```bash
# install the catalog at user level — available in every repo
npx skills add jcosta33/suspec-skills -g

# or a single skill
npx skills add jcosta33/suspec-skills --skill revolver-review -g

# target a specific agent
npx skills add jcosta33/suspec-skills --skill revolver-review -a claude-code
```

No CLI? Copy the skill folders to **both** user-level catalogs — `~/.claude/skills/` and `~/.agents/skills/` — or copy to one and symlink the other to it:

```bash
cp -R skills/* ~/.agents/skills/
ln -s ~/.agents/skills ~/.claude/skills   # if ~/.claude/skills does not already exist
```

### Per-repo (secondary)

To pin a specific skill version to one repo — or to ship a repo-specific guide — install into the repo instead:

```bash
npx skills add jcosta33/suspec-skills --skill revolver-review
# or: cp -R skills/revolver-review <your-repo>/.agents/skills/
```

Reserve per-repo installs for pinning; the methodology itself belongs at user level.

Pin to a tag or commit for stability and re-run to re-fetch. The catalog is
[semver](https://semver.org)-versioned ([`VERSION`](./VERSION), [`CHANGELOG.md`](./CHANGELOG.md));
watch the [releases](https://github.com/jcosta33/suspec-skills/releases) and re-pull when a bump matters.

## The AGENTS.md contract

Skills name abstract command slots — `cmdTest`, `cmdLint`, `cmdTypecheck`, `cmdValidate` — never concrete commands. The consuming repo's `AGENTS.md` Commands table supplies the implementations. That split is what makes a skill portable: the guide carries the discipline, your repo carries the toolchain. An empty slot means **ask** — a skill never invents a command. The [Suspec starter kit](https://github.com/jcosta33/suspec-starter-kit) seeds this contract in a repo for you.

## Catalog — the Suspec methodology

The skill family that runs the Suspec loop. Artifacts (specs, task packets, review packets, findings) are the agent's typed working memory: they live in the personal store, the launch prompt hands over their absolute paths, and durable value is promoted — to ADRs, tests, GitHub issues, and PR digests.

### The core loop

| Skill            | Use it when                                                                                                                   |
| ---------------- | ------------------------------------------------------------------------------------------------------------------------------ |
| `write-spec`     | turning intent into verifiable requirements — one AC per id, each with a `Verify with:` line                                   |
| `spec-check`     | checking a spec by hand against the checks contract before work is cut from it                                                 |
| `split-work`     | the work is too big for one run — cut task packets that cover every requirement exactly once and never collide                 |
| `implement-task` | implementing a task packet or spec — stay in scope, run every Verify item, paste real output, self-review before handoff       |
| `review-output`  | reviewing finished work against its spec — refute by default, re-run the checks yourself, evidence every row                   |
| `save-findings`  | closing a run — save each durable lesson as a finding artifact, ready for triage (promote / keep / discard) at `suspec done`   |

### Authoring the other artifacts

| Skill               | Use it when                                                                                                   |
| ------------------- | --------------------------------------------------------------------------------------------------------------- |
| `write-prd`         | capturing the product problem and success measures before any spec exists                                       |
| `write-rfc`         | a contested approach needs a recorded comparison and an explicit decision request                               |
| `write-research`    | one open question needs an evidence base from external primary sources                                          |
| `write-audit`       | recording the present state of a code area — observations with evidence, no prescriptions                       |
| `write-inventory`   | mapping what exists before a rewrite or migration — the observation half of a transformation                    |
| `write-change-plan` | a structural transformation needs baseline, waves, preservation guarantees, and rollback written down           |
| `write-bug-report`  | diagnosing a defect to its root cause — reproduction pasted, no fix                                             |

### Task-implementation depth

Per-kind execution discipline for an implementing agent — each ships a fillable run-notes frame.

`write-feature` · `write-fix` · `write-refactor` · `write-rewrite` · `write-migration` · `write-performance` · `write-testing` · `write-documentation`

## Catalog — universal disciplines

Everything below is framework-free — installable into any repo with zero Suspec knowledge.

### Market and review methods

Cross-cutting methods loaded _alongside_ the work — they change what the agent must prove, verify, and refuse.

| Skill                | Use it when                                                                                                                                                         |
| -------------------- | ------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| `persona-challenger` | pressure-testing a live proposal before it's built — surface assumptions, steelman the alternative, ground the challenge in external evidence                       |
| `market-research`    | market, customer, competitor, or UX-pattern research — type claims, triangulate evidence, grade confidence, and preserve uncertainty                                |
| `bulletproof`        | hardening an important claim, decision, spec, or plan before it ships — expose unsupported claims, hidden assumptions, and failure modes, then verdict on already-run evidence, not confidence |
| `revolver-review`    | driving a substantial change to a clean state — a rotating pool of at least 6 distinct stances fired one reviewer at a time on cheap varied models, fixing between rounds and re-reviewing the revised code, one stance per round, up to 3 cycles |

### Disciplines

Framework-free practices that raise the floor on any task, in any repo.

| Skill                | Use it when                                                                                                                                                         |
| -------------------- | ------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| `empirical-proof`    | any completion claim — bind it to verbatim pasted output, or it reads unverified                                                                                    |
| `concise-output`     | you want terse, scannable, token-economical output — evidence-first, structure over prose, no filler (clarity still outranks brevity)                               |
| `fix-flaky-test`     | a test that fails intermittently — reproduce by looping, fix the cause not the assertion, don't retry-loop                                                          |

### Code-lifecycle

The fundamental coding skills, re-baselined from a live adoption census ([best-of-breed sources](./docs/sources.md#best-of-breed-implementations)) — each a framework-free distillation of the strongest public implementation of that fundamental.

| Skill                  | Use it when                                                                                                                                                       |
| ---------------------- | ---------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| `codebase-exploration` | mapping an unfamiliar codebase — delegate read-only recon to subagents, build a key-files map before reading, keep the orchestrator's context clean              |
| `debugging`            | a live defect — runtime-evidence-before-hypothesis: reproduce → isolate → identify → verify; refuse a root cause until execution data localizes it               |
| `security-review`      | a risk-bearing change — semantic data-flow review + a tunable false-positive filter + per-language footguns; drive real scanners (Semgrep/CodeQL) when present    |
| `git-pr`               | shipping — stage→commit→push→PR, address review comments, fix failing CI by reading logs, isolate parallel work in git worktrees                                  |
| `planning-spec`        | before you build — plan against the project's durable principles, name what's out of scope, get an explicit human "go" before breaking the plan into steps        |

## Where to start

1. **The methodology group, globally.** One `-g` install gives every repo the loop.
2. **`revolver-review`** — load it when an agent _judges another agent's_ substantial change and you want it driven to a clean state, not a merge sign-off.
3. **`empirical-proof`** — pair it with any completion claim to force verbatim pasted output; the fastest cure for "done" that was never actually checked.
4. **A code-lifecycle skill** matching the work — `debugging` for a live defect, `security-review` for a risk-bearing change, `codebase-exploration` for an unfamiliar repo, `planning-spec` before you build, `git-pr` to ship.
5. **A cross-cutting method** when you need a focused discipline — `persona-challenger` while pressure-testing a proposal, or `market-research` for market, customer, competitor, or UX-pattern evidence synthesis.

## The science

[`docs/`](./docs/) documents the empirical evidence behind every structural choice in these skills — why descriptions are directive ([activation](./docs/activation.md)), why bodies target ~200 lines under a 500-line hard cap ([body anatomy](./docs/body-anatomy.md)), why verification steps force visible output ([execution](./docs/execution.md)), why skills don't depend on each other ([self-containment](./docs/self-containment.md)), when a skill ships a task template ([task files](./docs/task-files.md)), and what deliberately stays out ([scope](./docs/scope.md)) — with the full bibliography in [sources](./docs/sources.md).

## Security

Read a skill before installing it — a skill is instructions your agent will follow. Everything here is plain markdown: no scripts, no network calls, no executables. Pin to a commit if you need a stable install.

## Relationship to the Suspec framework

The framework and its docs live at [jcosta33/suspec](https://github.com/jcosta33/suspec); the thin repo-seed (the `AGENTS.md` seed, artifact templates, and `suspec.config.json` conventions a repo adopts) is [jcosta33/suspec-starter-kit](https://github.com/jcosta33/suspec-starter-kit). The sibling catalog [jcosta33/suspec-agents](https://github.com/jcosta33/suspec-agents) ships Claude-Code-first worker definitions for the Suspec roles — agent-neutral disciplines here, runner-specific agents there. The universal group assumes nothing about Suspec — each of those skills stands alone in any repo with an `AGENTS.md`. This catalog is curated: skill content is edited here.
