---
name: sus-change-plan
description: Plan structural change without losing behavior. ALWAYS apply to refactors, rewrites, migrations, upgrades, performance changes, schema changes, and wide architecture cleanup. Prove the baseline, enumerate preservation, cut green waves, and lock cutover and rollback. Reject vague "no behavior change" claims.
---

# Sus Change Plan

Unproven preservation is accidental destruction.

## Entry

Read project rules, durable decisions, current source, tests, and current-state maps. Reconstruct a
missing map before wide change. Small cleanup, obvious fixes, and ordinary features earn no plan.

Resolve reversible conventions. Ambiguity in behavior, public contracts, security, cost, authority,
or irreversible action blocks dependent waves.

## Place

Resolve `~/.agents/artifacts/<workspace>/` to an absolute path. Derive `<workspace>` from the
repository or working-directory basename. Write there with `type: change-plan` and a unique
`CHANGE-` ID. A collision, ambiguous workspace, or blocked write requires human selection.
Repository, vendor, and OS temporary paths are invalid.

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

Write only load-bearing sections:

1. **Baseline:** current state, direct evidence, maps used.
2. **Target:** final structure, deliberate behavior changes, preserved behavior.
3. **Preservation guarantees:** `ID | Behavior | Verify with`.
4. **Transformation waves:** smallest ordered changes that leave build and tests green; each
   names affected surfaces, verification, and rollback point.
5. **Cutover / rollback:** observable entry, completion, abort, and restoration conditions.
6. **Task split:** dispatchable ownership and dependencies, or `None`.

Use frontmatter `kind` to name the transformation. Reuse full governing requirement refs under
`preserves`; mint plan-local `PG-NNN` only for preserved behavior with no requirement ID.

## Hard Rules

- Demand golden, differential, or property checks that fail on drift. A green suite proves only its
  executed coverage.
- Give every compatibility shim a path, forward target, and mechanical removal condition.
- Count old call sites across source, tests, generated code, dynamic
  dispatch, registries, configuration, and reflection; completion targets zero outside named shims.
- Record every deliberate rewrite delta. Preserve everything else.
- Use one performance protocol before and after: workload, inputs, environment, warmup,
  samples, statistic, target, and regression ceilings.
- Use schema coexistence only when consumers cannot cut over atomically.

Run the deterministic artifact checker when available. Write each fact once. Hand off the absolute
path. After the artifact is fully actioned and no downstream step needs it, require one human
disposition for it and its sidecars: Delete, Leave, or Promote.
