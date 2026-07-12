---
name: triple-check
type: agent-guide
description: Run exactly three fresh, target-derived, top-tier inspection passes for narrow depth. ALWAYS apply when asked to triple-check, deeply inspect, or obtain three independent high-end checks of code, a diff, artifact, plan, or system. Default to a fixed read-only snapshot with peer reports hidden. Refine only when explicitly requested; reviewers never edit and the orchestrator applies evidence-backed fixes between fresh passes.
---

# Triple-check

`DISRESPEC-SPINE: One fact once. No filler, repeated source material, empty sections, or chat restatement; after successful creation return only clickable artifact links, except for blockers, failed creation, incomplete verification, or irreversible-action confirmation.`

## Artifact placement

Place the file under `~/.agents/artifacts/<workspace>/`, resolving `~` to the absolute
home path and deriving `<workspace>` from the repository or working-directory basename. Keep it
out of the repository and carry its absolute path forward. If the workspace name or target path
conflicts with unrelated work, stop for a structured human choice; never overwrite. If the root is
unwritable, offer grant access and retry, another agent-neutral user directory, or cancel. Never
fall back to vendor storage, the repository, or a temporary directory.

## Contract

- Exactly three fresh passes.
- Each stance is derived from the target and materially distinct.
- Each pass uses a top-tier model adequate for the target.
- Default mode is `inspect`; `refine` requires explicit request.
- Produce one `type: inspection`, `method: triple-check` artifact.

## Method

1. Pin the target state and derive three deep stances from its highest-consequence risks.
2. Dispatch pass one with no peer report.
3. Inspect mode: keep the same snapshot and hide every peer report through pass three.
4. Refine mode: verify pass findings; the orchestrator applies accepted fixes, pins the new state,
   and dispatches the next fresh pass without prior reviewer prose.
5. Complete all three passes even if an earlier pass is quiet.
6. Reconcile by evidence. Preserve disagreements and evidence gaps. Never issue a ship verdict.
