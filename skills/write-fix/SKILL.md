---
name: write-fix
type: agent-guide
description: >-
  Implement a fix task: reproduce the defect, patch the root cause, bind a
  regression test that fails before the patch and passes after, run the full
  suite, paste the evidence. ALWAYS apply when asked to fix, patch, resolve, or
  close a bug, regression, or defect. Never patch the symptom, ship without the
  red-before/green-after transition, or bundle neighboring fixes. Skip writing
  the bug report (diagnosis-only work), behavior-preserving refactors, rewrites —
  and a flaky, non-deterministic failure, which is stabilization work, not a fix.
---

# Implement a fix

`DISRESPEC-SPINE: One fact once. No filler, repeated source material, empty sections, or chat restatement; after successful creation return only clickable artifact links, except for blockers, failed creation, incomplete verification, or irreversible-action confirmation.`

Fixes fail two ways, both producing a green-looking diff that ships the bug. **Patching the
symptom**: suppressing the visible failure while the cause survives, so the defect recurs through a
different path. **A regression test that does not exercise the bug**: one green before the patch
proves nothing, because it stays green if the fix is deleted. This guide carries the fix discipline
standalone. When runs are parallel, isolate each in its own worktree or branch so their writes stay
disjoint. These are conventions the review packet inspects — nothing enforces them at edit time.

Writing the bug _report_ is a separate job with its own guide, `write-bug-report`, in this catalog —
this guide consumes a report and produces the fix. A test that fails _sometimes_ is a different
oracle entirely — a flake needs a loop run to reproduce, and you fix the source of nondeterminism
(shared state, timing, ordering), never the assertion. That is stabilization work, not this fix.

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

1. **Reproduce the bug in your worktree before you patch.** Re-run the report's reproduction and
   paste the failing output. If you cannot reproduce, do not patch — the discrepancy between your
   environment and the report's is itself a finding (versions, seeds, fixtures, clock, OS), not a
   dismissal. The reproduction is the falsification target for the whole task; without it, "fixed"
   is a claim with no possible counter-evidence.
2. **Bind the reproduction to a regression test before changing production code.** If the existing
   reproduction is already an executable test, preserve its failing output. Otherwise add the
   smallest public-surface test on the unfixed code and run it: it must fail for the intended defect,
   not setup or an adjacent condition. Paste that red result before the production patch exists.
3. **Patch the root cause, not the symptom.** Before patching, restate in your own words why this
   location is the cause and not merely where the failure became visible; if you cannot, you have
   not root-caused it (see _Hunting the cause_ below). Swallowing the error, clamping the value, or
   special-casing the one triggering input leaves the cause live under a different trigger.
4. **Run the same regression test after the fix.** It must now pass under the same conditions. Paste
   the green result. Assert on the behavior the bug broke — the output, returned value, or emitted
   event — not internal state.
5. **Run the full suite, not just the regression test**, and paste the output. A patch that passes
   its own test but breaks a neighbor trades a known bug for an unknown one.
6. **Keep the fix minimal; no bundling.** Bugs have neighbors, and a fix task is the most tempting
   place to "just also fix" the related defect or rename the confusing variable. Don't. Every
   related discovery is a finding candidate in your summary, not a second fix in the diff — a
   one-cause fix is reviewable; a bundle is not.
7. **Record why the patch addresses the cause** in your summary, in one or two sentences. The
   reviewer checks exactly this. "The patch worked" is a verification output, not a reason.
8. **Paste everything; resolve commands from `AGENTS.md`; ask when a command is undefined.** A
   guessed test command produces a false signal about whether the bug is gone. And never write a
   review result on your own work.

## Hunting the cause

Root-causing demands hostility to the first plausible explanation:

- **The first suspicious line is rarely the origin.** Trace from the observable failure back to
  the state-plus-input that produces it; a correlated symptom upstream of the cause is the classic
  false catch.
- **Anchor the cause at file:line, with the state and input that trigger it.** "Somewhere in the
  cache layer" is a symptom location. A cause you cannot anchor, you cannot prove patched.
- **State Expected vs Actual, and Expected by whose authority.** Expected comes from the spec's
  requirement, not your opinion of good behavior. If no requirement covers the broken behavior,
  say so — that coverage gap is itself a finding.
- **"Can't reproduce" is a lead, not an exit.** Vary what the report could not: load, parallel
  siblings, seed, clock, data state. Surface a blocked question if it still will not fire.

## Refuses

| Temptation                                                       | Do instead                                                       |
| ---------------------------------------------------------------- | ---------------------------------------------------------------- |
| Patching where the failure is visible instead of where it starts | Trace to the cause; restate why that location is the origin      |
| A regression test that was never seen red                        | Patch the fix out; paste the failing run, then the passing one   |
| "I can't reproduce it, must be environment-specific"             | The discrepancy is the finding; investigate or surface a blocker |
| "While I'm here, this related bug…"                              | Finding candidate in the summary; one cause per fix              |
| A test asserting internal state                                  | Assert the behavior the bug broke                                |
| "Tests passed" with no command, exit, or output                  | Paste the real, re-runnable output                               |
| Re-running a sometimes-failing test until green                  | Wrong job — a flake is stabilization: loop to reproduce, fix the nondeterminism, not the assertion |

## Self-review gate

Before declaring the task done:

- [ ] The pre-patch reproduction output is pasted — the bug fired in _your_ worktree.
- [ ] The regression test's red result was captured on unfixed code before the production patch;
      the same test's post-fix green result is pasted.
- [ ] The full suite ran after your final edit, output pasted.
- [ ] The summary states why the patch addresses the cause, not the symptom.
- [ ] The diff is the minimal fix; related defects are finding candidates, not edits.
- [ ] You issued no review result on your own work.

## Gotchas

The same failure modes as the rules, shown as the run-time scenario that produces each:

- **You patched the symptom, not the root cause** — swallowed the error, clamped the value, or
  special-cased the one triggering input — so the suite goes green and the cause stays live,
  resurfacing through a different trigger after the task is closed. The first suspicious line is
  usually downstream of the origin; if you cannot restate why this location *is* the cause, you
  have not found it yet.
- **You wrote the regression test only after the production fix** — it started life green and may
  never have exercised the defect. Capture the red result on unfixed code before editing production;
  then run the same test green after the patch.
- **You bundled a neighboring fix** — the confusing variable, the related defect two lines over —
  into the same diff, because a fix task is the most tempting place to "just also fix" the thing
  right next to the bug. Now the reviewer cannot tell which edit closed the reported defect. Each
  neighbor is a finding candidate, not a second fix.

## Bundled resources

- [`references/task-template.md`](./references/task-template.md) — private run notes for the
  reproduction, hypothesis trail, root cause, progress, evidence, and self-review.
