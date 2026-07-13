---
name: sus-task
description: Split a governing spec whose status is exactly ready into self-contained Suspec task packets that cannot collide. ALWAYS apply when ready spec-governed work has independently dispatchable parallel slices, repository/platform contexts, or sequenced transformation waves. Map every scoped spec obligation exactly once, prove write disjointness before parallelizing, and record dependency order. A change plan may add wave context but never replace the spec. Never split for size alone, invent requirements, or dispatch any other spec status or a blocked decision.
---

# Sus Task

Most work needs no packet. Split only when dispatch buys real independence.

Investigate discoverable facts before asking. Every material choice uses the native picker:
recommendation first, three genuine options by default or two when binary, one-sentence tradeoffs,
and automatic `Other`. Without a native picker, render the same numbered options plus `Other`.
Never ask a bare question. Batch only independent choices; ask dependent choices sequentially.

Ordinary conversation and direct action create no task packet. Write one only when requested or
required as a live workflow input.

## Entry

Before dispatch, require the governing spec frontmatter to contain exactly `status: ready`. Any
other or missing status blocks dispatch. Read the spec and every source it names. A change plan may
supply additional source and wave context, but it never replaces the spec. Do not cut a packet from
an unresolved blocking decision.

Use task packets only for:

- independently dispatchable parallel slices;
- one requirement implemented independently per platform or repository; or
- separately dispatchable transformation waves from a change plan that supplements the spec.

Size alone proves nothing. One source and one implementer need no packet.

## Place

Resolve `~/.agents/artifacts/<workspace>/` to an absolute path, deriving `<workspace>` from the
repository or working-directory basename. Write every packet under that resolved directory. Never
write into the repository, vendor storage, or an OS temporary directory. Never overwrite unrelated
work. Stop with structured choices on workspace or filename collision. On blocked writes offer:
grant access and retry; choose another agent-neutral user directory; cancel.

Instantiate [`references/task-packet.md`](./references/task-packet.md) once per slice. Carry every
artifact by absolute path.

## Cut

1. List every scoped spec requirement. When a change plan supplements the spec, also list its
   preservation guarantees and waves.
2. Assign each obligation to exactly one packet. A platform/repository carve-out may repeat one ID
   only when each context independently verifies the whole obligation.
3. Copy each assigned requirement block and its `Verify with:` or `VERIFY BY` line verbatim into its
   packet. Scope may contain `AC-`, `C-`, `I-`, or `IF-` IDs. Name the source spec and include its ID
   in `source`; add a change-plan ID only when used. Stamp the source state identifier. Re-cut after
   a material source change.
4. Give each packet one concern, explicit scope, do-not-change boundaries, affected write areas,
   verification, and agent instructions. `## Verify` is the only home for pasted evidence;
   `## Run summary` cites those entries without duplicating output.
5. Compare every pair of affected areas. Unknown scope conflicts with everything.
6. Parallelize only when neither task depends on the other, writes or reads the other's files,
   shares a public interface/schema/generated surface, or touches shared build/CI configuration.
7. Sequence interface-defining work first. Put the complete run order and this packet's dependency
   position in every packet. Create no separate run-order artifact.
8. Review coverage both ways: no source obligation uncovered, duplicated, weakened, or invented.

If the split exposes a missing decision after investigation, stop for that material choice. Never
bury the choice in a packet.

Write each fact once. While implementation or review still needs the packets, return only their
clickable absolute paths. At true lifecycle close, skip the path-only handoff and issue the
disposition choice instead. If this skill is the final consumer, a non-empty
transient artifact set exists, no earlier disposition prompt occurred, and no downstream step needs
any transient artifact or sidecar created or consumed by the active work, ask once about the
complete transient set: Delete, Leave, or Promote. Repository-native and other durable inputs never
enter disposition. Include every transient path. Never choose for the human.
