---
name: sus-task
description: Cut a ready Suspec spec into collision-proof task packets. ALWAYS apply when asked to split spec-governed work into independent parallel slices, repository or platform contexts, or dispatchable transformation waves. Assign every requirement exactly once, preserve every applicable guarantee, prove write disjointness, and lock dependency order.
---

# Sus Task

No independence, no split.

## Entry

Enter on explicit split request or after the human selects task packets for a Suspec artifact
workflow.

Require exactly `status: ready`. Read the spec and every named source. A change plan may add wave
context; it cannot replace the spec. Any blocking decision kills dispatch.

Use task packets only for:

- independently dispatchable parallel slices;
- one requirement implemented independently per platform or repository; or
- separately dispatchable transformation waves from a change plan that supplements the spec.

Size proves nothing. One source and one implementer earn no packet.

## Place

Resolve `~/.agents/artifacts/<workspace>/` to an absolute path. Derive `<workspace>` from the
repository or working-directory basename. Write there; keep linked sidecars beside their governing
packet. A collision or ambiguous workspace requires human-readable name choices. A blocked write
requires: grant access and retry, choose another agent-neutral user directory, or cancel. Never
overwrite or fall back to a repository, vendor directory, or temporary path.

Instantiate [`references/task-packet.md`](./references/task-packet.md) once per slice. Carry every
artifact by absolute path.

## Cut

1. Enumerate every scoped requirement. When a change plan supplements the spec, enumerate its
   preservation guarantees and waves.
2. Assign each requirement to exactly one packet. A platform/repository carve-out may repeat one ID
   only when each context independently verifies the whole obligation. Assign each preservation
   guarantee to every packet whose work could violate it.
3. Copy each assigned requirement block and its `Verify with:` or `VERIFY BY` line verbatim into its
   packet. Scope may contain `AC-`, `C-`, `I-`, or `IF-` IDs. Name the source spec and include its ID
   in `source`; add a change-plan ID only when used. Keep preservation IDs in `## Preservation scope`,
   never frontmatter `scope`. Stamp the source state identifier. Re-cut after a material source change.
4. Give each packet one concern, exact scope, frozen boundaries, affected write areas,
   one Verify entry per requirement and preservation guarantee, and agent instructions. `## Verify`
   is the only home for pasted evidence;
   `## Run summary` cites those entries without duplicating output.
5. Compare every pair of affected areas. Unknown scope conflicts with everything.
6. Parallelize only when neither packet depends on the other, reads or writes the other's files,
   shares a public interface/schema/generated surface, or touches shared build/CI configuration.
7. Sequence interface-defining work first. Put the complete run order and this packet's dependency
   position in every packet.
8. Prove coverage both ways: no obligation missing, duplicated, weakened, or invented.

Missing decisions block the split. Surface them.

Write each fact once. Hand off absolute paths. After the artifacts are fully actioned and no
downstream step needs them, require one human disposition for them and their sidecars: Delete,
Leave, or Promote.
Delete selection confirms removal. Verify every selected path is absent; failure blocks close and
reports survivors.
