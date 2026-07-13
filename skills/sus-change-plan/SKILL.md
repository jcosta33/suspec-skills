---
name: sus-change-plan
description: Write a safe structural change plan from evidenced current state to an explicit target. ALWAYS apply when planning a refactor, rewrite, migration, upgrade, performance change, schema change, or wide architecture cleanup. Enumerate preserved behavior, define green transformation waves, and set cutover and rollback conditions. Never hide behind "no behavior change," invent the baseline, or implement the plan.
---

# Sus Change Plan

Structural change without preservation proof is a rewrite by accident.

Ordinary conversation and direct action create no change plan. Write one only when requested or
required as a live workflow input.

## Entry

Read project instructions, durable decisions, current source, tests, and any current-state map. If a
wide change lacks an evidenced map, reconstruct it before planning. Do not create a plan for small
cleanup, an obvious fix, or ordinary feature work.

Investigate facts before asking. Decide reversible convention-bound details. Stop on material
behavior, public contracts, security tradeoffs, costly choices, conflicting authority, or
irreversible actions. Use the native picker: three genuine options by default, two when binary,
recommendation first, one-sentence tradeoff each, automatic `Other`. Ask dependent choices
sequentially. A deferred choice blocks dependent waves.

## Place

Resolve `~/.agents/artifacts/<workspace>/` to an absolute path, deriving `<workspace>` from the
repository or working-directory basename. Write one artifact with frontmatter `type: change-plan`
and a unique `id` using the `CHANGE-` prefix under that resolved directory. Never write into the
repository, vendor storage, or an OS temporary directory. Never overwrite unrelated work. Stop with
structured choices on collision or blocked writes.

## Shape

Write only these load-bearing sections:

1. **Baseline:** current state with direct evidence and any map used.
2. **Target:** final structure, deliberate behavior changes, and what remains unchanged.
3. **Preservation guarantees:** `ID | Behavior | Verify with`. Never write "no behavior change."
4. **Transformation waves:** smallest ordered changes that each leave build and tests green; each
   names affected surfaces, verification, and rollback point.
5. **Cutover / rollback:** observable entry, completion, abort, and restoration conditions.
6. **Task split:** dispatchable wave ownership and dependencies when needed; otherwise `None`.

Use frontmatter `kind` to name the transformation. Reuse governing requirement IDs under
`preserves`; mint plan-local `PG-NNN` only for preserved behavior with no requirement ID.

## Hard Rules

- Prefer golden, differential, or property checks that would fail on drift. A green suite alone is
  insufficient unless its coverage is explicitly proven adequate.
- Every compatibility shim needs its path, forward target, and mechanically checkable removal
  condition before introduction.
- Migration and upgrade plans count old call sites across source, tests, generated code, dynamic
  dispatch, registries, configuration, and reflection; completion targets zero outside named shims.
- Rewrite plans record every deliberate behavior delta. Anything absent from the delta is preserved.
- Performance plans use one protocol before and after: workload, inputs, environment, warmup,
  samples, statistic, target, and regression ceilings.
- Schema plans use coexistence waves only when consumers cannot cut over atomically.

Run the deterministic artifact checker when available. Write every fact once. Return only the
clickable artifact path.

The plan remains live through execution and review. After the full workflow is actioned and no downstream step needs it,
ask once about the complete plan-and-sidecar set: Delete, Leave, or
Promote. Recommend from state, explain each option in one sentence, include the complete path set,
and include `Other`. Never choose for the human.
