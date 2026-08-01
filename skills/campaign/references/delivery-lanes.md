# Delivery lanes

## Ledger

1. Use one project-native issue or issue-backed epic. Record done, repositories, dependency order,
   risk classes, branch integration, review policy, merge mode, and ownership. Milestones only group.
2. Prove parallel boundaries. Shared contracts, generated surfaces, unknown scope, and overlapping
   files force sequencing.

## Pool

1. Size one global lane budget from proven independent width, machine capacity, CI throughput, and
   reviewer capacity. Partition fixed pools by repository.
2. Create each worktree once at a stable path. Keep one active branch and one implementation owner
   per lane. Repartition only when dependency topology changes; retire one lane before creating its
   replacement.
3. Reuse a lane only after tracked and untracked state is empty. Fetch, detach at the accepted remote
   base, then create the next branch.
4. Reuse ignored dependencies only while lockfile and toolchain identities match. Refresh on change.
   Force-clean nothing.
5. One branch and worktree have one writer.

## Dispatch

1. Schedule only dependency-ready, write-disjoint work.
2. Give the owner objective, ledger, repository, lane, branch, scope, exclusions, dependencies,
   acceptance conditions, checks, and pull-request policy.
3. Reassign an abandoned lane only after the prior owner stops and the branch head remains expected.
   Hand over lane, branch, pull request, head, checks, unresolved comments, and blocker.
4. The owner edits, tests, commits, pushes, and repairs review. The orchestrator tracks dependencies,
   evidence, CI, and ownership; it never hijacks the owner's branch.
5. Record blockers on the pull request or ledger. Resolve, replace the owner, or stop dependent work.
