# Delivery lanes

## Capability preflight

Before any lane allocation or worker dispatch, record each capability's owner, class, mechanism, and
negative proof in the project ledger. Advisory prose does not satisfy deterministic local enforcement
or isolated authority. A worker-controlled command that can be bypassed provides neither.

| Capability | Required proof | Class |
| --- | --- | --- |
| Lane ownership | A project command rejects allocation, reuse, release, or cleanup unless path, branch, owner, origin, head, cleanliness, dependency identity, and terminal state match. | Deterministic local |
| Proportionate verification | Project policy maps changed scope and risk to commands and binds their receipts to exact state. | Deterministic local |
| Heavyweight admission | One machine-wide boundary bounds commands, workers, failures, CPU, memory, and concurrency across every lane. | Isolated authority |
| Pull-request shape and size | A project command rejects template violations, bulk output, process narration, and work beyond declared reviewable limits before publication. | Deterministic local |
| Bounded review | Project state freezes review breadth, exact head, comment scope, repair order, and closure before merge. | Deterministic local |
| Exact-state proof | Project receipts bind command, working directory, commit, material environment, exit, and decisive output; stale inputs invalidate them. | Deterministic local |
| Merge admission | Normal workers lack independent merge authority; a project-owned or human actor validates current proof, review, and approval. | Isolated authority |
| Cleanup | A trusted command can remove only campaign-owned, clean, terminal lanes and branches. | Isolated authority |

Run the project's preflight and prove each capability fails when its mechanism is removed or stale.
Hosted status checks are optional; exact-state local command evidence is valid.

If any capability is absent, stop dependent autonomy and present three choices: supply or repair the
control, let a human execute every affected transition, or cancel. Never weaken the class, invent
proof, or fall back silently.

## Ledger

1. Use one project-native issue or issue-backed epic. Record done, repositories, dependency order,
   risk classes, branch integration, review policy, merge mode, and ownership. Milestones only group.
2. Prove parallel boundaries. Shared contracts, generated surfaces, unknown scope, and overlapping
   files force sequencing.

## Pool

1. Inspect the current path, branch, tracked and untracked state, and `git worktree list`. Classify
   every existing lane by path, branch, origin, owner, and state. Never nest or duplicate a suitable
   native lane.
2. Size one global lane budget from proven independent width, machine capacity, CI throughput, and
   reviewer capacity. Partition fixed pools by repository. When cost or count is material, present
   the recommendation and genuine alternatives for human selection.
3. Reuse suitable project or harness lanes. Create each campaign lane once at a stable path. Keep one
   active branch and one implementation owner per lane. Record its provenance in the ledger.
4. Reuse a lane only after tracked and untracked state is empty. Fetch, detach at the accepted remote
   base, then create the next branch.
5. Reuse ignored dependencies only while lockfile and toolchain identities match. Refresh on change.
   Force-clean nothing.
6. One branch and worktree have one writer. Implementation on `main` requires project or human
   authority.

## Dispatch

1. Schedule only dependency-ready, write-disjoint work.
2. Give the owner objective, ledger, repository, lane, branch, scope, exclusions, dependencies,
   acceptance conditions, checks, and pull-request policy.
3. Require only status, changed paths, branch, pull request, head, decisive checks, and blockers in
   the owner's return. No progress diary or recap; the ledger and pull request own history.
4. Reassign an abandoned lane only after the prior owner stops and the branch head remains expected.
   Hand over lane, branch, pull request, head, checks, unresolved comments, and blocker.
5. The owner edits, tests, commits, pushes, and repairs review. The orchestrator tracks dependencies,
   evidence, CI, and ownership; it never hijacks the owner's branch.
6. Record blockers on the pull request or ledger. Resolve, replace the owner, or stop dependent work.
7. Clean only campaign-created lanes, after merge or closure, under project or human authority.
   Preserve dirty, unknown, and externally owned worktrees.
