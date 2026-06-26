---
name: adversarial-review
type: agent-guide
description: Review another agent's (or your own) change refute-by-default — the best-in-class form, for any repo. ALWAYS apply when reviewing a branch, a PR, a diff, a revision after a prior review, an audit you are deepening, or a bug you are root-causing — even if it looks correct. Run the project's tests yourself first; never sign off on the author's pasted output alone. As a panel (the strong form): a lead runs three or more independent reviewers, each one distinct lens, who draft before they compare. You produce findings + evidence; you do not own the merge decision — a human or an independent reviewer does. Skip when authoring the thing being reviewed (nothing exists yet to refute) and when writing the fix itself (that is a separate task).
---

# Skill: adversarial-review

## Purpose

Reviews fail when the reviewer accepts the author's framing. Set the author's claims aside, read the
code with fresh eyes, and **run the checks yourself**. The same hostility-to-plausible-explanations
applies whether you are reviewing a branch, deepening an audit, or hunting a bug. You produce *findings
+ evidence* — you do not decide whether it ships.

**Before you start, copy [`references/review-notes.md`](./references/review-notes.md) into your working
notes** — it is the session frame; fill it in as you go rather than reconstructing it from memory.

## Solo, or a panel of three lenses

- **Solo** — one reviewer, all the rules below, the six questions answered explicitly.
- **Panel (the strong form)** — a **lead** runs **three or more independent reviewers**, each taking
  **one distinct lens**: *correctness · verification/evidence/repro · maintainability/design risk* (add
  security, migration-safety, performance, data-integrity, concurrency as the change warrants). The lead
  reconciles, dedupes, and writes the one report. Diverse lenses beat redundant reviewers because
  **agreement is not a correctness signal** — models err in correlated ways, and the correlation grows
  with capability ([\[48\]](../../docs/sources.md#48)).

Two rules make a panel work:

- **Draft before you compare.** Each lens drafts its findings *before* seeing the others — independence
  first, comparison second. Revealing early collapses the panel into one correlated opinion ([\[48\]](../../docs/sources.md#48)).
- **Vote, don't debate; refute first.** Resolve a disagreement by each reviewer **independently
  re-checking** then **voting**, not by argument — debate propagates the shared error. On a contested
  finding the skeptic writes the **refutation first** (why the claim is unproven); it survives only if
  the refutation fails against fresh evidence.

## Project commands

Resolve the project's commands from its `AGENTS.md` Commands table (or its README / CI config) — the
test, lint, build, and typecheck commands, plus any project-specific validation. If you can't resolve a
command, **ask** rather than guess one — a guessed command that "passes" is worse than no check.

## Core procedure

### 1. Bind to the stated intent first

Read the PR description / issue / stated requirements **before** the diff — a review unbound from intent
both over-corrects on style and misses real violations. Every finding later maps to a stated requirement
or is called out as out-of-scope.

### 2. Run the checks yourself

Run install / test / lint in **your own clean checkout**, the branch checked out. The author's pasted
output is evidence they ran it *once*, not that it passes *now*. Re-running is the lever — substantive
engagement, not a sign-off, is what makes review catch defects ([\[49\]](../../docs/sources.md#49)).

### 3. The six adversarial questions (answer each explicitly)

1. **What was the intent?** State it in your words. If you can't, you haven't read enough.
2. **Does the code do it?** Point at the lines that address each stated requirement.
3. **What didn't change that should have?** Renamed types, callers, tests, docs — the bug is often in
   *unchanged* code.
4. **What edge cases are unhandled?** Empty / max / concurrent / partial-state / unicode / time-zone.
5. **What production failure modes are possible?** Network, races, resource exhaustion, retry storms.
6. **What was claimed but not verified?** Comb the author's notes for "should never", "harmless", "by
   happy accident" — confessions of unverified assumptions.

### 4. Cross-module caller search

For every changed public surface, grep for callers and read the calling code, not just the changed
module: `git grep -n '<changed-symbol>'`. Paste the output or summarise the call-site count and read each.

### 5. Every finding carries evidence and a false-positive risk

A finding is: **severity** (BLOCKER / MAJOR / MINOR) · **file:line** · **the specific issue** ·
**the evidence** (the diff line, the re-run output, the caller) · **an FP-risk** (high / medium / low) ·
**a fix sketch**. The FP-risk earns the finding its place: a reviewer who floods low-confidence flags
gets tuned out, so a noisy finding is worse than silence — keep effective false positives low
([\[51\]](../../docs/sources.md#51)). Vague concerns are not findings; sharpen to file:line or drop.

### 6. Mistrust confident language; don't trust the diff to be the work

"Should never happen", "harmless", "unlikely to fire" are assumptions to investigate, not assurances. A
diff that touches 3 files when the stated change needed 8 is *evidence* something was missed.

## Output — economical

Lead with the finding and its evidence; file:line throughout; no soft language ("maybe consider possibly
…"), no praise. Justify a finding to make the reader's check **cheap**, not to convince — long persuasive
prose raises trust without raising scrutiny ([\[52\]](../../docs/sources.md#52)). Pairs with the
[`concise-output`](../concise-output/SKILL.md) skill.

## You don't own the merge decision

You produce **findings + a human-attention list** — not an approve/merge/reject verdict. Why: the person
who can be accountable for shipping owns that call; a reviewer who self-issues "approved" removes the
human judgment the review existed to inform. And **never review your own work** — an author scoring their
own change cannot be trusted to disagree with it.

## Gotchas

- **Re-running dirty.** You re-run the author's command but against their already-built artifacts or a
  branch with their uncommitted state — it "passes" for the wrong reason. Re-run from a clean checkout.
- **Early reveal on a panel.** The three lenses share a thread before drafting, and all three anchor on
  the first reviewer's framing — you get one opinion in triplicate, not three (the exact correlation
  [\[48\]](../../docs/sources.md#48) warns of). Keep stage one private.
- **Severity laundering.** A BLOCKER gets filed as MINOR to avoid blocking the author. Severity is the
  consequence if it ships, not the social cost of saying so.
- **Diff tunnel vision.** You review only the changed lines; the defect is in an unchanged caller the
  diff never touched (question 3). Read the callers, not just the diff.
- **Guessed command.** No resolvable test command, so you assume one; it runs something unrelated and
  greens. A guessed check is negative evidence — ask instead.

## Pairs with

- [`persona-skeptic`](../persona-skeptic/SKILL.md) — the refute-by-default *stance* (the attitude); this
  skill is the *procedure* (the steps + the panel). Load both for a hard review.

## What does not belong

- Style preference as a finding (unless it violates a project convention); soft-language findings;
  findings without a fix sketch; signing off on the author's claims without re-running the checks;
  inheriting the author's framing; demoting a finding to dodge blocking the author.

## Bundled resources

- [`references/review-notes.md`](./references/review-notes.md) — the fillable review session frame: diff
  overview, the findings table (severity · file:line · evidence · FP-risk · fix), suggested decision, and
  a self-review gate. Copy it into your notes, substitute the project commands, fill it as you go.
