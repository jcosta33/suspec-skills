---
name: sus-change-plan
description: Write a safe structural change plan from evidenced current state to an explicit target. ALWAYS apply when planning a refactor, rewrite, migration, upgrade, performance change, schema change, or wide architecture cleanup. Enumerate preserved behavior, define green transformation waves, and set cutover and rollback conditions. Never hide behind "no behavior change," invent the baseline, or implement the plan.
---

# Sus Change Plan

Structural change without preservation proof is a rewrite by accident.

Investigate discoverable facts before asking. Every material choice uses the native picker:
recommendation first, three genuine options by default or two when binary, one-sentence tradeoffs,
and automatic `Other`. Without a native picker, render the same numbered options plus `Other`.
Never ask a bare question. Batch only independent choices; ask dependent choices sequentially.

Ordinary conversation and direct action create no change plan. Write one only when requested or
required as a live workflow input.

## Entry

Read project instructions, durable decisions, current source, tests, and any current-state map. If a
wide change lacks an evidenced map, reconstruct it before planning. Do not create a plan for small
cleanup, an obvious fix, or ordinary feature work.

Decide reversible convention-bound details. Stop for a material choice on behavior, public
contracts, security tradeoffs, costly choices, conflicting authority, or irreversible actions. A
deferred choice blocks dependent waves.

## Place

Resolve `~/.agents/artifacts/<workspace>/` to an absolute path, deriving `<workspace>` from the
repository or working-directory basename. Write one artifact with frontmatter `type: change-plan`
and a unique `id` using the `CHANGE-` prefix under that resolved directory. Never write into the
repository, vendor storage, or an OS temporary directory. Never overwrite unrelated work. Stop with
structured choices on collision or blocked writes.

## Shape

Use this minimal frontmatter shape:

```yaml
---
type: change-plan
id: CHANGE-{{slug}}
kind: refactor
preserves:
  - SPEC-feature#AC-001
  - PG-001
---
```

`preserves` is always a list. Use the full `SPEC-id#AC-NNN` for a governing requirement and
`PG-NNN` for a plan-local guarantee.

Write only these load-bearing sections:

1. **Baseline:** current state with direct evidence and any map used.
2. **Target:** final structure, deliberate behavior changes, and what remains unchanged.
3. **Preservation guarantees:** `ID | Behavior | Verify with`. Never write "no behavior change."
4. **Transformation waves:** smallest ordered changes that each leave build and tests green; each
   names affected surfaces, verification, and rollback point.
5. **Cutover / rollback:** observable entry, completion, abort, and restoration conditions.
6. **Task split:** dispatchable wave ownership and dependencies when needed; otherwise `None`.

Use frontmatter `kind` to name the transformation. Reuse full governing requirement refs under
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

Run the deterministic artifact checker when available. Write every fact once. When a downstream
consumer remains, return only the clickable absolute artifact path. At true lifecycle close, skip
the path-only handoff and issue the disposition choice instead.

The plan remains live through execution and review. If this skill is the final consumer, a
non-empty transient artifact set exists, no earlier disposition prompt occurred, and no downstream
step needs any transient artifact or sidecar created or consumed by the active work, ask once about
the complete transient set: Delete, Leave, or Promote. Repository-native and other durable inputs
never enter disposition. Include every transient path. Never choose for the human.
