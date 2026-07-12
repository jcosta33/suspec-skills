---
name: write-change-plan
type: agent-guide
description: >-
  Write a change plan — how the codebase changes safely: an evidenced baseline and target,
  enumerated preservation guarantees, transformation waves that each leave
  the build green, cutover and rollback conditions, and a task split when needed. ALWAYS apply when planning
  refactors, rewrites, migrations, upgrades, performance, or schema work. Never write
  "no behavior change" — enumerate what is preserved. Skip for small cleanups, obvious
  bug fixes, and ordinary feature work.
---

# Writing a change plan

`DISRESPEC-SPINE: One fact once. No filler, repeated source material, empty sections, or chat restatement; after successful creation return only clickable artifact links, except for blockers, failed creation, incomplete verification, or irreversible-action confirmation.`

A spec answers "what should the system do?"; a change plan answers "how does the codebase
change _safely_?" Write one when the work is primarily structural — it spans modules, must
preserve behavior while touching risky code, needs sequencing, or will land as a diff too
large to interpret without a map. Skip it for an obvious bug fix or a small cleanup.

A change plan has these sections, in order: **Baseline · Target · Preservation
guarantees · Transformation waves · Cutover / rollback · Task split (when needed)**. The plan sits
beside the spec it serves. This skill is how the plan gets created. When the deterministic checker
is available, run `suspec check <path>`; otherwise apply its structural checks by hand.

Place the file under `~/.agents/artifacts/<workspace>/`, resolving `~` to the absolute
home path and deriving `<workspace>` from the repository or working-directory basename. Keep it
out of the repository and carry its absolute path forward. If the workspace name or target path
conflicts with unrelated work, stop for a structured human choice; never overwrite. If the root is
unwritable, offer grant access and retry, another agent-neutral user directory, or cancel. Never
fall back to vendor storage, the repository, or a temporary directory.

The frontmatter `kind` names the transformation: refactor · rewrite · migration ·
dependency-upgrade · performance · test-infra · mechanical-cleanup · architecture-cleanup ·
schema-change. The kind lives on the plan; the task packets keep one shape regardless.

## Baseline and target come from current evidence

The Baseline section cites the inventory when one was needed, or direct code, test, and command
evidence when the current map was already clear. It never derives current state from memory. The Target state says what the code looks
like after, _including what explicitly stays unchanged_. A reviewer who can't diff these two
sections in their head can't judge the waves between them. No inventory yet and the work is a
rewrite or wide refactor? Write the inventory first; a plan drawn over guessed terrain plans
the wrong moves.

## Enumerate what you preserve — never "no behavior change"

With enough users, every observable behavior gets depended on — sort order of an "unsorted"
endpoint, the exact text of an error message, timing someone's retry loop was calibrated
against. So the plan never gestures at "no behavior change"; it **enumerates** the behaviors it
preserves as guarantee rows: `ID | Behavior | Verify with` — the same one verification line a
requirement gets, and the review packet checks each row the same way (Supported needs pasted output).

Reuse the spec's own requirement IDs via the `preserves:` frontmatter. A guarantee with no spec
ID to point at gets a plan-local `PG-NNN` of its own. That records preservation without inventing
a requirement or forcing an unrelated spec amendment.

For the Verify with column, prefer a check that **would fail if the behavior changed**: a
golden-output capture taken before the change, a differential run of old vs new paths, or a
property test. A green suite is necessary but not sufficient — it covers only what was already
tested, so a behavior change in an untested corner passes silently. Where the suite is all you
have, write down in the plan _why_ it's sufficient for this change.

## Waves: each one leaves the build green

Break the transformation into waves **before** starting — a wave discovered mid-flight has no
checkpoint to catch drift. Each wave is the smallest change that leaves the codebase compiling
and passing tests, and each wave **names its verify step** (which commands run, what output
counts). A wave that can't say how it's verified isn't a wave yet — it's a hope. Validating
per wave catches a break while it's one wave old; validating only at the end is how a
half-finished migration becomes its own untangling project.

Where external consumers cannot move atomically, plan a **bridge release** with old and new surfaces
working together. When all consumers move in one controlled cutover, a bridge may add more risk than
it removes. Every compatibility shim a wave introduces is recorded with
its path, what it forwards to, and a checkable removed-when condition (e.g. "grep for the old
call returns zero"). A shim without a removal condition is permanent by default.

## Cutover, rollback, task split

- **Cutover conditions** — what must hold before the change counts as landed: guarantee rows
  verified, consumers moved, shims removed. Decided now, not mid-landing.
- **Rollback criteria** — the observable conditions that send it back, written while nobody is
  defending a half-landed change.
- **Task split** — when several workers or runs are needed, one row per task: which wave, which
  guarantee and requirement IDs. For one-worker work, record `None`; do not create task packets for
  ceremony. Review focus names risks specific to this transformation rather than a stock checklist.

Everything above is a convention — nothing in this repository enforces a change plan; the
review of each wave's tasks is where it pays off.

## Per-kind notes

- **Refactor.** The preservation table is the whole contract — behavior identical, structure
  moves. Plan per-wave validation at a real checkpoint frequency, and prefer an equivalence
  check (golden/differential/property) over trusting the suite alone.
- **Migration / dependency-upgrade.** Count the old-API callsites up front; plan the count to
  **zero** — across the whole codebase, not just the scoped modules. Include the references a
  text search can't reach: dynamic dispatch, string-based registry lookups, generated code,
  test fixtures, reflection. "Mostly gone" is the half-migration that never closes.
- **Rewrite.** Add a **delta table**: every behavior that changes (before → after) next to what
  is preserved. The table is the contract — anything not on it must be preserved, and a change
  discovered mid-rewrite that isn't on it means stop and amend the plan, not improvise. A
  rewrite that only tests its changes proves nothing about the regressions it just created.
- **Performance.** Baseline and target are **numbers under named conditions** ("p95 of
  `getQuote()` under 1k RPS: 240 ms → ≤ 80 ms"), measured with the **same protocol** before and
  after — warmup, sample count, aggregate, hardware, input shape. Different conditions "prove"
  speedups that don't exist. Set a hard ceiling: the regression on any other metric beyond
  which the change rolls back regardless of the primary gain.
- **Schema-change.** Use expand → migrate → contract when old and new application versions or data
  consumers must coexist. For an atomic, reversible cutover with no mixed-version window, record why
  a different sequence is safer. Schema shape does not decide the rollout by itself.

## Gotchas

- **Wrote "no behavior change" instead of enumerating what's preserved.** "No behavior change" is
  unverifiable — there's no row to paste output against, so the review packet can't check it and a
  drift in an untested corner ships silently. With enough users every observable behavior is
  depended on; enumerate each as a guarantee row (`ID | Behavior | Verify with`) the same way a
  requirement gets a verify line.
- **A guarantee row whose Verify with is just the suite.** A green suite covers only what was
  already tested, so a behavior change in an untested corner passes it. Prefer a check that *would
  fail if the behavior changed* — golden capture, differential run, property test; where the suite
  is all you have, write down in the plan why it's sufficient for this change.
- **A wave that leaves the build red.** A wave is the smallest change that still compiles and
  passes — if one leaves the tree broken, there's no checkpoint to catch drift and the next wave's
  failure can't be attributed. A wave that can't name its verify step isn't a wave yet, it's a hope.
- **Planned the migration to "mostly gone."** Old-API callsites counted only across the scoped
  modules miss dynamic dispatch, registry lookups, generated code, and fixtures — the half-migration
  that never closes. Plan the count to zero across the whole codebase, and leave no shim without a
  checkable removed-when condition.

## Before you finish

- [ ] Baseline cites current evidence and any inventory used; Target says what stays unchanged.
- [ ] Preservation guarantees enumerated — no "no behavior change" anywhere in the plan.
- [ ] Every guarantee row has a Verify with that would fail if the behavior changed.
- [ ] Every wave leaves the build green and names its verify step.
- [ ] Shims have removed-when conditions; coexistence strategy matches actual consumer cutover.
- [ ] Cutover conditions and rollback criteria written.
- [ ] When work is split, tasks cover every wave and map to guarantee/requirement IDs; otherwise
      Task split says `None`.
