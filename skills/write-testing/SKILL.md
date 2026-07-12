---
name: write-testing
type: agent-guide
description: >-
  Implement a testing task — tests are the deliverable: behavior through the
  public surface, one reason to fail per test, each proven to fail for that
  reason. ALWAYS apply when asked to add tests, close a coverage gap,
  write a regression test, or harden a suite. Never assert internals, bundle
  unrelated behaviors, chase a coverage percentage, ship an unfalsified test, or
  edit production code to ease a test. Skip tests that ride inside feature/fix
  work, and stabilizing an existing intermittently failing test.
---

# Implement tests

`DISRESPEC-SPINE: One fact once. No filler, repeated source material, empty sections, or chat restatement; after successful creation return only clickable artifact links, except for blockers, failed creation, incomplete verification, or irreversible-action confirmation.`

Tests fail their job in three quiet ways: the test that passes even when the code under test is
commented out (pure ceremony), the test that reaches into internals and shatters on a
behavior-preserving refactor (the test broke, not the code), and the test that bundles six
unrelated assertions so a failure says "something broke" without saying what. All three are
net-negative — they cost maintenance and catch nothing. This guide carries the testing discipline
standalone. When runs are parallel, isolate each in its own worktree or branch so their writes stay
disjoint. These are conventions the review packet inspects — nothing enforces them at edit time.

This guide is for tests as the deliverable in their own right. Tests written _as part of_ a feature
or fix ride inside those guides; a test that already fails non-deterministically is stabilization
work — loop it to reproduce, fix the source of nondeterminism (shared state, timing, ordering) not
the assertion, and prove it with the same loop run green repeatedly — not this guide.

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

1. **Name the coverage gap as a behavior before writing any test** — which module, behavior, and
   conditions a caller depends on, not which lines. "This file is 40% covered" breeds shallow tests
   that chase the percentage; "the retry path does not back off on the third failure" breeds a test
   that catches a real bug.
2. **Exercise the public surface.** Assert on what a caller observes — never on private methods or
   module-private state. An internals test breaks on a behavior-preserving refactor: a false
   failure, not a caught defect.
3. **One reason to fail per test.** Split anything bundled; a multi-assertion case says "something
   broke" without saying which behavior. Give each test a name (and assertion message, where the
   runner supports it) that tells the person who broke it what behavior broke.
4. **Prove every new test fails for its intended reason.** Prefer the natural pre-change state, a
   known-bad fixture, or a controlled mutation of the targeted behavior. Capture the expected
   failure, then restore the correct state and capture the pass. Do not mechanically invert every
   assertion: that can fail trivially without proving the test reaches the behavior under test.
5. **When a test is the verification for a named AC, prove it fires for that AC's reason.** A green
   flip shows the test fires — not that it fires when _that requirement_ is violated rather than
   some adjacent condition. If no fail-when-violated test can be built, that goes back to the spec
   author as a blocked question (rebind the AC to a command or manual check) — never ship a
   green-but-irrelevant test.
6. **Strengthen the check where the stakes are high.** For a high-risk requirement or an invariant
   (a universal claim one example cannot establish), a single concrete test is a weak check — reach
   for property-based, metamorphic, or mutation-backed coverage and record what it exercised.
7. **Keep every test deterministic.** No ordering dependencies, timing assumptions, shared mutable
   state, unsandboxed network, or unseeded randomness. A flaky test trains developers to ignore
   failures — it disarms the whole suite.
8. **Never edit production code to make a test easier to write** unless the task's scope says so.
   That inverts the dependency — the test exists because of the code's behavior, never the reverse.
   Hard-to-test code is a finding candidate; a bug a test exposes is the highest-value finding this
   work produces — record it, don't fix it inline.
9. **Read coverage as a map, not a score**, place tests per the project's existing conventions
   (a test in the wrong place never runs — a green tick that guards nothing), run the whole suite,
   and paste real output. Resolve commands from `AGENTS.md`; ask when one — including a single-test
   or coverage runner — is undefined. And never write a review result on your own work.

## Refuses

| Temptation                                            | Do instead                                                            |
| ----------------------------------------------------- | --------------------------------------------------------------------- |
| "It's green, it's fine" — no intended failure shown  | Trigger the targeted violation; paste the fail-then-pass transition |
| An assertion on a private method or internal state    | Re-aim at what a caller observes                                      |
| Several unrelated behaviors in one case               | Split — one test, one reason to fail                                  |
| "Get this file to 85% coverage"                       | Coverage maps untested behavior; it is never the target               |
| An AC-bound test that passes for an adjacent reason   | Confirm it fails when _that_ requirement is violated                  |
| One concrete example as the check for an invariant    | Strengthen to property/metamorphic/mutation; record what it exercised |
| Editing production code "to make the test easier"     | Finding candidate; leave the code alone                               |
| A bug the test exposed, fixed inline                  | Record it as a finding; the fix is its own task guarded by this test  |
| "It usually passes"                                   | Make it deterministic, or surface stabilization as its own task       |

## Gotchas

- **Asserting on internals instead of the public surface.** The private method is right
  there and easy to reach, so the test pokes at it directly. The next behavior-preserving
  refactor renames or inlines it and the test goes red — a false failure that says the
  refactor broke something when nothing a caller observes changed.
- **Chasing a coverage percentage instead of a behavior.** The task says "get this file to
  85%", so you write tests that execute the uncovered lines without asserting anything a
  caller depends on. Coverage goes green and the untested behavior is still untested — the
  number measured the test's reach, not its grip.
- **Shipping a test without proving its intended failure.** It passes on the first run, so you call
  it done. A test that has never failed for the targeted violation might be tautological, fail only
  on setup, or never execute the relevant path.
- **Editing production code to make a test easier to write.** A seam is awkward, so you
  loosen a visibility modifier or add a test-only hook to the shipping code. That inverts
  the dependency — the test now exists because of a change made for the test — and the
  hard-to-test design that should have been a finding is quietly papered over.

## Self-review gate

Before declaring the task done:

- [ ] Every new test failed for its intended violation and passed in the restored correct state;
      representative transitions are pasted.
- [ ] The whole suite ran after your final edit; output pasted.
- [ ] Each test exercises the public surface and has exactly one reason to fail.
- [ ] Each AC-bound test fails when its requirement is violated, not an adjacent condition;
      high-stakes requirements carry a strengthened check with a note of what it exercised.
- [ ] No production code changed outside the task's scope; bugs exposed and hard-to-test designs
      are recorded as finding candidates.
- [ ] No ordering, timing, shared-state, network, or randomness dependency that could flake in CI.
- [ ] You issued no review result on your own work.

## Bundled resources

- [`references/task-template.md`](./references/task-template.md) — private run notes for the
  coverage gap, behavior cases, placement, falsification evidence, and self-review.
