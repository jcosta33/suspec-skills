# suspec-skills

> The skills catalog for [Suspec](https://github.com/jcosta33/suspec) — the complete methodology family plus universal engineering disciplines, in the open Agent Skills format, installable into any agent CLI.

Each skill is a self-contained folder under [`skills/`](./skills/): one `SKILL.md` with a trigger description and the working rules, plus bundled `references/` where a skill ships a fillable session frame. No scripts, no runtime — markdown an agent loads when the work matches.

The catalog spans:

- **The Suspec methodology** — the skills that run the Suspec loop: authoring specs and the other typed artifacts, implementing task packets, reviewing output against the spec, splitting work, saving findings. Install these **globally** — the methodology travels with you, not with any one repo.
- **Universal disciplines** — market/review methods, evidence disciplines, and code-lifecycle fundamentals. Framework-free; each stands alone in any repo.

**The zero-overlap rule:** globally installed skills carry the methodology and the universal disciplines; a repo's own `.agents/skills/` carries only repo-specific guides (its conventions, its architecture rules). The two surfaces never ship the same guide. That keeps repository guidance local without forking the methodology.

## Install

### Global (recommended)

With the [Vercel skills CLI](https://github.com/vercel-labs/skills) (works with Claude Code, Cursor, Codex, OpenCode, Gemini CLI), target the runner you use so the CLI does not fan the install out to every supported harness:

```bash
# install the catalog at user level — available in every repo
npx skills add jcosta33/suspec-skills -g -a codex
# Claude Code instead:
npx skills add jcosta33/suspec-skills -g -a claude-code

# or a single skill for Codex
npx skills add jcosta33/suspec-skills --skill revolver -g -a codex
```

No CLI? Copy the skill folders to **both** user-level catalogs — `~/.claude/skills/` and `~/.agents/skills/` — or copy to one and symlink the other to it:

```bash
mkdir -p ~/.agents/skills ~/.claude
cp -R skills/* ~/.agents/skills/
ln -s ~/.agents/skills ~/.claude/skills   # if ~/.claude/skills does not already exist
```

### Per-repo (secondary)

To pin a specific skill version to one repo — or to ship a repo-specific guide — install into the repo instead:

```bash
npx skills add jcosta33/suspec-skills --skill revolver -a codex
# or:
mkdir -p <your-repo>/.agents/skills
cp -R skills/revolver <your-repo>/.agents/skills/
```

Reserve per-repo installs for pinning; the methodology itself belongs at user level.

Record the source commit when stability matters, and re-run the install command when you choose to
refresh the catalog.

## The AGENTS.md contract

Skills name abstract command slots — `cmdTest`, `cmdLint`, `cmdTypecheck`, `cmdValidate` — never concrete commands. The consuming repo's `AGENTS.md` Commands table supplies the implementations. That split is what makes a skill portable: the guide carries the discipline, your repo carries the toolchain. An empty slot means **ask** — a skill never invents a command. A repo without the table adds one to its `AGENTS.md` by hand.

## Catalog — the Suspec methodology

The skill family that runs the Suspec loop. Intent, review, and findings are always present, but their carrier scales with the work: intent may remain inline or become a spec, review may be direct or use a packet, and findings become native memories or move through project channels. Specs, task splits, inventories, change plans, and deterministic checking are scaffold used when evidence from the work warrants them. Files live beside the agent's native artifacts unless project governance says otherwise, and later steps carry their full paths forward.

### The core loop

| Skill            | Use it when                                                                                                                   |
| ---------------- | ------------------------------------------------------------------------------------------------------------------------------ |
| `write-spec`     | turning intent into verifiable requirements — one AC per id, each with a `Verify with:` line                                   |
| `spec-check`     | checking a spec by hand against the checks contract before work is cut from it                                                 |
| `split-work`     | a spec or change plan has separately dispatchable slices — cut exact, ordered, collision-safe task packets                    |
| `implement-task` | generic or unclassified task packets only; specialized implementation skills take precedence                              |
| `review-output`  | reconciling finished work against its spec — assess evidence, then route acceptance to the human picker                       |
| `save-findings`  | closing work — use native memory when supported, project channels for team residue, and no substitute store                     |
| `disrespec`      | creating or revising any Markdown artifact — maximum clarity per token and file-only handoff                                  |

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

| Skill                 | Use it when                                                                        |
| --------------------- | ----------------------------------------------------------------------------------- |
| `write-feature`       | the task adds net-new capability — survey the patterns first, then build            |
| `write-fix`           | the task repairs a diagnosed defect — reproduction first, minimal change            |
| `write-refactor`      | the task restructures without behavior change — equivalence proven per batch        |
| `write-rewrite`       | the task replaces an implementation wholesale — the delta table drives it           |
| `write-migration`     | the task moves callers across a boundary — callsite tracker, shim, rollback         |
| `write-performance`   | the task chases a measured target — baseline pasted before any change               |
| `write-testing`       | the task authors tests — each test proven to fail for its intended violation         |
| `write-documentation` | the task writes human-facing docs — one frame held, every example run               |

## Catalog — universal disciplines

Everything below is framework-free — installable into any repo with zero Suspec knowledge.

### Market and review methods

Cross-cutting methods loaded _alongside_ the work — they change what the agent must prove, verify, and refuse.

| Skill                | Use it when                                                                                                                                                         |
| -------------------- | ------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| `market-research`    | market, customer, competitor, or UX-pattern research — type claims, triangulate evidence, grade confidence, and preserve uncertainty                                |
| `bulletproof`        | actively fact-checking every explicit and load-bearing implied claim without editing the target                                                     |
| `demolition`         | explicit one-sided advocacy against an idea or design, quarantined from evidence and findings                                                       |
| `revolver`           | broad risk-derived inspection over any target; complete rotations, inspect by default, refine only when requested                                    |
| `triple-check`       | exactly three fresh top-tier passes for narrow depth; fixed snapshot by default                                                                      |
| `promote-artifact`   | explicitly moving a whole artifact into a project-native durable destination, repairing references, never implicitly pushing                         |

### Disciplines

Framework-free practices that raise the floor on any task, in any repo.

| Skill                | Use it when                                                                                                                                                         |
| -------------------- | ------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| `empirical-proof`    | current command evidence written once; large raw output moves to stable evidence receipts                                                            |
| `fix-flaky-test`     | a test that fails intermittently — reproduce by looping, fix the cause not the assertion, don't retry-loop                                                          |

### Code-lifecycle

The fundamental coding skills, informed by inspected public [reference implementations](./docs/sources.md#code-lifecycle-reference-implementations) and kept framework-free.

| Skill                  | Use it when                                                                                                                                                       |
| ---------------------- | ---------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| `codebase-exploration` | mapping an unfamiliar codebase — delegate read-only recon to subagents, build a key-files map before reading, keep the orchestrator's context clean              |
| `debugging`            | a live defect — runtime-evidence-before-hypothesis: reproduce → isolate → identify → verify; refuse a root cause until execution data localizes it               |
| `security-review`      | a risk-bearing change — semantic data-flow review + a tunable false-positive filter + per-language footguns; drive real scanners (Semgrep/CodeQL) when present    |
| `git-pr`               | shipping through the repo's approved flow — stage, commit, push when asked, open a PR when required, close review and CI loops                                    |
| `planning-spec`        | before you build — plan against the project's durable principles, name what's out of scope, get an explicit human "go" before breaking the plan into steps        |

## Where to start

1. **The methodology group, globally.** One `-g` install gives every repo the loop.
2. **`revolver`** — use breadth inspection when several target-derived risk stances need independent passes.
3. **`empirical-proof`** — bind runnable completion claims to verbatim output and every other claim to
   exact durable evidence; the fastest cure for "done" that was never actually checked.
4. **A code-lifecycle skill** matching the work — `debugging` for a live defect, `security-review` for a risk-bearing change, `codebase-exploration` for an unfamiliar repo, `planning-spec` before you build, `git-pr` to ship.
5. **A cross-cutting method** matching the question: `bulletproof` for claim verification,
   `triple-check` for depth, `demolition` for explicit advocacy, or `market-research` for market evidence.

## The science

[`docs/`](./docs/) separates specification requirements, official guidance, empirical evidence, and catalog conventions: directive descriptions ([activation](./docs/activation.md)), compact bodies and progressive disclosure ([body anatomy](./docs/body-anatomy.md)), visible evidence ([execution](./docs/execution.md)), standalone installation ([self-containment](./docs/self-containment.md)), private run-note templates ([task files](./docs/task-files.md)), and repository boundaries ([scope](./docs/scope.md)). The bibliography is in [sources](./docs/sources.md).
The [existence test](./docs/skill-existence-test.md) records the boundaries between plausible overlaps.

## Security

Read a skill before installing it — a skill is instructions your agent will follow. Everything here is plain markdown: no scripts, no network calls, no executables. Pin to a commit if you need a stable install.

## Relationship to the Suspec framework

The framework and its docs live at [jcosta33/suspec](https://github.com/jcosta33/suspec). Adopting it is installing these skills; the skills carry the artifact shapes and placement guidance. [jcosta33/suspec-cli](https://github.com/jcosta33/suspec-cli) is earned deterministic scaffold over artifacts it is handed — `suspec check <path>` — enforcing the checks contract documented in the Suspec repo's [`docs/reference/checks.md`](https://github.com/jcosta33/suspec/blob/main/docs/reference/checks.md). The sibling catalog [jcosta33/suspec-agents](https://github.com/jcosta33/suspec-agents) ships runner-specific worker definitions; agent-neutral disciplines live here. The universal group assumes nothing about Suspec. Skill content is edited here.
