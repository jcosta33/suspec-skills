---
name: bulletproof
type: agent-guide
description: Fact-check every explicit and load-bearing implied claim in an important target through code inspection, primary sources, and non-mutating checks. ALWAYS apply when asked to bulletproof, fact-check, validate claims, cross-examine evidence, or harden a claim, decision, spec, plan, diff, review, or finding. The target is read-only; active evidence generation is allowed. Produce claim assessments, never an accept/ship verdict. Skip broad risk discovery without a claim set, persuasive advocacy, and implementation.
---

# Bulletproof

`DISRESPEC-SPINE: One fact once. No filler, repeated source material, empty sections, or chat restatement; after successful creation return only clickable artifact links, except for blockers, failed creation, incomplete verification, or irreversible-action confirmation.`

## Contract

- Target: any claim-bearing artifact or change.
- Mutation: never edit the target.
- Evidence: inspect code, consult primary sources, and run non-mutating checks needed to test claims.
- Output: one `type: inspection`, `method: bulletproof` artifact.
- Authority: assess claims; never accept or ship the target.

## Method

1. Pin the target and state identifier.
2. Enumerate every explicit claim and every implied claim on which the conclusion depends.
3. Define what evidence would support and falsify each claim.
4. Inspect authoritative local sources first. Use primary external sources for external facts.
5. Run non-mutating checks when existing evidence is absent or stale.
6. Record `Supported`, `Unsupported`, `Unverified`, or `Blocked` per claim with exact evidence.
7. Link large raw output through evidence receipts. Do not convert confidence, consensus, or
   authority into support.

Stop when every claim has an assessment. Do not add a ship verdict.
