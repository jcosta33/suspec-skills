---
name: review-output
type: agent-guide
description: >-
  Review finished work against its SPEC: refute by default, re-run the checks
  yourself, draft evidence and findings for every spec requirement, and route
  what a human must decide without issuing the result. ALWAYS apply when asked to review a
  finished task, a diff, or a PR against a spec, or to fill a review packet.
  Reconcile against the spec, never the task; leave Result cells, packet status,
  waivers, and the suggested decision to the human; never review a change you
  wrote. Skip for writing specs and implementing tasks.
---

# Review output against the spec

The review packet is named `review-<slug>.md`.

Place the file next to your own native artifacts — the same place you keep your plans,
notes, and memories for this work, in a folder named after the repo you are working on
(or wherever fits your harness best). You choose the exact spot; keep it out of the repo
unless the project's own governance says otherwise, and carry the file's full path
forward — every later step names artifacts by explicit path.

It prepares the evidence for one human judgment: **whether the code honors the spec**. Your stance is
refute-by-default: "done" is a claim until the evidence survives scrutiny. Grounding every scoped
requirement is this review's **primary job**; everything else (style, neatness) is secondary. You
produce findings and evidence, never the result. The human reviewer fills coverage Result cells,
packet status, waivers, and the suggested decision. The deterministic checker is run against that
human-finalized packet with
`suspec check <review-path> --spec <spec-path> [--task <task-path>]` (spec is always required; task
only when this review's frontmatter names one — a missing required companion is blocking).

**Reconcile against the spec, never the task.** The requirement, its `Verify with:` method, and the bar
for Pass come from the **spec's** ACs — the spec is the source of truth for *what* must be true. A task,
when one exists, tells you only *which* ACs are in scope (it covers a partial slice of the spec) and
*indexes the evidence* in its `## Run summary`; it never defines the requirement and is never the thing
you validate against. This keeps the review independent when task splitting was warranted.

## Getting an independent reviewer — self-contained

You may not review a change you wrote — an author favors their own output, and independence is the
whole point. The self-contained way to get it needs no installed catalog: **spawn a fresh subagent**
and hand it the diff, the spec, and this discipline without the author's conclusions. Fresh context
reduces reasoning carryover but does not guarantee independence; prompt content and model provenance
still matter. (The `suspec-reviewer` agent in
suspec-agents is an accelerator over this same path — a pre-built reviewer definition — but it is never
required; spawning a fresh reviewer is a harness capability, not a dependency.)

## Rules

1. **The implementer's paste is a claim; your run is evidence.** Re-run every check yourself wherever
   possible — resolve commands from the `AGENTS.md` `Commands` table; if a needed command is missing,
   ask, never guess. Paste _your_ output into the Evidence column. If you could not run a check, leave
   Evidence empty and route the reason to Human attention; do not fill the Result cell. _Why: a paste
   shows the command ran at some past moment on some past code, not that it describes the diff in
   front of you._
2. **One row per spec AC in scope.** Draft the requirement-coverage table from the **spec's** ACs — all
   of them for 1:1 work, or the subset a task's Scope names when a task exists. Leave every Result cell
   empty for the human reviewer. Fill Evidence with output you reran, a directly inspected CI link, or
   a named human's recorded observation for a manual `Verify` method. A scoped AC with no row is a
   missing row, not a free pass.
3. **Read the evidence index first.** For a task, its `## Run summary` indexes the Verify pastes the
   cells cite; for 1:1 work, the spec's `## Execution` section. Read it before filling rows — but the
   *bar* each row is judged against is the spec's requirement, not the summary's phrasing.
4. **Inspect every row; review is not sampling.** For every applicable `Verify with:` item, rerun it
   and confirm the output exercises that exact AC. When rerunning is impossible, inspect durable CI or
   named manual evidence and record what exists; route the gap without assigning a Result.
5. **Prove the exact requirement, not a neighbour.** For each AC, point at the lines that address _that_
   requirement as the spec defines it — the first plausible match is how a hole gets approved. Treat
   "should never happen", "harmless", "edge case unlikely" in the implementer's summary as flags to check,
   not assurances.
6. **Read what did not change.** Callers of every changed public surface, tests, docs. _Why: the diff
   shows what changed, not what the change broke elsewhere._
7. **Change-plan guarantees are rows too.** When the work executes a change plan, every preservation
   guarantee gets its own row in the change-plan coverage table — same columns, same rules.
8. **Route the exceptions under `## Human attention`** — that list, not the diff, is what a human reads:
   unverified or failed requirements · out-of-scope changes · risky files · missing test output ·
   changed public interfaces · DB migrations · security-sensitive changes · finding candidates ·
   blocked questions. One line each: what, why it matters, suggested action. "No exceptions" is a valid,
   reportable outcome.
9. **Leave the result to the human.** Do not write Pass, Fail, Unverified, or Blocked into a Result
   cell; do not write a suggested decision or waiver. State the observed fact and concern under Human
   attention. The human reviewer owns every disposition.
10. **Save finding candidates.** Anything durable the work surfaced — a fact, a decision, a pattern, a
    gotcha — is recorded here; for 1:1 work, carry forward anything the implementer noted in the
    spec's Execution entry, since the spec itself holds no `## Findings` section. Findings ride the
    review packet. At Close, only evidence-backed, durable lessons move into native memory or the
    project's own channels.
11. **Keep the status `draft`.** Do not set `pass`, `waived`, `blocked`, or `needs-human`; those values
    record the human reviewer's result. A complete agent handoff is still a draft because evidence and
    findings are not the verdict.

## Refuses

| Red flag                                                 | Action                                                               |
| -------------------------------------------------------- | -------------------------------------------------------------------- |
| "Tests passed" with no command, exit, or output          | Produce the real run or route the evidence gap                       |
| Accepting the implementer's paste as final evidence      | Re-run it yourself; if you cannot, state why                         |
| Judging an AC against the task's wording, not the spec's | The spec is the bar; re-read the spec's requirement and Verify line  |
| Evidence that addresses a neighbouring AC, not this one  | Route the mismatch — evidence must match the ID                      |
| Schema-valid / well-formed output offered as correctness | Shape is not truth; check the value, not the format                  |
| Your run disagrees with the implementer's paste          | The discrepancy is itself a finding — investigate, do not dismiss it |
| A vague concern ("looks rough")                          | Sharpen it to a file and line, or drop it                            |
| Fixing the code mid-review                               | Review judges; the fix is a new task                                 |
| Reviewing a diff you authored                            | Spawn a fresh reviewer; record that you did                          |
| Filling Result, status, waiver, or suggested decision    | Leave Result blank and status draft; route facts to the human        |

## Gotchas

- **Treating the implementer's paste as evidence without re-running it.** A paste proves the command ran
  at some past moment on some past code, not that it describes the diff in front of you.
- **Filling a Result cell.** Even strong evidence does not transfer the human reviewer's authority to
  the agent. Leave the cell empty and make the evidence cheap to judge.
- **Reviewing against the task instead of the spec.** The task's one-line scope summary is a pointer,
  not the requirement. A task that under-describes an AC will pass a review keyed to it and fail the
  spec — judge against the spec's definition and its Verify line.
- **Letting the summary's confidence become a decision.** Confident prose is a claim to check, not a
  result to inherit; the human writes the disposition.

## Self-review gate

Before handing the draft to the human reviewer:

- [ ] Every scoped **spec** AC (and change-plan guarantee) has a row; every Result cell is empty.
- [ ] Every applicable Verify item was rerun or its evidence gap was routed to Human attention.
- [ ] You searched callers of changed public surfaces, not just the diff.
- [ ] Each Human-attention entry has what / why / suggested action; nothing was silently skipped.
- [ ] Finding candidates are recorded in the packet.
- [ ] You did not author the change you judged — an independent (fresh-context) reviewer produced this.
- [ ] Packet status remains `draft`; no waiver or suggested decision was issued.
