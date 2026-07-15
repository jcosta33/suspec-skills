---
name: sus-change-plan
description: Plan structural change while preserving behavior. Use when a refactor, rewrite, migration, upgrade, performance change, schema change, or wide architecture cleanup needs a proven baseline and staged transformation. Do not use for direct implementation or net-new feature design.
---

# Sus Change Plan

Unproven preservation is accidental destruction.

## Method

Enter on explicit plan request or after the human selects a Suspec change-plan workflow.

Read project rules, durable decisions, current source, tests, and current-state maps. When wide change
lacks a proven map, map the unfamiliar or change-critical area as durable current state before
planning. Skip only when the change is isolated, the current map is proven, and no
behavior-preservation, staged-cutover, or rollback risk exists.

Resolve reversible conventions. Force material ambiguity into explicit human selection when it
concerns behavior, public contracts, security, cost, authority, or irreversible action. Block
dependent waves until selection.

## Artifact

Resolve `~/.agents/artifacts/<workspace>/` to an absolute path. Derive `<workspace>` from the
repository or working-directory basename. Write there with `type: change-plan` and a unique
`CHANGE-` ID; keep linked sidecars beside it. A collision or ambiguous workspace requires
human-readable name choices. A blocked write requires: grant access and retry, choose another
agent-neutral user directory, or cancel. Never overwrite or fall back to a repository, vendor
directory, or temporary path.

### Shape

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

## Verify

- Demand golden, differential, or property checks that fail on drift. A green suite proves only its
  executed coverage.
- Give every compatibility shim a path, forward target, and mechanical removal condition.
- Count old call sites across source, tests, generated code, dynamic
  dispatch, registries, configuration, and reflection; completion targets zero outside named shims.
- Record every deliberate rewrite delta. Preserve everything else.
- Use one performance protocol before and after: workload, inputs, environment, warmup,
  samples, statistic, target, and regression ceilings.
- Use schema coexistence only when consumers cannot cut over atomically.

If the `suspec` executable is available, run `suspec check <absolute-change-plan-path>`. Otherwise,
verify the frontmatter and required sections, resolve every `preserves` ID against the source spec or
plan guarantees, and require each transformation wave to name verification.

## Output

Before handoff, compress and harden the Markdown without changing its contract, identifiers,
verbatim source text, evidence, or behavior. Remove repetition, softness, ceremony, and structural
bloat; write each fact once. Rerun applicable checks. Hand off absolute paths for the change plan
and every sidecar.

## Close

After the artifact is fully actioned and no downstream step needs it, require one human disposition
for it and its sidecars: Delete, Leave, or Promote. If Promote is selected, move the transient
working material into project-owned permanence.
Delete selection confirms removal. Verify every selected path is absent; failure blocks close and
reports survivors.
