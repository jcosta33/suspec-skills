---
name: write-rewrite
type: agent-guide
description: >-
  Implement a rewrite task: re-implement code whose behavior changes on
  purpose, proving the recorded delta with its checks and the preserved
  non-delta with an equivalence check. ALWAYS apply when asked to rewrite a
  module, replace an implementation, or redo something wrong — behavior
  deliberately changing. Never start before the delta is recorded, ship an
  unrecorded difference, or treat "rewrite" as license to redesign. Skip
  behavior-preserving refactors, API/version migrations, performance tuning,
  and net-new features.
---

# Implement a rewrite

`DISRESPEC-SPINE: One fact once. No filler, repeated source material, empty sections, or chat restatement; after successful creation return only clickable artifact links, except for blockers, failed creation, incomplete verification, or irreversible-action confirmation.`

A rewrite is riskier than a refactor because behavior is _permitted_ to change — so an unintended
change hides exactly where an intended one is allowed. The discipline forces the change onto two
provable surfaces: the **delta** (every behavior meant to change) and the **preserved non-delta**
(everything else). The delta is the contract; anything not on it must survive untouched. This guide
carries the rewrite discipline standalone. When runs are parallel, isolate each in its own worktree
or branch so their writes stay disjoint. These are conventions the review packet inspects — nothing
enforces them at edit time.

Plan the transformation first — the change plan covers baseline, waves, and rollback;
this guide is the execution half. If your task moves _no_ observable behavior, it is a refactor; if
only the implementation API moves while behavior holds, it is a migration; if it adds capability
that did not exist, it is a feature. Relabel rather than proceed under the wrong discipline.

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

1. **The behavior delta is recorded before any code is written.** The task's sources (the spec and
   change plan) name every aspect that changes — input handling, output shape, errors, side
   effects, ordering, defaults. If the delta is not recorded, stop and get it recorded first:
   writing it after the fact lets the implementation define the contract instead of the reverse.
2. **ACs cover the new behavior _and_ the preserved behavior.** A rewrite that only tests its delta
   proves the intended change was built — and proves nothing about the regression risk it created.
   The preserved surface is exactly where an unintended change hides.
3. **Prove the two surfaces with two different checks.**
   - **The delta**: each changed behavior verified by its named check. A new test must fail against
     the pre-rewrite behavior or a controlled violation of the targeted delta, then pass against the
     intended result; paste both transitions.
   - **The non-delta**: an equivalence check that would fail if anything outside the delta changed
     — property-based, differential (keep the old path reachable behind a shim and diff the two on
     the preserved surface), or golden-output pinned before the change. A green suite that never
     asserted the preserved behavior is necessary but not sufficient; if the suite is the only
     oracle, record why it suffices for this change.
4. **Account for every caller of every changed behavior.** Grep the rewritten symbols across the
   _whole_ codebase — and their string forms (dynamic dispatch, registries, reflection, generated
   code, config), which a call-syntax search cannot reach. For each caller: update it for the new
   behavior, or verify it still works under the preserved one. Paste the search output. A missed
   caller ships as a regression.
5. **Halt on an emergent behavior change.** If you discover a change _not_ in the recorded delta,
   stop: either the delta is amended upstream to authorize it, or you revise the implementation to
   preserve the original behavior. A silent emergent change is the rewrite's signature failure —
   it ships a behavior nobody decided to ship.
6. **"Rewrite" is not a license to redesign the surrounding module.** Anything off the delta is a
   finding candidate, not an inline improvement; the reviewer must be able to tell the intended
   change from a smuggled one. (Do not, however, revert correct in-scope work merely because it
   grew — note the reasoning in your summary.)
7. **Run the checks after every batch, paste as you go**; resolve commands from `AGENTS.md`; ask
   when one is undefined. And never write a review result on your own work.

## Refuses

| Temptation                                                     | Do instead                                                          |
| -------------------------------------------------------------- | ------------------------------------------------------------------- |
| Coding before the delta is recorded                            | Stop; the contract comes first — get it recorded upstream           |
| A behavior change that never made the delta                    | Halt: amend upstream or preserve the original behavior              |
| "Redesign while we're here"                                    | Finding candidate; the delta bounds the scope                       |
| Testing only the delta                                         | Add preservation checks; the regression risk lives in the non-delta |
| "Callers are fine" with no pasted search                       | Grep the whole codebase, string forms included; paste it            |
| Calling it a refactor though behavior changes (or the reverse) | Relabel and load the matching guide                                 |
| A delta aspect left undecided ("probably preserved")           | Stop; have the source record whether it changes or is preserved     |

## Self-review gate

Before declaring the task done:

- [ ] Every behavior change in the diff appears in the recorded delta — nothing snuck in.
- [ ] Every delta AC carries pasted evidence (flip transition for new tests).
- [ ] The non-delta equivalence check (or the recorded sufficient-oracle justification) is pasted
      and would fail on drift.
- [ ] The caller search — whole codebase, string forms included — is pasted, every caller
      accounted for.
- [ ] Checks ran after your final edit; output pasted.
- [ ] Nothing is left stubbed or half-rewritten; off-delta discoveries are finding candidates.
- [ ] You issued no review result on your own work.

## Gotchas

- **Shipped an unrecorded behavior difference.** The diff carries a change — a tweaked default, a
  reordered output, a swallowed error — that never appeared in the recorded delta. It passes review
  by looking deliberate; it ships a behavior nobody decided to ship. Every behavior change in the
  diff must trace back to a delta entry, or it halts for amendment.
- **Treated "rewrite" as license to redesign.** The surrounding module got "cleaned up" along the
  way, so the reviewer can no longer separate the intended change from the smuggled one and the
  delta no longer bounds the scope. Off-delta improvements are finding candidates, not inline work.
- **Started before recording the delta.** Coding first lets the implementation define the contract
  in reverse — whatever you built becomes "the intended behavior," and the preserved surface is
  never identified, so the equivalence check has nothing to protect.

## Bundled resources

- [`references/task-template.md`](./references/task-template.md) — private run notes for the delta,
  preservation criteria, caller inventory, evidence, and self-review.
