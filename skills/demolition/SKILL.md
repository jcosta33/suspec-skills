---
name: demolition
description: Destroy an idea, design, claim, concept, code change, or plan through an explicitly one-sided advocacy exercise. Apply only when the user explicitly requests demolition or asks for an attack-at-all-costs argument. Speculation is allowed; fabricated sources, quotations, incidents, user reports, commands, and test output are forbidden. Never target a person or present the result as evidence.
---

# Demolition

Attack the target. Do not pretend the attack is truth.

Every choice uses the native picker with automatic `Other`. Without one, render the same numbered
options plus `Other`.
Never ask a bare question.

## Contract

- Explicit invocation only.
- Target ideas, designs, claims, concepts, code, or plans. Never people.
- Write one artifact with `type: inspection`, `method: demolition`, and
  `target: <path-or-stable-identifier>`.
- Make the first body line exactly: `Advocacy exercise, not evidence.`
- Nothing in the artifact becomes a finding until independently verified.

## Place

Resolve `~/.agents/artifacts/<workspace>/` to an absolute path, deriving `<workspace>` from the
repository or working-directory basename. Write under that resolved directory. Never write into the
repository, vendor storage, or an OS temporary directory. Never overwrite unrelated work. On a
workspace or filename collision, present distinct human-readable choices. If the root is
unwritable, offer: grant access and retry; choose another agent-neutral user directory; cancel.

## Method

1. Pin the target and its strongest claimed value.
2. Build the strongest case for rejection.
3. Exploit assumptions, edge cases, opportunity costs, failure narratives, and hostile frames.
4. Label speculation. Cite only sources actually checked.
5. Never invent evidence-shaped material.
6. End without balance, recommendation, assessment, or ship verdict.

Write each point once. Cut scene-setting, repeated source material, decorative sections, and a
conclusion that restates the attack. Return only the clickable artifact path.

If this skill is the final consumer, a non-empty transient artifact set exists, no earlier
disposition prompt occurred, and no downstream step needs any transient artifact or sidecar created
or consumed by the active work, ask once about the complete transient set: Delete, Leave, or
Promote. Repository-native and other durable inputs never enter disposition. Recommend from state,
explain each option in one sentence, include every transient path, and include `Other`. Never choose
for the human.
