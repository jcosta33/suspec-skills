# corpus-skills

> The optional skills catalog for [Corpus](https://github.com/jcosta33/corpus) — conditioning stances, code-lifecycle disciplines, and review/output style in the open Agent Skills format, installable into any agent CLI.

Each skill is a self-contained folder under [`skills/`](./skills/): one `SKILL.md` with a trigger description and the working rules, plus bundled `references/` where a skill ships a fillable session frame. No scripts, no runtime — markdown an agent loads when the work matches.

The [Corpus starter kit](https://github.com/jcosta33/corpus-starter-kit) ships every Corpus-coupled skill — the core loop (`write-spec`, `implement-task`, `review-output`), the workspace authoring guides (`write-audit`, `write-research`, `write-rfc`, `write-prd`, `write-bug-report`, `write-change-plan`, `write-inventory`, `spec-check`, `split-work`, `save-findings`), and the task-implementation depth (`write-feature`, `write-fix`, `write-refactor`, `write-rewrite`, `write-migration`, `write-performance`, `write-testing`, `write-documentation`). Everything **here** is the universal layer — stances, disciplines, review style, output economy — framework-free and installable in any repo; install only what your work calls for.

## Install

With the [Vercel skills CLI](https://github.com/vercel-labs/skills) (works with Claude Code, Cursor, Codex, OpenCode, Gemini CLI):

```bash
# list what's available
npx skills add jcosta33/corpus-skills --list

# install one skill into the current repo
npx skills add jcosta33/corpus-skills --skill adversarial-review

# install globally, or for a specific agent
npx skills add jcosta33/corpus-skills --skill adversarial-review -g
npx skills add jcosta33/corpus-skills --skill adversarial-review -a claude-code
```

No CLI? Copy the folder: `cp -R skills/adversarial-review <your-repo>/.agents/skills/` (point your tool's skills directory at the same folder — e.g. a `.claude/skills` symlink).

Pin to a tag or commit for stability and re-run to re-fetch. The catalog is
[semver](https://semver.org)-versioned ([`VERSION`](./VERSION), [`CHANGELOG.md`](./CHANGELOG.md));
watch the [releases](https://github.com/jcosta33/corpus-skills/releases) and re-pull when a bump matters.

## The AGENTS.md contract

Skills name abstract command slots — `cmdTest`, `cmdLint`, `cmdTypecheck`, `cmdValidate` — never concrete commands. The consuming repo's `AGENTS.md` Commands table supplies the implementations. That split is what makes a skill portable: the guide carries the discipline, your repo carries the toolchain. An empty slot means **ask** — a skill never invents a command. The [Corpus starter kit](https://github.com/jcosta33/corpus-starter-kit) sets this contract up for you.

## Where to start

You don't need any of these to run Corpus — the [starter kit](https://github.com/jcosta33/corpus-starter-kit)
already ships the core loop. Add skills only as a specific need shows up, in roughly this order:

1. **Nothing.** Run the loop with the kit's core guides. Most changes never need more.
2. **`adversarial-review`** — the first one most teams want. Load it when an agent _judges another
   agent's_ change (branch / PR / diff / audit / bug): it refutes by default, re-runs the checks
   itself, and produces findings — not a merge sign-off. (It absorbs the old `persona-skeptic`
   stance; that name now redirects here.)
3. **`empirical-proof`** — pair it with any completion claim to force verbatim pasted output; the
   fastest cure for "done" that was never actually checked.
4. **A code-lifecycle skill** matching the work — `debugging` for a live defect, `security-review`
   for a risk-bearing change, `codebase-exploration` for an unfamiliar repo, `planning-spec` before
   you build, `git-pr` to ship. Install the one the task calls for, not the set.
5. **A cross-cutting stance** when you need a posture _without_ its host guide —
   `persona-challenger` while pressure-testing a proposal before it's built, or `persona-surveyor`
   for a breadth survey. (The authoring stances — architect, auditor, researcher, documentarian —
   ship folded into their work guide; you get them by using the guide, not as a standalone.)

Rule of thumb: install the fewest skills that name the discipline your current task is missing.

## Catalog

Everything here is **universal** — framework-free, installable into any repo with zero Corpus knowledge.
Corpus-coupled skills (the artifact builders + the `write-*` task-implementation depth) live in the
[starter kit](https://github.com/jcosta33/corpus-starter-kit) instead, not here.

### Stances

Cross-cutting cognitive postures loaded _alongside_ the work — they tilt what the agent looks for and refuses. The 1:1 authoring stances (architect/auditor/researcher/documentarian) are **not** here: they live folded into their work guide in the kit, their single source.

| Skill                | Use it when                                                                                                                                                         |
| -------------------- | ------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| `persona-challenger` | pressure-testing a live proposal before it's built — surface assumptions, steelman the alternative, ground the challenge in external evidence                       |
| `persona-surveyor`   | breadth research — what prevails across many products, patterns, or users; three named instances per claimed pattern                                                |

> `persona-skeptic` is **retired** — its refute-by-default stance is now the spine of `adversarial-review`. The folder remains as a redirect.

### Disciplines

Framework-free practices that raise the floor on any task, in any repo.

| Skill                | Use it when                                                                                                                                                         |
| -------------------- | ------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| `adversarial-review` | reviewing a branch / PR / diff / audit / bug — refute by default, run the checks yourself, the multi-lens panel; you produce findings, not the merge decision (absorbs the former `persona-skeptic`) |
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

## The science

[`docs/`](./docs/) documents the empirical evidence behind every structural choice in these skills — why descriptions are directive ([activation](./docs/activation.md)), why bodies stay under 200 lines ([body anatomy](./docs/body-anatomy.md)), why verification steps force visible output ([execution](./docs/execution.md)), why skills don't depend on each other ([self-containment](./docs/self-containment.md)), when a skill ships a task template ([task files](./docs/task-files.md)), and what deliberately stays out ([scope](./docs/scope.md)) — with the full bibliography in [sources](./docs/sources.md).

## Security

Read a skill before installing it — a skill is instructions your agent will follow. Everything here is plain markdown: no scripts, no network calls, no executables. Pin to a commit if you need a stable install.

## Relationship to the Corpus framework

These skills assume nothing about Corpus — each stands alone in any repo with an `AGENTS.md`. They pair naturally with the Corpus working discipline (specs with verifiable requirements, task packets with evidence-backed claims, review packets as the durable record); the framework and its docs live at [jcosta33/corpus](https://github.com/jcosta33/corpus), the copy-whole workspace at [jcosta33/corpus-starter-kit](https://github.com/jcosta33/corpus-starter-kit). This catalog is curated: skill content is edited here, and changes are planned and reviewed in the Corpus project's workspace.
