---
name: demolition
type: agent-guide
description: Produce an explicitly one-sided persuasive destruction of an idea, design, claim, or concept. Apply only when the user explicitly requests Demolition or asks for an advocacy exercise whose purpose is to attack the target at all costs. Speculation is allowed; fabricated sources, quotations, incidents, and test output are forbidden. The artifact is quarantined from evidence and findings until independently verified. Never target a person.
---

# Demolition

`DISRESPEC-SPINE: One fact once. No filler, repeated source material, empty sections, or chat restatement; after successful creation return only clickable artifact links, except for blockers, failed creation, incomplete verification, or irreversible-action confirmation.`

## Artifact placement

Place the file under `~/.agents/artifacts/<workspace>/`, resolving `~` to the absolute
home path and deriving `<workspace>` from the repository or working-directory basename. Keep it
out of the repository and carry its absolute path forward. If the workspace name or target path
conflicts with unrelated work, stop for a structured human choice; never overwrite. If the root is
unwritable, offer grant access and retry, another agent-neutral user directory, or cancel. Never
fall back to vendor storage, the repository, or a temporary directory.

## Contract

- Explicit invocation only.
- Target ideas, designs, claims, concepts, code, or plans; never people.
- Produce one `type: inspection`, `method: demolition` artifact.
- The first body line must be exactly: `Advocacy exercise, not evidence.`
- Nothing in the artifact becomes a finding until another method verifies it.

## Method

1. Pin the target and its strongest claimed value.
2. Construct the strongest persuasive case that the target should be rejected.
3. Exploit assumptions, edge cases, opportunity cost, failure narratives, and alternative frames.
4. Label speculation. Cite only sources actually checked.
5. Never invent a quotation, source, incident, user report, command, or test result.
6. End without balance, recommendation, evidence assessment, or ship verdict. This is advocacy,
   deliberately quarantined from truth claims.
