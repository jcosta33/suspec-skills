# suspec-skills

Portable Markdown skills for explicit decisions, evidence-bound work, and ruthless economy. Every
folder under [`skills/`](./skills/) stands alone. No runtime, registry, vendor, or hidden family
meeting required.

## Install

```bash
npx skills add jcosta33/suspec-skills -g -a codex
npx skills add jcosta33/suspec-skills -g -a claude-code
npx skills add jcosta33/suspec-skills --skill revolver -g -a codex
npx skills add https://github.com/jcosta33/suspec-skills/tree/<commit> -g -a codex
```

The last form pins a commit. Re-running `add` updates present entries but does not prune removed
names. Inspect `overwrites:` before confirming. Compare any existing folder with the source tree;
cancel on mismatch. Remove a retired entry only after the same comparison. Name alone proves nothing.

## Universal methods

| Skill                                            | Use                                              |
| ------------------------------------------------ | ------------------------------------------------ |
| [`bulletproof`](./skills/bulletproof/SKILL.md)   | actively verify load-bearing claims              |
| [`campaign`](./skills/campaign/SKILL.md)         | deliver large goals through reusable lanes       |
| [`demolition`](./skills/demolition/SKILL.md)     | run quarantined one-sided advocacy               |
| [`dissect`](./skills/dissect/SKILL.md)           | trace a code path and coupling to closure        |
| [`disrespec`](./skills/disrespec/SKILL.md)       | remove wasted prose                              |
| [`fork-me`](./skills/fork-me/SKILL.md)           | force ambiguity into human selection             |
| [`revolver`](./skills/revolver/SKILL.md)         | exhaust broad risk through sequential refinement |
| [`triple-check`](./skills/triple-check/SKILL.md) | run three concurrent top-tier reviews            |
| [`promote`](./skills/promote/SKILL.md)           | move a transient artifact into project ownership |
| [`remember`](./skills/remember/SKILL.md)         | preserve one verified lesson                     |

## Artifact authors

| Skill                                                  | Artifact                                   |
| ------------------------------------------------------ | ------------------------------------------ |
| [`sus-spec`](./skills/sus-spec/SKILL.md)               | intent and verifiable requirements         |
| [`sus-task`](./skills/sus-task/SKILL.md)               | collision-safe spec slices                 |
| [`sus-review`](./skills/sus-review/SKILL.md)           | independent assessments and human decision |
| [`sus-inventory`](./skills/sus-inventory/SKILL.md)     | evidenced current-state map                |
| [`sus-change-plan`](./skills/sus-change-plan/SKILL.md) | preservation, waves, cutover, rollback     |
| [`sus-audit`](./skills/sus-audit/SKILL.md)             | evidenced present-state risks              |
| [`sus-research`](./skills/sus-research/SKILL.md)       | decision-informing evidence                |

Only `sus-*` skills create Suspec artifacts. Universal methods do work, not paperwork. Artifact
authors use absolute paths under
`~/.agents/artifacts/<workspace>/` and close exhausted sets through Delete, Leave, or Promote.

Each skill carries its own load-bearing rules. Agents assess and recommend; humans own intent,
waivers, irreversible actions, and acceptance. Catalog design and evidence live under
[`docs/`](./docs/). Canon and deterministic checks live in
[Suspec](https://github.com/jcosta33/suspec) and
[suspec-cli](https://github.com/jcosta33/suspec-cli).

## Security

Inspect instructions before installation. You are installing words into an agent's head; act
accordingly. Payloads contain Markdown only: no scripts, executables, hooks, or network clients.
Repository shell scripts lint the source catalog.
