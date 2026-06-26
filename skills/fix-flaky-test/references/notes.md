# Flaky-test working notes: {{title}}

- Test file: `{{path}}:{{test name}}`
- Failing-run evidence that named it flaky (logs / CI links): `{{paths or URLs}}`
- Worktree / branch: {{branch}}
- Created: {{YYYY-MM-DD}} · Status: active

> **Flaky-test work** — reproduce before fixing. Name the category. Fix the cause, never the
> assertion. Reject sleep-as-fix and quarantine-as-fix. Prove the fix with a loop run, not one
> green tick.
>
> **Commands:** the loop invocation (a repeat flag, a parallel matrix, a seed-pinned mode) is
> project-specific — find how this project loops a single test before reproducing; a guessed loop
> is a false signal about reproduction.

## Test under stabilization

- **Test:** `{{path}}:{{name}}` · **Observed failure rate:** {{~% of runs}}
- **First observed:** {{sha or date}} · **Currently quarantined?** yes / no

## Flake category

Pick exactly one. A mixed-category flake splits into separate fixes — each category root-causes
differently.

- [ ] Timing / ordering — a timeout, an unbounded poll, an operation-order assumption, an
      order-dependent shared fixture
- [ ] Shared state — module-level state, singleton caches, fixtures or rows mutated by siblings
- [ ] Network / external service — real HTTP, real DNS, an unmocked dependency, a flaky container
- [ ] Randomness — unmocked random, unseeded UUIDs or shuffles
- [ ] Time — unmocked clock, time-of-day assertions, DST boundaries
- [ ] Resource exhaustion — ports, file handles, connections, memory under parallel runs
- [ ] Environment — locale, timezone, hostname, env vars, terminal width

## Reproduction protocol

The exact command looped to fire the flake — from the project's loop mechanism, not guessed.

```bash
{{loop command — e.g. test runner --repeat=500 --testNamePattern="<name>"}}
```

## Reproduction evidence (paste verbatim)

The loop output that fires the flake — both passes and failures visible, plus the tally.

```text
{{paste}}
```

- Loop runs: {{n}} · Failures observed: {{n}} · Failure rate: {{%}} · Failure modes seen:
  {{assertion / error / hang}}

## Hypothesis tracker

Each suspected cause is a row. A rejected hypothesis records what it teaches the next one.

| # | Hypothesis | How to check | State (open / confirmed / rejected) | What rejection teaches |
|---|---|---|---|---|
| 1 | | | open | |

## Root cause

- **Symptom:** {{what fails, where}} — `{{file}}:{{line}}`
- **Cause:** {{the mechanism introducing the nondeterminism}} — `{{file}}:{{line}}`

The cause is never the assertion; symptom and cause must not be the same statement.

## Progress checklist

- [ ] Flake reproduced; failure rate measured; evidence pasted
- [ ] Exactly one category named; mixed flakes split
- [ ] Cause found at file:line in production code or test setup — not the assertion
- [ ] Fix at the cause — no sleep, timeout bump, try/catch swallow, widened assertion, or
      quarantine
- [ ] One-line note added at the cause site naming the failure mode
- [ ] Fix loop run executed — same shape that reproduced the flake, every run passing, pasted
- [ ] A production-side cause is recorded with this test as its regression guard
- [ ] Self-review answered

## Fix (the change you made)

Where the cause lives and what you changed to remove the nondeterminism — injected clock vs seeded
RNG, isolated fixture, waited on a real contract, etc.

-

## Fix evidence (paste verbatim)

The loop output after the fix — same conditions that reproduced it, every run passing.

```text
{{paste}}
```

- Loop runs after fix: {{n}} · Failures: 0 · From {{%}} to 0

## Notes for downstream

A production-code race or leak (its fix is separate work, guarded by this test), a sibling test
touching the same shared state — worth carrying forward.

-

## Blocked questions

A flake resisting 1000× reproduction goes here with the conditions already tried; CI-only
conditions you cannot recreate are reported as Blocked, never as a silent pass.

-

## Next steps

-

## Self-review gate

Answer in writing, evidence pasted.

- **Reproduced first:** over how many loops, at what failure rate, under conditions no easier than
  where it originally failed?
- **Category:** exactly one named; any mixed flake split?
- **Cause vs symptom:** is the fix at the cause — not the assertion, not a sleep, not a swallow,
  not quarantine? If a wait was used, on which documented contract?
- **Fix evidence:** the same loop shape passed with zero failures, output pasted?
- **Handoff:** cause documented inline; a production-side cause carried forward?
- **Honesty:** did you verify with a loop, or did one green tick end the session? You did not sign
  off on your own fix as if a second reviewer had.
