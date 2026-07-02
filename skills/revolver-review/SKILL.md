---
name: revolver-review
type: agent-guide
description: "Run a bounded, lead-orchestrated multi-lens review of a substantial change: a lead picks a few DISTINCT review lenses from a menu by risk, runs them BLIND and ISOLATED so they draft before they compare, reconciles their candidate findings into one report, and stops when the marginal UNIQUE findings dry up. ALWAYS apply when orchestrating several reviewers or lenses over one change, rotating stances across rounds, or bounding a multi-agent review so it does not loop or drown in duplicates. It is the orchestration around adversarial-review (each lens runs that discipline); it adds no new review authority — lenses produce findings + evidence, the lead reconciles, a human owns the verdict. Read-only and reconcile-only: reviewers reconcile already-run check output, they never spawn the project's build/test commands. Skip for a single-reviewer pass (use adversarial-review directly), for a tiny change where one lens suffices, and for writing the fix."
---

# Skill: revolver-review

## Purpose

A rotating multi-agent review fails in three opposite ways: it becomes an **unbounded loop** (keep
spinning up reviewers with no stop rule), it hands every change the **same fixed lens bundle** (and misses
the risk-specific failure), or it manufactures **false consensus** (three similar reviewers agree and the
agreement is mistaken for proof). Revolver Review bounds all three: a **lead** draws a few **distinct**
lenses from a menu by the change's risk, runs them **blind and isolated**, reconciles their candidate
findings into one report, and **stops when the marginal unique findings dry up**.

It is the **strong form of the [`adversarial-review`](../adversarial-review/SKILL.md) panel, named and
bounded** — each lens *is* an adversarial reviewer (refute-by-default, evidence-gated, cite `file:line` —
with one override: lenses reconcile already-run output rather than re-running commands; see below).
Revolver is the orchestration *around* those reviewers. It **adds no new review authority**: lenses produce
findings + evidence, the lead reconciles and dedups, and a **human owns the ship/merge verdict**. A lens
reviewer never sets the verdict.

## The flow

1. **Bind to intent.** The lead reads the change and its stated intent before choosing anything — a review
   unbound from intent over-corrects on style and misses real violations.
2. **Pick lenses by risk — a few distinct ones, not the whole menu.** Draw from the lens menu below the
   lenses the change actually warrants. Distinct lenses beat more copies of the same lens: **agreement is
   not a correctness signal**, and redundant reviewers err in correlated ways.
3. **Run blind and isolated — draft before compare.** Each same-round lens drafts its findings **before**
   seeing any other lens's raw output. Revealing early collapses the panel into one correlated opinion in
   triplicate. Only the lead sees all drafts.
4. **Reconcile into one report.** The lead dedups and adjudicates each candidate finding (the vocabulary
   below), resolves conflicts by **independent re-check and a vote — not debate** (debate propagates the
   shared error), and writes the single report.
5. **Stop on marginal unique yield.** Add a lens or a round only while it still surfaces **unique accepted**
   findings; stop when it does not, or when a hard round/budget cap is hit. **Never** stop on reviewer
   silence or agreement, and never continue just because a budget remains.
6. **Route the verdict to a human.** The report is findings + evidence + a human-attention list. The person
   accountable for shipping owns the call.

## The lens menu — a checklist, not a fixed set

Draw the lenses the change warrants; do not run all of them. **Counts are measured starting defaults, not
law** — how many lenses, how many rounds, how many per reviewer: start with a few distinct lenses and
**measure** whether another one adds *unique* findings. Treat no number as proven.

**Base lenses** (the common risk surface):

- **requirement/spec coverage** — does the change meet each stated requirement, with run evidence, and no
  unsupported claims.
- **regression risk** — unintentionally changed behavior, edge cases, compatibility paths.
- **security / privacy** — injection, authz/authn, secrets, sensitive logging, untrusted input, tool/prompt
  injection.
- **architecture / boundaries** — module boundaries, established layers, parallel-system drift, recorded
  design decisions.
- **pattern / idiom fit** — local patterns, framework idioms, neighboring style, abstraction fit.
- **tests / evidence** — meaningful tests, requirement mapping, durable proof, honest failures.
- **performance / resources** — N+1s, unbounded loops, CPU/memory/IO/latency, large inputs.
- **API / migration / compatibility** — public surface, data contracts, migrations, rollback.
- **maintainability** — scope creep, duplication, complexity, naming, dead code.

**Triggered lenses** (added by risk preflight when the change touches the area):

- **accessibility / UX** (UI, forms, focus, semantics) · **observability / ops** (logs, metrics, jobs,
  runtime paths) · **dependency / supply chain** (lockfiles, manifests, build/CI files) · **concurrency /
  idempotency** (async, locks, queues, retries, shared state) · **deployment / infra** (release config,
  runtime env) · **data correctness** (reports, metrics, migrations, business-critical data).

A worker reviewer may **not** abandon its assigned lens; it may **propose** an extra lens only with
evidence, for the lead to accept in a later round.

## Candidate-finding adjudication

Every lens output enters as a **candidate**; the lead moves each to one state:

| State          | Meaning                                                                                     |
| -------------- | ------------------------------------------------------------------------------------------- |
| **accepted**   | carries at least one concrete evidence reference (`file:line`, re-run output, a repro).      |
| **rejected**   | refuted; records a short reason.                                                            |
| **duplicate**  | the same issue another lens raised; keeps its source lens, points to the canonical candidate. |
| **unverified** | plausible but unproven; **cannot block or pass a review on its own**.                        |
| **blocked**    | needs input or an unavailable check before it can be judged.                                |

Rules: an **accepted** finding without concrete evidence is not accepted — it is unverified. Reviewer
**confidence is marked non-evidence**, never a substitute for it. Deduplication feeds the **unique-finding
count** that the stop rule reads. **Never auto-close a review on agent agreement.**

## Deterministic checks — reconcile, don't run

The reviewer or the worker runs the project's build/test/lint commands; Revolver **reconciles the pasted,
already-run output** against what the change claims. The strategy **never spawns the project's commands
itself** — a review that manufactures its own evidence is not an independent check. The discriminating
signal is **reliable, actionable, structured** feedback a reviewer can act on — a surfaced, interpretable
result, not a raw tool trace nobody reads. If the decisive check was never run, that is a **blocked**
candidate and a check to request, not something Revolver executes.

## Cost tiers — opt-in, size is not quality

When an adopter maps review roles to cost tiers, route the **blind lens reviewers to a cheaper tier** and
the **reconciling lead plus the high-risk lenses (security, architecture) to a stronger tier** — the runner
resolves the alias to a concrete model. There are **no shipped model defaults**, and **model size is never
a proxy for review quality** (it is non-monotonic — validate a cheaper model on *real* changes before
trusting it). A cheap-plus-strong mix has a second payoff: mixed models **decorrelate** the reviewers,
which buys the diversity the panel depends on.

## Measure it — do not hardcode a configuration as validated

The multi-reviewer evidence is real but **modest and unconfirmed for code review** (it comes from small
models on QA/math tasks); the diversity payoff is about *ordering* (a few distinct lenses beat more
identical ones), not a large ratio. So **measure, do not assert**: on real changes, track **marginal
unique-accepted findings per lens and per round** and **cost-versus-unique-yield per lens and tier**. Stop
expanding when unique yield flattens. Do not present any lens count, round count, or cheap-model default as
validated ahead of that measurement.

## Independence and isolation — the gotchas that decide whether it works

- **Early reveal.** Same-round lenses share a thread before drafting and all anchor on the first one's
  framing — one opinion in triplicate, not three. Keep stage one private.
- **Adjudicated summary, not raw drafts, across rounds.** A later round receives the lead's reconciled
  summary, never another lens's raw output — reading a peer's raw draft induces conformity.
- **Debate instead of re-check.** Resolving a conflict by argument propagates the shared error; resolve by
  each reviewer independently re-checking, then voting, refutation first.
- **Consensus as proof.** Three similar reviewers agreeing is not evidence; it is correlated error. Keep
  the lenses distinct and gate acceptance on evidence, not on the count that agreed.
- **Unbounded rotation.** Spinning up rounds while a budget remains, past the point unique findings dried
  up. The stop rule is unique yield, not remaining budget.
- **A lens issuing the verdict.** A lens reviewer writes findings + evidence only; the ship call is the
  human's.

## Pairs with

- [`adversarial-review`](../adversarial-review/SKILL.md) — the per-lens discipline each reviewer runs
  (refute by default, cite `file:line`; minus its re-run rule, which Revolver's reconcile-only boundary
  overrides). Revolver orchestrates a panel of these.
- [`bulletproof`](../bulletproof/SKILL.md) — for hardening a claim, decision, spec, or plan rather than
  reviewing a finished code change.
- [`empirical-proof`](../empirical-proof/SKILL.md) — the verbatim-pasted-output discipline the
  reconcile-only evidence rule leans on.
- [`concise-output`](../concise-output/SKILL.md) — the output-economy dial for the reconciled report.

## What does not belong

- An autonomous merge/ship verdict (a human owns it); an unbounded repair or review loop; running the
  project's build/test commands to manufacture evidence (reconcile-only); auto-closing a review on agent
  agreement; treating any lens/agent/round count as a proven law rather than a measured default; using
  model size as a quality proxy; a lens reviewer that renders the final status; sharing raw drafts across
  same-round lenses.
