# Run notes: {{title}}

- Run notes: {{full path or stable native-artifact identifier for this file}}
- Task packet: {{full path when dispatched from one; otherwise None}}
- Spec: {{full path when one exists; otherwise None}}
- Change plan (target, rollback ceiling): {{full path to the change plan}}
- Worktree / branch: {{branch}}
- Created: {{YYYY-MM-DD}} · Status: active

Place the file next to your own native artifacts — the same place you keep your plans,
notes, and memories for this work, in a folder named after the repo you are working on
(or wherever fits your harness best). You choose the exact spot; keep it out of the repo
unless the project's own governance says otherwise, and carry the file's full path
forward — every later step names artifacts by explicit path.

> **Performance task** — numbers, not vibes. Baseline before any edit; identical measurement
> protocol on both sides; one benchmarked change at a time; full suite green after every change.
>
> **Commands** resolve from the code repo's `AGENTS.md` Commands table. The **benchmark command**
> is what the evidence is measured with — if it is undefined, ask the user before establishing the
> baseline. A guessed invocation produces a baseline the final figure cannot honestly be compared
> against.

## Scope (from the task packet or direct intent)

- Optimize: {{what, on what input, under what conditions}}
- Preserve: correctness — the ACs the speedup must not trade away.
- Do not change: {{areas the packet rules out}}; a second bottleneck goes to Findings.

## Target

Pulled from the requirement — a number under named conditions. "Make X faster" is not a target;
raise a blocked question and get the number first.

- **Metric:** {{p95 latency / throughput / allocations / …}}
- **Target value:** {{number under named conditions}}
- **Rollback ceiling:** {{the regression threshold on any other metric that rolls the change back
  regardless of the primary gain — from the change plan}}

## Measurement protocol

Identical before and after — record once, reuse verbatim. Different conditions give different
numbers and the comparison is void.

- Warmup runs: · Sample count or stopping rule: · Aggregate (mean / median / p95 / p99):
- Uncertainty / variance measure:
- Hardware / environment:
- Input shape / load profile / cache state:

## Baseline (before any code change)

**Benchmark command:** `{{command}}`

```text
{{paste baseline output here — captured before any edit}}
```

## Hypothesis

The bottleneck you believe in, stated so a measurement could disprove it — and the profile that
confirmed it before optimizing.

-

## Change ledger (one benchmarked change at a time)

| # | Change | Benchmark (same protocol) | Suite result | Keep / roll back |
|---|---|---|---|---|
| 1 | | | | |

## Progress checklist

- [ ] Packet and change plan read; target is a number; ceiling recorded
- [ ] Protocol fixed and recorded above
- [ ] Baseline measured and pasted before any edit
- [ ] Hypothesis stated; bottleneck profiled
- [ ] Each change benchmarked individually under the same protocol; suite run after each
- [ ] Final benchmark meets the target under the baseline's protocol
- [ ] Readability costs annotated at the call site
- [ ] Findings recorded; self-review answered

## Evidence (paste actual command output — never paraphrase)

- Baseline benchmark output:
- Final benchmark output (identical protocol):
- Full test suite after the final change (runner summary + exit):
- Check command (runner summary + exit):

## Decisions

Choices the requirements did not constrain — including why a readability trade was accepted.
("The optimization worked" is evidence, not a decision; it goes above.)

-

## Findings

Second bottlenecks, allocations on hot paths, N+1 patterns. Keep them here for review; only
evidence-backed, durable lessons move into native memory or project channels at close.

-

## Blocked questions

A target stated only as a direction, an unclear correctness requirement.

-

## Next steps

-

## Handoff

- [ ] Final evidence, summary, and findings copied into the controlling task/spec when one exists;
      otherwise included in the direct handoff. Nothing final lives only in these private notes.

## Self-review

Answer in writing, evidence pasted. Performance work fails two ways — a number that improved on
the benchmark but not in production, and a speedup that quietly broke correctness.

- **Baseline and target:** measured before any edit; final figure hits the numeric target under
  the same conditions; both pasted?
- **Protocol identity:** warmup, stopping rule, aggregate, uncertainty, host, input, and cache state
  fixed before measurement and provably identical on both sides? If revised, were both sides rerun?
- **Attribution:** each change benchmarked individually — can you point at which change moved the
  number?
- **Correctness:** full suite green after every change, output pasted; any path the benchmark
  exercises that the suite does not cover?
- **Conditions and ceiling:** the conditions under which the gain holds are recorded; no other
  metric breached the rollback ceiling?
- **Scope:** no behavior change under the perf label; second bottlenecks recorded as findings; no
  review result issued on your own work.
