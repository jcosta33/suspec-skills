---
name: sus-task
description: Split a ready Suspec spec into collision-proof task packets. Use when spec-governed work must be divided into independent parallel slices, repository or platform contexts, or dispatchable transformation waves. Do not use for unspecced work or work with no dispatch boundary.
---

# Sus Task

No independence, no split.

## Method

Enter on explicit split request or after the human selects task packets for a Suspec artifact
workflow.

Require exactly `status: ready`. Read the spec and every named source. A change plan may add wave
context; it cannot replace the spec. Any blocking decision kills dispatch.

Ask required questions through the native picker, or numbered choices plus `Other`. Put the
recommendation first; offer three genuine options, two if binary; give each one plain reason and
cost.

Use task packets only for:

- independently dispatchable parallel slices;
- one requirement implemented independently per platform or repository; or
- separately dispatchable transformation waves from a change plan that supplements the spec.

Size proves nothing. One source and one implementer earn no packet.

1. Enumerate every scoped requirement. When a change plan supplements the spec, enumerate its
   preservation guarantees and waves.
2. Assign each requirement to exactly one packet. A platform/repository carve-out may repeat one ID
   only when each context independently verifies the whole obligation. Assign each preservation
   guarantee to every packet whose work could violate it.
3. Copy each assigned requirement block and its `Verify with:` line verbatim into its
   packet. Name the source spec and include its ID
   in `source`; add a change-plan ID only when used. Keep preservation IDs in `## Preservation scope`,
   never frontmatter `scope`. Stamp the source state identifier. Re-cut after a material source change.
4. Give each packet one concern, exact scope, frozen boundaries, affected write areas, the strongest
   available acceptance oracle, one Verify entry per requirement and preservation guarantee, and
   agent instructions. For defective behavior, include the original-state failing command, expected
   reason, state, and decisive output. `## Verify` is the only home for final pasted evidence;
   `## Run summary` cites those entries without duplicating output.
5. Compare every pair of affected areas. Unknown scope conflicts with everything.
6. Parallelize only when neither packet depends on the other, reads or writes the other's files,
   shares a public interface/schema/generated surface, or touches shared build/CI configuration.
7. Sequence interface-defining work first. Put the complete run order and this packet's dependency
   position in every packet.
8. Prove coverage both ways: no obligation missing, duplicated, weakened, or invented.

Force material ambiguity from every missing decision into explicit human selection. Block the split
until selection.

## Artifact

Resolve `~/.agents/artifacts/<workspace>/` to an absolute path; derive `<workspace>` from the
repository or working-directory basename. Write there with linked sidecars beside their governing
packet. On collision or ambiguous workspace, present human-readable name choices. On a blocked
write, offer grant and retry, another agent-neutral user directory, or cancel. Never overwrite or
fall back to a repository, vendor directory, or temporary path.

Write local source references relative to the artifact. Use absolute paths only for runtime handoff.

Instantiate [`references/task-packet.md`](./references/task-packet.md) once per slice. Carry every
artifact by absolute path.

## Output

Before handoff, cut repetition, softness, ceremony, and structural bloat without changing contracts,
identifiers, verbatim source text, evidence, or behavior. Rerun applicable checks. Return only
clickable Markdown links for every task and sidecar, with compact `~/.agents/...` labels and fully
expanded absolute destinations. Explain only a blocker, failed creation, incomplete verification,
or irreversible-action confirmation.

## Close

Once fully actioned and no downstream step needs them, require one human disposition for the
artifacts and sidecars: Delete, Leave, or Promote. Promote moves transient material into
project-owned permanence. Delete every selected path and verify absence; survivors block close.
