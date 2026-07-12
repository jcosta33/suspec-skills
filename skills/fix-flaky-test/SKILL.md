---
name: fix-flaky-test
type: agent-guide
description: >-
  Stabilize a flaky, non-deterministic test: reproduce it by looping, name the
  category of nondeterminism, fix the cause — never the assertion — and prove
  the fix with a predefined post-fix protocol under the same conditions.
  ALWAYS apply when a test
  passes sometimes and fails sometimes, CI shows occasional failures of one
  test, a test is skipped or quarantined for flakiness, or "passes locally,
  fails in CI". Never fix by re-run-to-green, a sleep, a timeout bump,
  try/catch, a widened assertion, or quarantine. Skip deterministic failures
  (an ordinary fix) and authoring new tests.
---

# Fix a flaky test

Stop the most tempting non-fix in software: re-running a test until it goes green, calling it
fixed, and shipping the bug. A flaky test fails non-deterministically — green sometimes, red
sometimes, usually worse under CI load than locally. The flake is a **real signal** about the
system: ordering, timing, shared state, or a leaking resource. The only acceptable resolution is to
reproduce it, name the nondeterminism, fix the cause, and prove the fix by looping the _same_ test
under the conditions in which it failed. This guide is the flake-stabilization discipline; it works
in any repo and any test runner. Treat its rules as a discipline you hold yourself to — nothing
enforces them at edit time.

A test that fails deterministically after a change is an ordinary defect — load `write-fix`.
Authoring new tests is `write-testing`. This guide stabilizes a test that already exists and
already named itself flaky.

**Before you start, open [`references/notes.md`](./references/notes.md)** and copy it into a working
notes file for this run — it is the session frame for this work; fill it in as you go (don't
reconstruct the structure from memory). It scaffolds the flake category, the reproduction protocol
and evidence, the hypothesis tracker, the fix evidence, and the self-review.

**Before handoff, close the evidence loop.** These notes are scratch state, not the review index.
When a task or spec governs the work, copy final changed files, fresh Verify evidence, scope drift,
blocked questions, and findings into the task's `## Run summary` / `## Findings` or the spec's
`## Execution`. If neither exists, return the same material in the direct handoff. A reviewer must
not need this private file to find the final evidence.

## Rules

1. **Reproduce before you claim to understand.** Define the repetition count, seeds, concurrency,
   load, environment, and stop condition before running the loop. Base them on the observed CI
   frequency and the cost of a miss, not a universal repetition count. If it will not reproduce,
   broaden the conditions (CI-like load, sibling tests
   alongside, pinned or varied seed, advanced clock) rather than concluding it was never real: a
   flake that will not fire is _un-isolated_, not _unreal_. Paste the loop output showing both
   passes and failures — that is the reproduction evidence. Ask how the project loops a single test
   (a repeat flag, a single-test runner) if it is not in `AGENTS.md` — never guess the loop
   mechanism.
2. **Name the category or interacting categories of nondeterminism** — this narrows the fix:
   timing/ordering · shared state ·
   network/external service · randomness · time/clock · resource exhaustion · environment. Separate
   independent causes; keep interacting causes together only when the evidence shows one mechanism.
3. **Find the cause in production code or test setup — never in the assertion.** The assertion is
   the messenger. The cause lives in nondeterministic production code (unseeded random, unmocked
   time, a race), un-isolated setup/teardown, the parallel-runner harness, or the environment.
   Trace from the reproduced failure to the line that introduces the nondeterminism.
4. **Fix the cause; never mask it.** Inject the clock or seed instead of reading the real one;
   isolate the shared state (fresh fixture, scoped teardown); wait on the actual contract (a
   settled state, an emitted event) instead of a sleep; reserve and release the contended resource
   correctly.
5. **Test the fix with the predefined post-fix protocol.** Use conditions no easier than the
   reproducing run and paste the output. Report the observed result and protocol exactly: "no failures
   observed in this run" is evidence; "the failure probability is zero" is not. Compare pre- and
   post-fix observations when the baseline produced enough failures to make that comparison useful.
6. **Document a non-obvious invariant at the cause site.** Add a short comment only when the code
   would otherwise invite reintroduction; do not narrate an obvious fix.
7. **Keep the root-cause boundary honest.** Fix production code when that cause is within the task's
   approved scope. If the evidence exposes a production defect outside scope, stop, preserve the
   reproduction, and report the required follow-up; do not claim the flake stabilized while its cause
   remains live. Do not sign off on your own fix as independent review.

## Refuses

| Temptation                                           | Do instead                                                                                  |
| ---------------------------------------------------- | ------------------------------------------------------------------------------------------- |
| "It passed when I re-ran it, so it's fixed"          | Run the predefined protocol and report exactly what it observed                            |
| "I added a small sleep and it stopped failing"       | The race is still there; wait on the contract or fix the cause                              |
| "I can't reproduce it, so there's nothing to fix"    | Un-isolated, not unreal — broaden load, siblings, seed, clock                               |
| "I loosened the assertion so it tolerates the drift" | A check too weak to fire guards nothing; fix what makes the value drift                     |
| "I wrapped the flaky call in try/catch"              | Swallowing the signal is widening the assertion by another route                            |
| "I marked it skipped to keep CI green"               | Containment with an owner and a date, never the fix — the cause is live                     |
| "It only flakes in CI and I can't run CI locally"    | Reproduce the CI conditions (load, parallelism, seed) or report Blocked — not a silent pass |
| "The fix is obvious from the diff"                   | A diff does not loop the test; paste the loop output                                        |

## Self-review gate

Before declaring the task done:

- [ ] The reproduction loop output is pasted — failures visible, failure rate measured, under
      conditions no easier than where it originally failed.
- [ ] The evidenced category or interacting categories of nondeterminism are named; independent
      causes are split.
- [ ] The fix is at the cause in production code or test setup — not the assertion, not a sleep,
      not a timeout bump, not try/catch, not quarantine.
- [ ] The post-fix protocol and output are pasted — the same test under conditions no easier than
      reproduction, with the observed failure count stated without claiming zero future risk.
- [ ] A non-obvious invariant is documented where needed; any out-of-scope production cause remains
      an explicit blocker, not a hidden follow-up.
- [ ] You did not sign off on your own fix as if a second reviewer had.

## Gotchas

- **Hiding the nondeterminism instead of removing it.** Re-running to green, adding a sleep, bumping
  a timeout, wrapping the call in try/catch, widening the assertion, or quarantining all make the
  red go away while leaving the cause live — they suppress the signal, they don't fix it.
- **Turning a clean sample into certainty.** A finite all-pass loop bounds what was observed; it never
  proves the future failure probability is zero. Preserve the protocol and residual risk.
- **Mis-categorizing the nondeterminism.** Name the wrong category (call a shared-state leak a
  timing flake) and the fix lands on the wrong line — the test goes quiet for a while, then flakes
  again because the real cause was never touched.

## Bundled resources

- [`references/notes.md`](./references/notes.md) — a working-notes scaffold for the run (flake category, reproduction
  protocol and evidence, hypothesis tracker where each rejected attempt teaches the next, fix
  evidence, self-review).
