---
name: write-documentation
type: agent-guide
description: >-
  Implement a documentation task: write or update human-facing docs (README,
  tutorial, how-to, reference, explanation) — one frame held throughout, every
  example run as written, every behavior claim verified against an authoritative
  source. ALWAYS apply when asked to produce a doc a human (not an agent) reads,
  whether intent is inline or in a task packet. Never mix
  frames, hedge with should/might/could, ship unrun examples, or document
  beyond the task's requirements. Skip agent-facing material (guides,
  templates) and all code-changing kinds.
---

# Implement documentation

`DISRESPEC-SPINE: One fact once. No filler, repeated source material, empty sections, or chat restatement; after successful creation return only clickable artifact links, except for blockers, failed creation, incomplete verification, or irreversible-action confirmation.`

Documentation that hedges, ships examples that do not run, or contradicts the code is worse than no
documentation — it misleads, and the reader cannot tell. The reader is a human who may not have read
the code and arrived with a specific question. When runs are parallel, isolate each in its own
worktree or branch so their writes stay disjoint. This guide carries its load-bearing rules in full
so it stands alone. These are conventions the review packet inspects — nothing enforces them at edit
time.

This guide is for docs humans read. Agent-facing material (guides, templates, workflow docs) is a
different audience with different conventions, and code-changing work belongs to the other guides
in this catalog.

**Before editing, open [`references/task-template.md`](./references/task-template.md)** and instantiate
it as run notes. Record its path separately from any input task packet and fill it as you go. These
notes are private execution state, not a Suspec task packet.

Place the file under `~/.agents/artifacts/<workspace>/`, resolving `~` to the absolute
home path and deriving `<workspace>` from the repository or working-directory basename. Keep it
out of the repository and carry its absolute path forward. If the workspace name or target path
conflicts with unrelated work, stop for a structured human choice; never overwrite. If the root is
unwritable, offer grant access and retry, another agent-neutral user directory, or cancel. Never
fall back to vendor storage, the repository, or a temporary directory.

**Before handoff, close the evidence loop.** These notes are scratch state, not the review index.
When a task or spec governs the work, copy final changed files, fresh Verify evidence, scope drift,
blocked questions, and findings into the task's `## Run summary` / `## Findings` or the spec's
`## Execution`. If neither exists, return the same material in the direct handoff. A reviewer must
not need this private file to find the final evidence.

## Rules

1. **Fix the frame, the audience, and the question before writing a word.** Exactly one frame:
   **tutorial** (linear, hand-holding, no choices), **how-to** (a recipe for one task), **reference**
   (exhaustive lookup, no narrative), or **explanation** (the why). Name the audience concretely —
   "developers" is not specific; "developers integrating our SDK for the first time" is — and the
   one question the doc answers, stated as the reader would ask it. Discovering mid-doc that you are
   switching frames means it is two docs: split it.
2. **Lead with what the reader needs.** Put the answer, action, or lookup entry before history or
   context that does not help the reader use it. No fixed word count decides this; the opening earns
   its place when it helps the reader answer the stated question.
3. **Run every example; capture the output before writing it down.** Execute each example exactly
   as the reader would — no implied setup, no missing imports. An example you did not run is a
   hypothesis, not an example, and it is a common way documentation lies. Paste the captured
   run as your evidence.
4. **Verify every behavior claim against an authoritative current source.** Use code, tests,
   generated reference, official contracts, or observed output as appropriate. Record the evidence
   in run notes. Put `file:line` citations in the published doc only when that doc's audience and
   local convention benefit from source links; internal implementation coordinates are not a
   universal public-document requirement.
5. **No hedging the reader cannot act on.** "Should", "might", "could" leave the reader unable to
   decide. Either the system does X or it does not; if behavior is conditional, state the
   condition.
6. **Describe requirements as they are.** If the code contradicts what the spec says the doc must
   describe, surface the discrepancy as a blocked question — do not paper over it in prose.
7. **Reconcile the docs this change touches — within the task's scope.** Grep for other docs
   describing the same area; a doc you may edit that now contradicts yours gets reconciled in this
   change, and a contradiction in a doc outside your scope is a finding candidate. A stale doc
   contradicting a fresh one is worse than no doc: the reader cannot tell which is current.
8. **Run the project's format and doc-lint commands on every touched file and paste the output.**
   Resolve commands from `AGENTS.md`; ask when one is undefined. And never write a review result on
   your own work.

## Refuses

| Temptation                                       | Do instead                                                |
| ------------------------------------------------ | --------------------------------------------------------- |
| An example pasted in without running it          | Run it as written; paste the captured output              |
| "The system does X" with no checked source       | Verify it and record the evidence, or drop the claim      |
| "Should" / "might" / "could"                     | State the behavior, or the condition under which it holds |
| Mixed frames in one doc                          | Pick one; split the doc if it drifts                      |
| Choices in a tutorial ("you could also try…")    | A tutorial is linear; alternatives go in a how-to         |
| Narrative in a reference ("first, we see that…") | A reference is lookup                                     |
| "While I'm here" polish of neighboring docs      | Finding candidate; document only what the task names      |
| A doc-vs-code discrepancy smoothed over in prose | Blocked question; the spec changes through its own review |

## Gotchas

- **Mixing Diátaxis frames in one doc.** A how-to drifts into explaining the why, or a
  reference grows a hand-holding walkthrough. The reader who came to *do* one task now wades
  through theory, and the reader who came to *understand* hits a recipe — the doc serves
  neither because it answers two questions at once. The drift is the signal it is two docs.
- **Shipping an example that was never run.** You paste a snippet that looks right —
  plausible imports, the obvious call — without executing it. The reader runs it first and
  hits the missing setup or the renamed argument you would have caught. An unrun example is
  a hypothesis, and it is a common way a doc lies.
- **Hedging with should/might/could.** Unsure whether the behavior is guaranteed, you write
  "this should retry" to stay safe. The reader cannot act on it — does it retry or not? —
  and the hedge hid the one thing they needed: either state the behavior, or state the
  condition under which it holds.
- **Documenting beyond the task's requirements.** A neighboring section looks thin and you
  polish it "while I'm here." That unrequested edit widens the diff past what the task
  named, drags in claims you did not verify against the code, and is an exception trigger at
  review — the extra doc is a finding candidate, not in-scope work.

## Self-review gate

Before declaring the task done:

- [ ] One frame held throughout; audience and reader's question are written down.
- [ ] The opening answers the reader's question before unrelated history or setup.
- [ ] Every example ran as written — self-contained, output captured and pasted.
- [ ] Every behavior claim was checked against a current authoritative source; public citations
      follow the document's audience and project convention.
- [ ] No hedge the reader cannot act on; conditional behavior states its condition.
- [ ] Docs in scope that contradicted this one are reconciled; contradictions out of scope are
      finding candidates. No `TODO`/`FIXME` left behind.
- [ ] Format / doc-lint output is pasted; you issued no review result on your own work.

## Bundled resources

- [`references/task-template.md`](./references/task-template.md) — private run notes for frame,
  audience, examples to verify, evidence, and self-review.
