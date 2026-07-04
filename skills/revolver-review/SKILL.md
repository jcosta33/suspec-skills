---
name: revolver-review
type: agent-guide
description: "Run a rotating, self-converging adversarial review of a substantial change: a pool of 6-9 distinct review stances, fired 3 subagents at a time on cheaper, varied models; after each trio the orchestrator applies the legitimate fixes and the NEXT trio reviews the REVISED code, rotating one stance in and one out like a revolver cylinder; continue until one full rotation covers every stance, then repeat for up to 3 cycles, stopping when a cycle surfaces nothing new. Each subagent runs an EXTREMELY adversarial discipline — refute by default, re-run/reconcile the evidence itself, cite file:line, keep effective false positives low — injected into its prompt alongside its assigned stance. Self-contained: it depends on no other skill. ALWAYS apply when reviewing a substantial change and you want it driven to a clean state, not just a findings list. Skip for a tiny one-line change and for original authoring (nothing exists yet to refute)."
---

# Skill: revolver-review

## Purpose

A rotating multi-agent review fails in predictable ways: it fires everyone at once and drowns in
duplicates, it reviews the *original* diff and never sees the bugs the fixes introduce, it loops
forever with no stop rule, or it manufactures false consensus (similar reviewers agree and the
agreement is mistaken for proof). Revolver bounds all of that. Think of the name literally: a cylinder
of stances rotates, a few chambers fire each round, and **every shot lands on the current target** — the
latest revised code, not the frozen original. The loop **converges the work to a clean state**; it does
not just hand a human a list.

## The revolver mechanism

1. **Load the cylinder — 6 to 9 distinct stances.** Draw from the stance menu below plus whatever this
   specific change warrants. Distinct stances are load-bearing: reviewers that share a blind spot
   *rearrange* errors instead of removing them, so the pool must actually differ.
2. **Fire 3 at a time — never more.** Each round spawns exactly **3 subagent reviewers**, each holding
   one stance, each running the adversarial discipline below. They run **blind and isolated** — they
   draft their findings before seeing anything but the code; only the orchestrator sees all three.
3. **Fix between every round.** After a trio reports, the **orchestrator** collects the findings,
   accepts the ones that carry concrete evidence, and **applies the legitimate fixes**. The reviewers
   never edit; the orchestrator does.
4. **Rotate one chamber.** The next trio drops the oldest stance and introduces the next one from the
   pool (`{A,B,C}` → `{B,C,D}` → `{C,D,E}` …) — overlap two, swap one, cycling the circle.
5. **Always review the latest state.** Each trio reviews the code **as it stands after the previous
   round's fixes**, never the original diff. This is the whole point: it is the only structure that
   catches the regressions a fix introduces.
6. **One full rotation is the floor.** A rotation is done when every stance in the pool has fired once.
   Then the orchestrator consolidates and applies any remaining legitimate fixes.
7. **Repeat up to 3 cycles; stop when a cycle goes quiet.** If the last full rotation still surfaced
   real, new accepted findings, run another rotation — to a **maximum of 3 cycles**. Stop the moment a
   full rotation surfaces no new accepted finding: the yield has dried up. Evidence on iterative repair
   is blunt — the first one or two passes capture the bulk of reachable improvement and the curve
   flattens fast, so the cap is where the value already is, and it stops the loop from churning the
   code (and the token bill) for nothing.

## The adversarial discipline every subagent adopts

Inject this into **each** reviewer subagent's prompt, on top of its assigned stance. This is the
conditioning that makes a reviewer worth spawning — a reviewer that accepts the author's framing waves
holes through.

- **Refute by default.** A claim is unproven until evidence forces the opposite conclusion. A green
  summary, a small diff, and confident prose are starting points, never proof.
- **Re-run / reconcile the evidence yourself.** Do not trust pasted output — it is the claim under
  review, not its proof. Where you can re-run a check, do; where the harness forbids re-running, work
  only from already-run output and mark anything unrun as **unverified**, never assumed-passing.
- **Cite `file:line` per finding.** A vague concern is not a finding — sharpen it to a specific surface
  and issue or drop it.
- **Answer the adversarial questions explicitly** (an unanswered one is a gap, not a preference):
  what was the intent; what would falsify this; does the code do *that exact* requirement (not a
  neighbour); what did **not** change that should have (renamed callers, tests, docs); what edge and
  failure cases are unhandled; what was claimed but never verified; did behavior change outside the
  stated scope.
- **Read the callers, not just the diff.** For every changed public surface, grep its callers and read
  them — the bug is often in unchanged code that needed updating.
- **Carry an FP-risk and a fix sketch per finding**, and **keep effective false positives low** — a
  reviewer who floods low-confidence flags gets tuned out, so a noisy finding is worse than silence.
- **No praise, no softening.** Severity is the consequence if it ships, not the social cost of saying
  so. Lead with the finding and its evidence; justify only enough to make the reader's check cheap.
- **Never issue the ship verdict, never edit the code.** A reviewer produces findings + evidence. The
  orchestrator fixes; a human owns the final call.

## The stance menu — pick 6 to 9, distinct

**Base stances:** requirement/spec coverage · regression risk · security/privacy · architecture &
boundaries · pattern/idiom fit · tests & evidence · performance/resources · API/migration/compatibility
· maintainability (scope creep, duplication, dead code).

**Add by risk when the change touches the area:** accessibility/UX · observability/ops · dependency &
supply chain · concurrency/idempotency · deployment/infra · data correctness.

Order the rotation so the highest-risk stances for *this* change fire first and fire again if a second
cycle runs.

## Models — cheap and varied, so the loop is affordable

The reviewer subagents run on **lower-end models by default**, and on **different** models across the
trio where the runner offers a choice. Two reasons, both load-bearing:

- **Cost.** This is a loop that re-reviews the revised state every round across up to 3 cycles. On a
  top-tier model that bankrupts the review and no one runs it. Cheaper reviewers keep it affordable
  enough to actually use.
- **Decorrelation.** Different models err in different ways; a varied trio surfaces coverage a uniform
  one misses — the diversity the panel depends on, bought for free by not paying for uniformity.

Escalating a specific reviewer to a stronger model is a deliberate opt-in for a genuinely high-risk
stance (security, architecture) — never the default, and never for the whole panel. The orchestrator
that reconciles and fixes may run stronger; the reviewer chambers stay cheap.

## Reconcile and fix — the orchestrator's round

Between trios the orchestrator: **unions** every finding (never majority-filters — consensus
aggregation drags a panel below its best member); moves each candidate to **accepted** (carries
concrete evidence), **rejected** (refuted, with a reason), **duplicate**, or **unverified** (plausible,
unproven — cannot gate on its own); and **applies the accepted fixes** to the code. A contested
rejection is resolved by an independent re-check, refutation first — not by debate, which propagates
the shared error. The revised code is what the next trio sees.

## Independence — the gotchas that decide whether it works

- **Fresh reviewers every round.** Spawn new subagents each trio; a reviewer that reviews its own prior
  pass, or the fix it proposed, drifts into self-endorsement — the failure mode iterative review exists
  to avoid. The party that applies the fix is **never** a reviewer of that fix; the next trio is.
- **Blind within a round.** The three same-round reviewers never see each other's drafts before
  drafting — early reveal collapses three opinions into one in triplicate.
- **Union, not vote.** Agreement is not a correctness signal; evidence decides which findings survive,
  never the count that agreed.
- **Distinct stances, varied models.** If the chambers are near-duplicates, rotation just rearranges the
  same blind spot. Keep them different.
- **Respect the cap.** Past ~3 cycles the curve is flat; more rounds burn tokens and risk over-editing
  correct code. Stop when a rotation goes quiet.

## What does not belong

An unbounded loop with no cycle cap; a whole panel fired at once instead of trios; reviewing the frozen
original instead of the revised state; a reviewer that edits the code or issues the ship verdict;
majority-voting findings instead of unioning them on evidence; running the reviewer chambers on an
expensive model by default; a stance so vague it duplicates another chamber's blind spot.
