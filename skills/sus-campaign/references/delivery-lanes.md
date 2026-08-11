# Delivery lanes

## Authority preflight

Map only operations the campaign will use: lane allocation, verification, heavyweight execution,
publication, review, merge, and cleanup. For each, record its owner, strength, mechanism, and failure
behavior in the project ledger.

- **Advisory:** instructions coordinate willing agents. Claim no rejection or containment.
- **Deterministic local:** a project-owned command rejects the invalid transition.
- **Isolated authority:** protected state, resources, or credentials stay outside worker reach.

Match strength to the accepted claim. Drift resistance may remain advisory or deterministic. A
claim that a worker cannot bypass a boundary requires isolation.

Missing authority blocks only the dependent operation. Independent work continues. One named
trusted owner may bootstrap a missing control while parallel dispatch and the guarded transition
remain blocked. State the temporary limit; invent no proof.

Revalidate an operation's authority when its mechanism, owner, relevant repository state, or
harness permissions change. Hosted status checks are optional; project-approved local proof is
valid.

## Ledger

1. Use one project-native issue or issue-backed epic. Record work, repositories, dependencies,
   assignments, pull requests, status, operating authorities, and accepted exceptions. Milestones
   only group.
2. Prove parallel boundaries. Shared contracts, generated surfaces, unknown scope, and overlapping
   files force sequencing.

## Pool

1. Inspect the current path, branch, tracked and untracked state, and `git worktree list`. Classify
   existing lanes by path, branch, owner, origin, and state. Never seize an unknown or active lane.
2. Size capacity from proven independent work, machine limits, verification cost, and reviewer
   capacity. More lanes are not progress.
3. Reuse suitable project or harness lanes. Keep one active branch and one implementation owner per
   lane. Record ownership in the native ledger.
4. Reuse only a clean released lane. Refresh ignored dependencies when lockfile or toolchain identity
   changes. Force-clean nothing.
5. Implementation on `main` requires named project or owner authority.

## Dispatch

1. Schedule only dependency-ready, write-disjoint work.
2. Give the owner objective, ledger, repository, lane, branch, scope, exclusions, dependencies,
   acceptance conditions, checks, and pull-request policy.
3. Require only status, changed paths, branch, pull request, head, decisive checks, and blockers in
   the owner's return. No progress diary or recap.
4. Reassign only after the prior owner stops and the branch head remains expected.
5. The owner edits, tests, commits, pushes, and repairs review. The orchestrator coordinates and
   verifies; it does not hijack another owner's branch.
6. Route heavyweight work through its named resource owner. Without one, keep execution sequential
   and obtain explicit authority before launch.
7. Record blockers in the pull request or ledger.
8. Clean only campaign-owned, clean, terminal lanes through the named cleanup owner or mechanism.
   Preserve dirty, foreign, unknown, shared, and active state.
