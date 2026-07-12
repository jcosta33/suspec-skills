---
name: revolver-review
type: agent-guide
description: "Run a rotating adversarial review of a substantial change: derive at least 6 distinct stances from the target, never a default menu, then fire ONE reviewer at a time on a cost-conscious model adequate for its stance. After each review, the orchestrator applies legitimate fixes and the next stance reviews the REVISED code. Complete every stance in a rotation; repeat for up to 3 cycles, stopping when a cycle surfaces nothing new. Each subagent receives an EXTREMELY adversarial discipline: refute by default, rerun or reconcile evidence, cite file:line, and keep effective false positives low. Self-contained: it depends on no other skill. ALWAYS apply when reviewing a substantial change that must be driven to a clean state, not merely listed as findings. Skip a tiny one-line change and original authoring where nothing exists yet to refute."
---

# Skill: revolver-review

## Purpose

A rotating multi-agent review fails in predictable ways: it reviews the *original* diff and never sees
the bugs the fixes introduce, it loops forever with no stop rule, or it scrutinises some concerns far
harder than others. Revolver bounds all of that. Think of the name literally: a cylinder of stances
rotates, one chamber fires each round, and **every shot lands on the current target** — the latest
revised code, not the frozen original. The loop **converges the work to a clean state**; it does not
just hand a human a list.

## The revolver mechanism

1. **Derive and load the cylinder — at least 6 distinct stances.** Inspect the actual target, its stated
   intent, changed surfaces, surrounding callers and dependencies, evidence, and plausible failure
   modes; then autonomously name the stances that best expose *this change's* blind spots. **The
   orchestrating agent decides the full pool itself: use no canned taxonomy, default names, pre-seeded
   menu, or human-supplied stance list.** No fixed upper limit: use as many *genuinely distinct* stances
   as the change's risk surface supports — but review perspectives **saturate**, so a stance that
   duplicates another's falsification question adds cost and noise, not coverage. Distinctness is the
   real bound, not a number; six is the floor for a change substantial enough to warrant the loop.
2. **Fire one reviewer at a time.** Each round spawns **one** subagent holding the next stance, running
   the adversarial discipline below, reviewing the code **as it stands now**.
3. **Fix after every round.** The orchestrator collects that reviewer's findings, accepts the ones
   carrying concrete evidence, and **applies the legitimate fixes**. The reviewer never edits; the
   orchestrator does.
4. **Rotate through the pool, one stance per round.** Go around the circle — each stance fires **exactly
   once per rotation**, so every concern gets equal scrutiny (a one-in-one-out overlap would scrutinise
   the middle of the pool harder than the edges; firing one at a time keeps coverage even by
   construction).
5. **Always review the latest state.** Each stance reviews the code after **all** prior rounds' fixes —
   the finest-grained refinement, and the only structure that catches a regression a fix just introduced.
6. **One full rotation is the floor.** A rotation is done when every stance has fired once.
7. **Repeat up to 3 cycles; stop when a cycle goes quiet.** If the last full rotation still surfaced
   real, new accepted findings, run another — to a **maximum of 3 cycles**. Stop the moment a rotation
   surfaces no new accepted finding. The cap is an operational bound on cost and edit churn, not an
   empirically optimal number.

**Why one at a time, not a simultaneous panel.** One-at-a-time gives the finest feedback (each stance
sees every prior fix), catches interacting fixes earliest, keeps coverage even, and is cheapest per step.
A simultaneous panel would trade those for a decorrelated-ensemble effect on a single state — a benefit
the evidence finds **contested**, not decisive. This is a **reasoned default**, not a proven optimum: the
coverage-evenness is a matter of arithmetic, but the single-vs-panel choice is not settled by the
literature and is worth measuring on real changes before it is treated as fact.

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

## Derive the stances from the target

Before the first round, write the pool as a compact list. For each stance, state the distinct
falsification question it owns and the target evidence that made it relevant. Reject a candidate that
merely renames another stance or lacks a concrete surface to inspect. The pool must emerge from the
current change, not from a reusable review checklist. Order the rotation by potential consequence and
uncertainty, then keep the pool and its order fixed through every cycle.

## Models — adequate and cost-conscious

Choose the least costly model that can reliably execute the assigned stance and tools. Vary models
across the rotation where the runner offers a sensible choice, but treat variation as exploration,
not proof of independence or extra coverage.

- **Cost.** This loop rereads revised state every round. Cost-conscious routing keeps the process usable.
- **Adequacy.** A model that cannot inspect the code, run the required tools, or support its findings
  is false economy. Escalate that stance when evidence shows the assigned model is inadequate.
- **Variation.** Different model choices may expose different errors, but no current evidence guarantees
  decorrelated code-review failures. Never count model variety as correctness evidence.

Escalate a specific stance or the reconciling orchestrator when its work requires more capability;
do not upgrade the whole rotation without evidence that the cheaper assignments are inadequate.

## Reconcile and fix — the orchestrator's round

After each single reviewer, the orchestrator: takes its findings; moves each to **accepted** (carries
concrete evidence), **rejected** (refuted, with a reason), or **unverified** (plausible, unproven —
cannot gate on its own); and **applies the accepted fixes**. The revised code is what the next stance
sees. Aggregate findings **on evidence**, never on how confident the reviewer sounded.

## Independence — the gotchas that decide whether it works

- **Fresh reviewer every round.** Spawn a new subagent each round; a reviewer that reviews its own prior
  pass, or the fix it proposed, drifts into self-endorsement — the failure mode iterative review exists
  to avoid. The party that applied a fix is **never** the reviewer of that fix; the next stance is.
- **The next round sees the fixed code, not the last reviewer's raw draft.** Carry forward the
  orchestrator's revised state, never another reviewer's unadjudicated notes — reading a peer's raw draft
  induces conformity.
- **Distinct stances, varied models.** If the chambers are near-duplicates, rotation just re-hits the
  same blind spot. Keep them different.
- **Respect the cap.** More rounds burn tokens and risk over-editing correct code. Three cycles is the
  defined operational maximum; stop earlier when a rotation goes quiet.

## What does not belong

An unbounded loop with no cycle cap; firing several reviewers at once instead of one at a time (that is a
different, unmeasured design); reviewing the frozen original instead of the revised state; a reviewer
that edits the code or issues the ship verdict; running the reviewer chambers on an expensive model by
default; a canned stance menu or default stance name; asking the human to design or supply the pool; a
stance so vague it duplicates another chamber's blind spot; treating the pool size, the one-at-a-time
cadence, or the 3-cycle cap as proven constants rather than reasoned defaults to measure.
