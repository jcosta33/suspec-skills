---
name: write-feature
type: agent-guide
description: >-
  Implement a feature task: build net-new behavior, mapping every requirement
  to a part of the change before coding, with pasted evidence per requirement.
  ALWAYS apply when asked to add capability that did not exist, or when
  acceptance criteria for new behavior are named. Do not code before surveying existing patterns, invent a requirement
  to resolve an ambiguity, or refactor in passing. Skip defect fixes,
  behavior-preserving refactors, deliberate rewrites, migrations, performance
  tuning, and test-only work.
---

# Implement a feature

`DISRESPEC-SPINE: One fact once. No filler, repeated source material, empty sections, or chat restatement; after successful creation return only clickable artifact links, except for blockers, failed creation, incomplete verification, or irreversible-action confirmation.`

Features fail when the builder improvises around the spec — building past it, smuggling in "while
I'm here" cleanup, or declaring done on a green suite that never exercised the new behavior. This
guide carries the feature discipline standalone: build exactly what the requirements name, reuse
before you invent, and let nothing leave your hand unverified. When runs are parallel, isolate each
in its own worktree or branch so their writes stay disjoint. These are conventions the review packet
inspects — nothing enforces them at edit time.

A feature adds capability that did not exist. Repairing a defect, restructuring without a behavior
change, deliberately changing existing behavior, moving between APIs, and tuning a bottleneck are
different kinds with their own guides in this catalog.

**Before editing, open [`references/task-template.md`](./references/task-template.md)** and instantiate
it as run notes. Record its path separately from any input task packet and fill it as you go. These
notes are private execution state, not a Suspec task packet.

Place the file next to your own native artifacts — the same place you keep your plans,
notes, and memories for this work, in a folder named after the repo you are working on
(or wherever fits your harness best). You choose the exact spot; keep it out of the repo
unless the project's own governance says otherwise, and carry the file's full path
forward — every later step names artifacts by explicit path.

**Before handoff, close the evidence loop.** These notes are scratch state, not the review index.
When a task or spec governs the work, copy final changed files, fresh Verify evidence, scope drift,
blocked questions, and findings into the task's `## Run summary` / `## Findings` or the spec's
`## Execution`. If neither exists, return the same material in the direct handoff. A reviewer must
not need this private file to find the final evidence.

## Rules

1. **Read the controlling intent and its sources first.** When a task packet exists, it fixes the
   scoped ACs, do-not-change areas, and Verify checklist; otherwise use the direct request and any
   spec. Resolve project commands from the
   code repo's `AGENTS.md` Commands table; if a command you need is undefined, ask — never guess.
2. **Map every AC to a concrete part of the change before coding.** Each AC gets a named step in
   your plan. An AC you did not map before coding is one you discover unmet at self-review — or
   one the reviewer discovers for you.
3. **Survey existing patterns before inventing.** Before adding a helper, type, or pattern, search
   the codebase for an existing equivalent — memory is not a survey; it misses the helper added
   last week. If nothing fits, say why in your summary so the reviewer judges the choice instead of
   re-litigating it.
4. **Halt on ambiguity.** If an AC is unclear or contradictory, stop and surface it — do not invent
   the requirement. A guessed requirement commits a decision nobody made; a blocked question keeps
   it visible until someone answers.
5. **Do not refactor opportunistically.** Debt you spot while building is a finding candidate, not
   an inline fix. A feature diff that also restructures unrelated code is unreviewable — the
   reviewer cannot tell the intended change from the smuggled one.
6. **Run the checks after every batch, not only at the end**, and paste output as you go. Catching
   a violation at batch 3 is cheaper than at batch 12, and pasting as you go means the evidence
   exists before the claim that depends on it.
7. **Tests are part of the deliverable, and each must fire for the right reason.** Every AC has its
   named verification; when that is a new test, capture it failing against the pre-feature state or
   a controlled violation of the targeted behavior, then passing after implementation. Do not
   mechanically invert assertions: prove the behavior path, not merely that the assertion operator
   can fail.
8. **Paste real output for every Verify item, after your final edit.** Command, exit status,
   summary lines — fenced, unmodified. "Tests passed" with no output is unverified.
9. **Close with the summary and findings.** Changed files, commands with output, anything unmet as
   written, out-of-scope edits if any, and finding candidates in the run notes' `## Findings`
   section. No review result on your own work.

## Refuses

| Temptation                                                          | Do instead                                                          |
| ------------------------------------------------------------------- | ------------------------------------------------------------------- |
| "While I'm here…" — code beyond the listed ACs                      | Build only the assignment; note the rest as finding candidates      |
| An ambiguity resolved by guessing so the build can proceed          | Halt and surface the question; never invent intent                  |
| A new helper that duplicates an existing one                        | Reuse the existing one, or record why it does not fit               |
| An opportunistic refactor of a file the build merely passed through | Keep the diff to the task's areas; raise the cleanup separately     |
| An AC declared met with no evidence for its check                   | Run the bound check; paste the output — uncovered until then        |
| A green suite standing in for the new behavior                      | Trigger the targeted violation; paste the fail-then-pass transition |
| Quietly switching to fixing or refactoring mid-build                | Surface the concern; the feature scope holds for the whole task     |

## Self-review gate

Before declaring the task done:

- [ ] Every AC maps to a part of the diff you can point at — and no part of the diff exists
      without an AC (or a listed exception) behind it.
- [ ] Every Verify item ran after your final edit, output pasted.
- [ ] Every new test failed for its targeted violation and passed after implementation; a
      representative transition is pasted.
- [ ] Every ambiguity you met was surfaced, not resolved by a guess.
- [ ] New helpers or patterns carry a recorded reason an existing one did not fit.
- [ ] The summary names changed files, commands with output, and finding candidates; you issued no
      review result on your own work.

## Gotchas

Failure modes that show up at run time, not in the rules:

- **You coded the change before mapping each AC to a part of it**, so the diff grew around the
  feature and one AC turns out to have no code behind it — found at self-review if you are lucky,
  by the reviewer if not. The map is cheap before the first edit and expensive to reconstruct after.
- **You refactored neighboring code "in passing"** — renamed a confusing variable, tidied a helper
  the feature merely touched — and now the reviewer cannot separate the new behavior from the
  drive-by cleanup. The whole diff reads as suspect even where it is correct.
- **You hit an ambiguous AC and invented the requirement** to keep moving, committing a product
  decision nobody made and burying it in code where no one will see it until it ships wrong. A
  guess feels like progress and reads like a spec; surface it instead.

## Bundled resources

- [`references/task-template.md`](./references/task-template.md) — private run notes for plan,
  progress, decisions, evidence, and self-review.
