# suspec-skills

Portable Agent Skills that force clear decisions, evidence-bound artifacts, and ruthless economy.
Each folder under [`skills/`](./skills/) installs alone. No runtime, registry, or agent vendor is
required.

## Install

Use the [skills CLI](https://github.com/vercel-labs/skills) and target the harness you use:

```bash
npx skills add jcosta33/suspec-skills -g -a codex
npx skills add jcosta33/suspec-skills -g -a claude-code

# one skill
npx skills add jcosta33/suspec-skills --skill revolver -g -a codex
```

Pin the source revision when stability matters. Re-running `add` updates present entries but does
not prune names absent from the source. After a catalog change, remove only obsolete Suspec entries
with `npx skills remove`, then reinstall; never remove unrelated publishers' skills.

## Commands

### Universal Methods

| Skill | Use |
| --- | --- |
| [`bulletproof`](./skills/bulletproof/SKILL.md) | Fact-check every load-bearing claim with current evidence. |
| [`demolition`](./skills/demolition/SKILL.md) | Run an explicit one-sided attack quarantined from evidence. |
| [`dissect`](./skills/dissect/SKILL.md) | Trace a code path, state, and hidden coupling to closure. |
| [`disrespec`](./skills/disrespec/SKILL.md) | Remove every wasted token from a Markdown artifact. |
| [`fork-me`](./skills/fork-me/SKILL.md) | Force every ambiguity into explicit human selection. |
| [`revolver`](./skills/revolver/SKILL.md) | Resolve broad risk through at least six sequential target-derived stances. |
| [`triple-check`](./skills/triple-check/SKILL.md) | Inspect deeply through exactly three independent top-tier passes. |
| [`promote`](./skills/promote/SKILL.md) | Move a transient artifact into a project-owned durable destination. |
| [`remember`](./skills/remember/SKILL.md) | Preserve verified lessons through native memory or project channels. |

### Suspec Artifacts

| Skill | Artifact |
| --- | --- |
| [`sus-spec`](./skills/sus-spec/SKILL.md) | Intent and verifiable requirements. |
| [`sus-task`](./skills/sus-task/SKILL.md) | Collision-safe, spec-governed packets for genuinely split work. |
| [`sus-review`](./skills/sus-review/SKILL.md) | Independent requirement assessments and human decision capture. |
| [`sus-inventory`](./skills/sus-inventory/SKILL.md) | Evidence-bound map of current code and dependencies. |
| [`sus-change-plan`](./skills/sus-change-plan/SKILL.md) | Structural transformation, preservation, cutover, and rollback. |
| [`sus-audit`](./skills/sus-audit/SKILL.md) | Present-state observations and risks without prescriptions. |
| [`sus-research`](./skills/sus-research/SKILL.md) | Technical, product, market, customer, and competitor evidence. |

## Artifact Boundary

Only `sus-*` artifact authors create Suspec artifacts. They resolve this directory template
to an absolute path before writing:

```text
~/.agents/artifacts/<workspace>/
```

The repository stays untouched. Every handoff carries the absolute artifact path. After the work
has consumed the complete artifact set and no downstream step needs it, the agent asks whether to
Delete, Leave, or Promote it. Promotion moves the document into a project-owned durable location;
it does not create a Suspec store.

## Design Contract

- Skills install independently and contain every load-bearing rule they need.
- Discoverable facts are investigated before the human is interrupted.
- Every ambiguity becomes at least three clear options with a recommendation.
- Artifacts state each fact once and are not repeated in chat.
- Evidence is exact, current, and mapped to the claim it supports.
- Agents assess evidence and recommend. Humans own intent, waivers, irreversible actions, and final
  acceptance.
- Skill prose is ruthless and economical: hard imperatives, no filler, no default behavior, no
  inert negatives.

The rationale and evidence are under [`docs/`](./docs/). Framework canon and deterministic artifact
checks live in [Suspec](https://github.com/jcosta33/suspec) and
[`suspec-cli`](https://github.com/jcosta33/suspec-cli).

## Security

Read instructions before installing them. Every installed skill payload contains Markdown only: no
scripts, executables, hooks, or network calls. Repository-only shell scripts enforce catalog history
and current-surface rules.
