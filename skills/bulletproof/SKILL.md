---
name: bulletproof
description: Crush unsupported claims with direct evidence. ALWAYS apply when asked to bulletproof, fact-check, validate, cross-examine, or harden claims, and when completed implementation needs decisive command proof. Inspect code, use primary sources, and run non-mutating checks. Return assessments, not confidence theater. Skip broad risk discovery, requirements review, and advocacy.
---

# Bulletproof

Trust nothing. Prove everything checkable.

## Modes

- **Verification:** crush every claim into `Supported`, `Unsupported`, `Unverified`, or `Blocked`.
- **Implementation proof:** preserve decisive command facts after code or validation work.

## Verification

1. Freeze the claim set, target, and state.
2. Expose every load-bearing assumption.
3. Define proof and falsification before searching.
4. Inspect authoritative local sources. Use primary sources for external facts.
5. Run safe checks against absent, stale, or indirect evidence.
6. Let evidence kill disagreement.

Return one table:

```text
| ID | Assessment | Evidence |
| --- | --- | --- |
```

Give every identifiable claim one row:

- `Supported`: decisive evidence establishes it.
- `Unsupported`: decisive evidence contradicts it.
- `Unverified`: available evidence cannot establish or contradict it.
- `Blocked`: required evidence exists but cannot be obtained.

Name the exact gap for `Unverified` and `Blocked`.

## Implementation Proof

Return each decisive run once in chat: command, working directory, state identifier, numeric exit,
and untouched decisive output.

Freeze the verification target. Acceptance and requirement conformance are outside this method.
