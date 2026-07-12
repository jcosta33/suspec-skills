# Flaky-test working notes: {{title}}

- Run notes: {{absolute path to this file}}
- Task packet: {{full path when dispatched from one; otherwise None}}
- Spec: {{full path when one exists; otherwise None}}
- Test file: `{{path}}:{{test name}}`
- Failing-run evidence that named it flaky (logs / CI links): `{{paths or URLs}}`
- Worktree / branch: {{branch}}
- Created: {{YYYY-MM-DD}} · Status: active

Place the file under `~/.agents/artifacts/<workspace>/`, resolving `~` to the absolute
home path and deriving `<workspace>` from the repository or working-directory basename. Keep it
out of the repository and carry its absolute path forward. If the workspace name or target path
conflicts with unrelated work, stop for a structured human choice; never overwrite. If the root is
unwritable, offer grant access and retry, another agent-neutral user directory, or cancel. Never
fall back to vendor storage, the repository, or a temporary directory.

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

Mark every category supported by evidence. Split independent causes; keep interacting categories
together only when they form one demonstrated mechanism.

- [ ] Timing / ordering — a timeout, an unbounded poll, an operation-order assumption, an
      order-dependent shared fixture
- [ ] Shared state — module-level state, singleton caches, fixtures or rows mutated by siblings
- [ ] Network / external service — real HTTP, real DNS, an unmocked dependency, a flaky container
- [ ] Randomness — unmocked random, unseeded UUIDs or shuffles
- [ ] Time — unmocked clock, time-of-day assertions, DST boundaries
- [ ] Resource exhaustion — ports, file handles, connections, memory under parallel runs
- [ ] Environment — locale, timezone, hostname, env vars, terminal width

## Reproduction protocol

Record the exact command, repetition count, seeds, concurrency, load, environment, and stop
condition before running it. Resolve the loop mechanism from the project; do not guess.

```bash
{{loop command}}
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
- [ ] Evidenced category or interacting categories named; independent causes split
- [ ] Cause found at file:line in production code or test setup — not the assertion
- [ ] Fix at the cause — no sleep, timeout bump, try/catch swallow, widened assertion, or
      quarantine
- [ ] Non-obvious invariant documented at the cause site when needed
- [ ] Post-fix protocol executed under conditions no easier than reproduction; output pasted
- [ ] Any production-side cause was fixed in scope or remains an explicit blocker
- [ ] Self-review answered

## Fix (the change you made)

Where the cause lives and what you changed to remove the nondeterminism — injected clock vs seeded
RNG, isolated fixture, waited on a real contract, etc.

-

## Fix evidence (paste verbatim)

The output after the fix under the predefined post-fix protocol and conditions no easier than the
reproducing run.

```text
{{paste}}
```

- Loop runs after fix: {{n}} · Failures observed: {{n}} · Residual-risk note:

## Notes for downstream

An out-of-scope production race or leak, a sibling test touching the same shared state, or another
verified follow-up worth carrying forward.

-

## Blocked questions

A flake that does not fire under the predefined reproduction protocol goes here with the conditions
already tried; CI-only conditions you cannot recreate are reported as Blocked, never as a silent pass.

-

## Next steps

-

## Handoff

- [ ] Final evidence, summary, and findings copied into the controlling task/spec when one exists;
      otherwise included in the direct handoff. Nothing final lives only in these private notes.

## Self-review gate

Answer in writing, evidence pasted.

- **Reproduced first:** over how many loops, at what failure rate, under conditions no easier than
  where it originally failed?
- **Category:** are interacting categories evidenced and independent causes split?
- **Cause vs symptom:** is the fix at the cause — not the assertion, not a sleep, not a swallow,
  not quarantine? If a wait was used, on which documented contract?
- **Fix evidence:** did the predefined post-fix protocol observe no failures under conditions no
  easier than reproduction, with residual risk stated without claiming zero probability?
- **Handoff:** is any non-obvious invariant documented and every out-of-scope production cause explicit?
- **Honesty:** did you verify with a loop, or did one green tick end the session? You did not sign
  off on your own fix as if a second reviewer had.
