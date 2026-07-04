---
name: bulletproof
type: agent-guide
description: "Harden an important target — a claim, decision, spec, plan, code diff, review, or finding — by making it survive hostile scrutiny: expose unsupported claims, hidden assumptions, failure modes, disconfirming tests, and kill criteria, then render a verdict gated on already-run evidence, not on confidence, consensus, or authority. ALWAYS apply when asked to bulletproof, stress-test, challenge, red-team, cross-examine, poke holes in, find flaws in, or harden something important before it is committed or shipped. Read-only and reconcile-only: it reads evidence and reasons, it never edits the target, and it never runs the project's build/test commands — it reconciles evidence already run. It produces a structured hardening report; a human owns the accept/ship call. Skip for routine friendly editing, for reviewing a finished code diff or PR against its stated intent (that is revolver-review), and for writing the fix itself."
disable-model-invocation: true
allowed-tools: Read Grep Glob
---

# Skill: bulletproof

## Purpose

Important claims get waved through on confident prose. The default behavior is to read a fluent
explanation, a plausible plan, or a firmly-stated decision and treat the confidence as proof — which is
the exact path a wrong claim survives. This skill inverts that default: a target is **hardened** only
when it has survived hostile scrutiny, and the standard for surviving is **evidence**, not attitude and
not identity. An important claim without reliable, actionable, already-run evidence is **not accepted** —
however confident the wording, however many voices agree, however authoritative the source sounds.

The lever is not skepticism-as-mood; it is the evidence you reconcile. Unaided doubt that grounds in no
external check discards a sound claim about as readily as a flawed one. Bulletproof is a **procedure, not
a persona**: its worth is the reasoning it runs, not a role it plays.

## Not a persona — a procedure

Dropping into an identity ("act as a ruthless skeptic") is unstable and **net-negative on objective
tasks**: the mood adds variance, not accuracy, and which persona you pick swings the result almost at
random. What actually helps is the explicit reasoning scaffold underneath the role. So Bulletproof
**keeps the procedure and drops the identity.**

And run it as a **voice independent of whoever produced the target** — a generator favors its own output,
so a self-issued "this holds" is inadmissible. Turn the procedure on your own work by making a
deliberately external pass that reconciles evidence and steelmans the opposite, never by re-reading your
own reasoning and nodding.

## The evidence gate — the spine

A judgment — "acceptable", "pass", "this holds" — is gated on **reliable, actionable, already-run
evidence**, never on model confidence, agreement/consensus, or persona. **No evidence, no acceptance.**

Bulletproof is **reconcile-only**: it reads evidence that was *already produced* — pasted test output, a
reproduction, a diff read directly, a benchmark, a cited primary source, a recorded prior decision — and
reconciles it against what is claimed. It **does not run the project's build or test commands itself.** If
the decisive check has not been run, that is a *missing-evidence* finding and a *disconfirming test to
propose* — not something this skill executes.

Grade every important claim's support against the ladder:

- **Strong** — reproduced test output; the diff read directly; a benchmark; official documentation; a
  primary source; a recorded prior decision; a CI result; an explicit user-stated fact.
- **Medium** — a plausible inference from source; a comparable prior incident; an expert secondary
  source; a pattern from neighboring code.
- **Weak** — a vibe; a convention; an anecdote; an unsourced assertion; model confidence; "best practice"
  with no context.
- **Invalid** — an invented source; a broken citation; "the model says so"; an empty evidence field.

An important claim resting on weak or invalid evidence reads **Needs evidence**, never Acceptable. In
the claim map below, Strong or Medium evidence reads *supported*, Weak reads *weak*, and Invalid or absent
evidence reads *unsupported* — the ladder grades the evidence, the claim map grades the claim it backs.

## Modes — one procedure, different focus

- **Claim** — factual, research, product, naming, or strategy claims. Focus: evidence, counterexamples,
  ambiguity, source quality, inference gaps, falsifiability.
- **Decision** — product, architecture, naming, workflow, process. Focus: assumptions, reversibility,
  alternatives, cost of being wrong, kill criteria, decision threshold, downstream consequences.
- **Spec** — a requirements or design document. Focus: vague acceptance criteria, missing scope limits,
  missing evidence requirements, conflicting constraints, untestable requirements, rollback gaps.
- **Plan** — an implementation, rollout, or orchestration plan. Focus: missing steps, unsafe sequencing,
  hidden dependencies, missing verification, stale assumptions, over-prescription.
- **Code / diff** — for a *finished* code change reviewed against its intent, hand off to
  `revolver-review` (it re-runs the checks and refutes by default). Use this mode only to harden the
  *reasoning around* a change — the risk story, the untested path, the rollback.
- **Review** — a review write-up or a set of reported issues. Focus: unsupported "pass" calls, duplicate
  or low-value items, severity inflation, missing evidence, conclusions beyond the evidence.
- **Finding** — a single reported issue. Focus: reproduction, evidence, severity calibration,
  actionability, resolution criteria.

## Procedure — the reasoning scaffold

Run these in order; an unanswered step is a gap in the critique, not a stylistic choice. If a step does
not apply to the target, say so explicitly rather than skipping it silently.

1. **Identify the target** and restate its central claim or decision in your own words. If you can't, you
   have not read enough to harden it.
2. **Split every statement** into fact / inference / assumption / preference.
3. **Name the evidence** each important claim requires to hold.
4. **Reconcile what was already run** against what is claimed; mark missing or weak evidence.
5. **Build the strongest counterargument** — steelman the opposite before you dismiss it.
6. **Hunt failure modes** — empty / max / concurrent / partial-state / adversarial input; and production
   modes (network, races, resource exhaustion, retry storms).
7. **Name the cheapest disconfirming test** for each load-bearing claim.
8. **State the risk if it is wrong**, and how reversible being wrong is.
9. **Recommend** — Acceptable as-is / Acceptable with caveats / Needs evidence / Needs revision / Reject.
10. **Define kill criteria** — exactly what observation would prove the target wrong.
11. **State what evidence would change the verdict.**

## Output — structured and economical

Always emit the fixed structure below. Lead with the finding and its evidence; point to the exact locus
(`file:line`, a quoted line, a section) wherever one exists; no praise, no soft "maybe consider possibly".
Justify a finding to make the reader's own check **cheap**, not to persuade — long persuasive prose raises
trust without raising scrutiny.

```markdown
# Bulletproof report

## Target
What is under scrutiny, in one line.

## Verdict
Acceptable as-is · Acceptable with caveats · Needs evidence · Needs revision · Reject

## Confidence
High / Medium / Low — and why it is not higher.

## Claim map
| Claim | Type | Evidence | Status |
| ----- | ---- | -------- | ------ |
| …     | fact / inference / assumption / preference | … | supported / weak / unsupported |

## Hidden assumptions
## Missing evidence
## Strongest counterargument

## Failure modes
| Failure mode | Likelihood | Impact | Detection |
| ------------ | ---------- | ------ | --------- |

## Disconfirming tests
## Required changes

## Kill criteria
The target should be rejected if:
- …

## What would change the verdict
```

## Severity

- **Critical** — can cause a security breach, data loss, legal/compliance failure, a broken public
  contract, or irreversible damage.
- **High** — likely to break important behavior, undermine reviewability, or invalidate the decision.
- **Medium** — a meaningful risk or missing evidence, not immediately dangerous.
- **Low** — a minor concern, a clarity issue, an improvement.

Rules: do not inflate a low-impact issue; do not bury a critical issue among nits; do not call something
critical without evidence; **if only low-severity issues remain, say so plainly** rather than manufacturing
a blocker.

## The Refuses table

The default is to accept each of these at face value. Each is a red flag with a fixed response.

| Red flag                                                                        | Action                                                                                     |
| ------------------------------------------------------------------------------- | ------------------------------------------------------------------------------------------ |
| Confident prose offered as proof ("clearly", "obviously", "well-established").  | Reject; demand the artifact — the output, the source, the diff.                            |
| Agreement / consensus offered as correctness ("everyone agrees", "3 of 3 say"). | Reject; agreement is not an evidence signal — voices can err in the same direction.        |
| Authority or persona standing in for evidence ("as an expert, trust me").       | Reject; identity is not evidence — grade the claim on what backs it.                       |
| "Should never happen", "harmless", "edge case unlikely to fire".                | Reject as an assurance; investigate the assumption, then judge on evidence.                |
| A nitpick pile while a high-impact risk sits unaddressed.                        | Reorder; fatal flaws first, low-severity last or unstated.                                 |
| Fake balance — a pro invented to look even-handed.                              | Drop it; only evidence-backed points earn a place.                                         |
| A verdict issued on a target the same voice authored.                           | Refuse; require an independent voice — a generator favors its own output.                  |
| Editing or repairing the target during the critique.                            | Refuse; Bulletproof judges, it does not repair. The fix is a separate task.                |
| Running the project's build/test commands to manufacture the missing evidence.  | Refuse; reconcile-only — record the gap and propose the disconfirming test instead.        |
| An important claim with an empty evidence field.                                | Needs evidence, never Acceptable.                                                          |
| A confident verdict offered while the evidence is incomplete.                   | Downgrade to Needs evidence and name exactly what is missing.                              |

## Relationship to neighboring skills

- **`revolver-review`** — owns reviewing a **finished code diff or PR** against its stated intent,
  refute-by-default, re-running the checks in a clean checkout. When the target is a code change, use
  that skill; Bulletproof is the broader hardening protocol for claims, decisions, specs, and plans, and
  hands code-diff review to it.
- **`persona-challenger`** — pressure-tests a **live, uncommitted proposal**. Bulletproof overlaps with
  it (both ground every challenge externally and both run as a voice separate from the author) but is
  broader and always emits the fixed structured report with kill criteria. Whether the two eventually
  merge, or one is renamed, is a separate decision — this skill does not settle or fold it.

## Read-only is enforced by the runner, not by this list

`allowed-tools` names what the skill may reach *without a permission prompt*; it is **not** a read-only
guarantee. Real read-only enforcement is the runner's job — a `disallowed-tools` list, a permission rule,
or a subagent whose tool allowlist is `Read`/`Grep`/`Glob` under a plan-only permission mode. Treat the
frontmatter as intent and set the enforcement where the runner enforces it.

## Gotchas

- **Certainty theater.** Demanding metaphysical proof and blocking progress. The bar is *evidence
  sufficient for this decision at this risk*, with residual risk named and accepted — not perfection.
- **Nitpick flood.** Burying one fatal flaw under twenty style notes. Lead with the fatal flaw; a
  reviewer who floods low-confidence flags gets tuned out.
- **Fake balance.** Inventing a counter-point to look even-handed. Only evidence-backed points earn a
  place; a manufactured pro is noise.
- **Persona drift.** Sliding into a contrarian voice. The value is the procedure — contrarian tone raises
  heat, not accuracy.
- **Refuting a checkable fact from memory.** A count, a version, whether a file or symbol exists — waved
  off from recall. Query the live source first; "it's not there" is a finding only after the lookup
  actually failed.
- **Manufacturing evidence.** Running the build or tests yourself to fill the gap. Reconcile-only —
  propose the disconfirming test; the gap *is* the finding.
- **Self-pass.** Hardening your own target, finding nothing, and quietly accepting it. Run the procedure
  as a voice independent of the author, or mark the self-pass inadmissible.

## Pairs with

- [`empirical-proof`](../empirical-proof/SKILL.md) — the verbatim-pasted-output discipline the evidence
  gate leans on (reconcile the real output, not a paraphrase).
- [`concise-output`](../concise-output/SKILL.md) — the output-economy dial for the report you write.
- [`revolver-review`](../revolver-review/SKILL.md) — the finished-code-change review lens Bulletproof
  defers to when the target is a diff or PR.

## What does not belong

- Presenting itself as a persona or personality; auto-triggering; writing the code or the fix; running
  the project's commands to generate evidence (reconcile-only); issuing a ship/merge/accept verdict
  (a human owns that); inventing evidence or a source; a style-preference nitpick dressed as critical;
  fake balance; a confident verdict on incomplete evidence (say "needs evidence" instead); a verdict on a
  target the same voice authored.
