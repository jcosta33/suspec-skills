---
name: bulletproof
description: Fact-check an explicit claim set or the claims inside a completed review artifact, or preserve compact command proof after code or validation work. ALWAYS apply when asked to bulletproof, fact-check, validate, cross-examine, or harden those claims. Inspect code, consult primary sources, and run non-mutating checks. Never edit the target, implement the change, issue an accept/ship verdict, author or revise a spec, or review completed work or diffs for requirements conformance. Skip broad risk discovery without a claim set, requirements-conformance review, and one-sided advocacy.
---

# Bulletproof

Trust nothing that can be checked.

Investigate discoverable facts before asking. Every material choice uses the native picker:
recommendation first, three genuine options by default or two when binary, one-sentence tradeoffs,
and automatic `Other`. Without a native picker, render the same numbered options plus `Other`.
Never ask a bare question. Batch only independent choices; ask dependent choices sequentially.

## Contract

Choose one mode:

- **Verification:** require an explicit claim set, or a completed review artifact whose claims are
  the target. A diff may supply evidence; it is not itself a claim set. Pin the target and one stable
  state identifier. Keep it read-only. Assess every explicit claim and every implied claim carrying
  the conclusion as `Supported`, `Unsupported`, `Unverified`, or `Blocked`. A substantive run writes
  one artifact with `type: inspection`, `method: bulletproof`, and
  `target: <path-or-stable-identifier>`.
- **Implementation proof:** after code or validation work, preserve the decisive command facts.
  No claim set or assessment is required. Create no artifact solely for this mode.

Neither mode edits the target, implements work, checks completed work against governing
requirements, or accepts or ships anything.

Do not create an artifact for ordinary conversation. Create one only for a substantive verification
run or when the user requests it.

## Place

Resolve `~/.agents/artifacts/<workspace>/` to an absolute path, deriving `<workspace>` from the
repository or working-directory basename. Write under that resolved directory. Never write into the
repository, vendor storage, or an OS temporary directory. Never overwrite unrelated work. On a
workspace or filename collision, present distinct human-readable choices. If the root is
unwritable, offer: grant access and retry; choose another agent-neutral user directory; cancel.

## Verify Claims

1. Extract every claim. Include assumptions without which the conclusion fails.
2. State what would support and falsify each claim.
3. Inspect authoritative local sources first. Search primary external sources for external facts.
4. Run safe, non-mutating checks when existing evidence is absent, stale, or indirect.
5. Record one row per claim: `ID | Assessment | Evidence`.
6. Resolve disagreement through evidence, never confidence, authority, consensus, or vote.

If the claim set or boundary remains materially ambiguous after investigation, stop for a material
choice. A deferred choice blocks dependent verification.

## Proof

Record short decisive output once. When raw output would dominate the artifact, write an adjacent
`evidence-<slug>.md` receipt containing:

- stable `E-NNN` anchors;
- exact command and working directory;
- state identifier and exit status; and
- untouched raw output.

Map each supported claim to an anchor. One run may support several claims. In the inspection keep
only the decisive verbatim excerpt and receipt link. Never paraphrase command output into proof,
duplicate a run per claim, or present rerunnable upstream output as current evidence.

## Implementation Proof

After code or validation work, record each decisive run once with its exact command, working
directory, state identifier, numeric exit status, and decisive untouched raw output. Use the
existing task packet when one governs; otherwise put the compact record in chat. Do not create an
inspection or any other artifact solely for implementation proof.

This proof path records what ran. It does not edit the target, implement work, assess a substantive
claim set, or issue a verdict. A substantive claim-set verification still follows the full method
and writes its inspection.

## Close

Verification stops when every claim is assessed.
Implementation proof stops when every required run has one complete command record. For
implementation proof with no inspection artifact, return the decisive evidence once in chat. When a
downstream consumer still needs an inspection, return only its clickable absolute path. At true
lifecycle close, skip the path-only handoff and issue the disposition choice instead.

Prompt only when this skill is the final consumer, a non-empty transient artifact set exists, no
earlier disposition prompt occurred, and no downstream step needs any transient artifact or sidecar
created or consumed by the active work. Ask once about the complete transient set: Delete, Leave, or
Promote. Repository-native and other durable inputs never enter disposition. Include every transient
path. Never choose for the human.
