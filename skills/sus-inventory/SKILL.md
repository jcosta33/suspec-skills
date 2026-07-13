---
name: sus-inventory
description: Write a reconstructive inventory of an unfamiliar or change-critical code area. ALWAYS apply before a rewrite, major refactor, migration, subsystem replacement, or brownfield handoff when current modules, interfaces, callers, behavior, tests, or unknown dependencies are not proven. Map what exists with evidence. Never judge quality, prescribe change, or turn uncertainty into a guess. Skip small, isolated work with a known map.
---

# Sus Inventory

Map the terrain. Do not grade it.

Ordinary conversation and direct action create no inventory. Write one only when requested or
required as a live workflow input.

## Place

Resolve `~/.agents/artifacts/<workspace>/` to an absolute path, deriving `<workspace>` from the
repository or working-directory basename. Write one artifact with frontmatter `type: inventory` and
a unique `id` using the `INV-` prefix under that resolved directory. Never write into the
repository, vendor storage, or an OS temporary directory. Never overwrite unrelated work. Stop with
structured choices on collision or blocked writes.

## Map

1. Bound the scope and exclusions to the coming change.
2. List current modules: path, observed responsibility, evidence.
3. List current interfaces: signature or surface, direct and dynamic callers, observed contract,
   evidence.
4. Record externally visible behavior with tests, `file:line`, or decisive command output.
5. Map data, state, side effects, persistence, generated surfaces, configuration, and external
   consumers.
6. List existing tests and the behavior each actually controls.
7. Record unknowns with the exact search boundary and missing evidence. If none surfaced, state
   `None found` and the boundary checked.

Search for callers and string registrations; memory is not evidence. Run safe checks for dynamic
claims. A zero-caller or no-match claim requires the command and result. Every sentence must fit:
`this exists; it behaves this way; here is the evidence.`

If the scope remains materially ambiguous after investigation, use a native picker with three real
options by default, two when binary, recommendation first, one-sentence tradeoffs, and automatic
`Other`. Without a picker, render the same numbered options plus `Other`. Never ask a bare question.

Refuse severity, findings, prescriptions, target architecture, and implementation steps. Write each
fact once. Return only the clickable artifact path.

Keep the inventory while planning or execution needs it. If this skill is the final consumer, a
non-empty transient artifact set exists, no earlier disposition prompt occurred, and no downstream
step needs any transient artifact or sidecar created or consumed by the active work, ask once about
the complete transient set: Delete, Leave, or Promote. Repository-native and other durable inputs
never enter disposition. Recommend from state, explain each option in one sentence, include every
transient path, and include `Other`. Never choose for the human.
