---
name: revolver
description: Drive a broad, purpose-agnostic check over code, diffs, artifacts, plans, or systems. ALWAYS apply when asked for Revolver, a broad adversarial audit, or a many-angle check that must be resolved as it runs. Derive at least six distinct stances from the target, run one fresh reviewer at a time, and address every finding before the next reviewer sees the current target. Complete a full rotation; stop after a quiet rotation or three cycles. Create no artifact. Reviewers never edit or issue a ship verdict.
---

# Revolver

Breadth comes from distinct attack surfaces, not a canned persona list.

Investigate discoverable facts before asking. Every material choice uses the native picker:
recommendation first, three genuine options by default or two when binary, one-sentence tradeoffs,
and automatic `Other`. Without a native picker, render the same numbered options plus `Other`.
Never ask a bare question. Batch only independent choices; ask dependent choices sequentially.

## Contract

- Create no artifact or sidecar. Keep round state in the orchestrator and return a compact chat
  outcome.
- Pin the starting target state.
- Derive at least six materially distinct stances from requirements, trust boundaries, failure
  modes, changed surfaces, users, and operating conditions. Use no canned menu or fixed upper limit.
- State each stance's falsification question and target evidence. Reject duplicates. Order the pool
  by consequence and uncertainty, then keep it fixed through the run.
- Run one fresh, read-only reviewer at a time. The orchestrator alone addresses findings.

Before the first stance, prove the harness can dispatch fresh reviewer contexts. If it cannot,
stop for a material choice: enable fresh dispatch and retry; run each stance in a separate clean
task and return the reports; cancel. Never simulate independence in one context.

## Rotate

1. Dispatch one fresh reviewer per stance on the cheapest model adequate for that stance.
2. Give it the current target, one stance, scope, and the discipline below. Hide all prior reviewer
   prose.
3. Adjudicate every finding before dispatching the next reviewer:
   - supported: apply the legitimate fix when mutation is allowed, then verify it;
   - refuted: reject it with decisive evidence;
   - unverified or blocked: stop for a structured human choice.
4. Never carry an unresolved material finding into the next stance. An explicit human deferral
   counts as addressed; silence does not.
5. Pin the addressed target. The next stance reviews that state, including every prior fix.
6. Finish the full pool. One complete rotation is mandatory.
7. Start another rotation only when the completed rotation produced a new supported finding.
8. Stop after one quiet rotation or three cycles, whichever comes first.

## Reviewer discipline

Inject this into every reviewer prompt:

- Refute claims until evidence supports them. Rerun non-mutating checks when possible.
- Read callers, dependencies, unchanged companion surfaces, and failure paths. Do not review only
  the presented diff.
- Report only actionable findings with location, consequence, decisive evidence, and a minimal fix
  direction. Drop vague concerns and praise.
- Never edit, read peer prose, or issue a ship verdict.

Reconcile duplicates and disagreements through evidence, never vote. Record findings once. Never
issue a ship verdict.

Return only the material changes, verification, rejected false positives that affect trust, and any
unresolved human choice. Do not dump stance transcripts or repeat the target.
