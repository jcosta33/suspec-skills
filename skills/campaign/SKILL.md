---
name: campaign
description: Orchestrate broad software delivery across reusable worktree lanes, delegated implementation, multiple pull requests, adaptive model routing, and independent review. Use when one delivery goal contains multiple dependency-aware, write-disjoint implementation streams across one or more repositories. Do not use for planning or task decomposition alone, contained or sequential implementation, a single pull request, or review of existing work.
---

# Campaign

## Method

### Frame

1. Read project governance, governing requirements, dependency state, branch protection, CI, and
   release constraints.
2. Create or select one project-native issue or issue-backed epic as the campaign ledger. Define
   done, repositories, dependency order, risk classes, branch integration policy, review policy,
   and ownership there. Use milestones only as grouping metadata.
3. Prove the parallel boundaries. Shared contracts, generated surfaces, unknown scope, or overlapping
   files force sequencing.
4. Force material ambiguity into explicit human selection before dependent work starts. Present at
   least three genuine options, recommendation first, with one plain sentence explaining each cost.

### Allocate

1. Size one global lane budget from proven independent width, machine capacity, CI throughput, and
   reviewer capacity; partition it into fixed per-repository pools. A ten-lane campaign has ten total
   worktrees.
2. Create each worktree once at a stable path. Keep one active branch and one implementation owner
   per lane. Repartition only when dependency topology changes; moving capacity between repositories
   retires one lane and creates another.
3. Reuse the worktree after each pull request. Require empty tracked and untracked status; fetch;
   detach at the accepted remote-base commit; then create the next branch. Keep ignored dependencies.
   Force-clean nothing.
4. A branch or worktree has one writer. Never dispatch concurrent owners into either.

### Dispatch

1. Schedule only dependency-ready, write-disjoint work.
2. Give every implementation owner the objective, ledger link, repository, lane, branch, exact
   scope, exclusions, dependencies, acceptance conditions, required checks, and pull-request policy.
3. Open a draft pull request as soon as reviewable code exists. Link the campaign ledger and
   dependencies. Keep scope, commits, verification, and blockers current. Mark it ready only after
   implementation checks pass.
4. Reassign an abandoned lane only after the harness confirms the prior owner stopped and the branch
   head remains expected. Hand the replacement the lane, branch, pull request, head, checks,
   unresolved comments, and exact blocker.

### Route

1. Run deterministic checks first and after every relevant edit.
2. Use the cheapest model proven adequate by repository evaluation, comparable accepted work, or a
   bounded task with a deterministic oracle. Use the standard tier when adequacy is unknown. Reserve
   stronger agents for architecture, security, migrations, conflicting evidence, cross-repository
   judgment, and disputed severe findings.
3. Escalate the blocked decision, not the whole task. Return to the cheaper tier after resolution.
4. Route from scope, risk, reversibility, check results, repeated failure, and reviewer disagreement.
   Ignore model self-confidence.

### Build

1. The implementation owner edits, tests, commits, pushes, and answers review in its lane.
2. The campaign orchestrator tracks dependencies, evidence, CI, and ownership. It does not hijack an
   owner's branch to make review fixes.
3. A blocked owner records the exact blocker on the pull request or campaign ledger. Resolve the
   decision, replace the owner, or stop the dependent work.

### Review

1. After implementation checks pass, run exhaustive multi-angle review and sequential repair across
   every target-justified stance on the pull request.
2. Derive the complete materially distinct stance pool from the change, requirements, trust
   boundaries, failure modes, users, and operating conditions. Use no numeric floor or filler.
3. Dispatch one fresh reviewer at a time against the current pull-request head. Give it the code,
   diff, one stance, and no pull-request conversation or prior reviewer prose.
4. Fact-check every finding as supported, refuted, a human decision, unverified, or blocked. Record
   one initial repository-native review event per stance with the stance and reviewed head SHA. Put
   each supported finding in a resolvable line thread where a line exists or a numbered review-body
   item otherwise. Record a quiet stance or consequential refutation in the same event. An
   unverified or blocked finding stops the stance.
5. Message the implementation owner to fix every supported item in the same lane. The owner pushes
   the repair and replies with proof. The review orchestrator reruns decisive checks, verifies the
   resolution, resolves line threads, and marks review-body items closed. Record a follow-up review
   event referencing the stance and prior reviewed SHA. Human decisions block the pull request until
   selected.
6. Dispatch the next stance only after every item from the current stance is resolved. Review the new
   head, not the superseded snapshot.
7. Finish the full pool. After a productive rotation, rebuild it against the current head. Stop after
   one quiet rotation. At three productive cycles without one, block the pull request and surface the
   remaining risk.

### Merge

1. Record the quiet rotation's reviewed head and base SHAs. Merge in dependency order through a
   protected merge queue or by revalidating both SHAs and the tested merge result immediately before
   an expected-head merge. Required CI, approvals, review rotations, and conversations must pass.
   Any head or base drift resets checks and review.
2. The implementation owner updates its dependent branch after prerequisites merge using project
   policy. Cross-repository dependencies remain explicit pull-request blockers. Rerun affected checks
   and review.
3. Recycle the lane only after the pull request merges or closes and the worktree is clean.
4. With explicit human or project-policy authorization, delete merged local and remote branches and
   remove clean worktrees without force once, at campaign shutdown.

### Close

1. Finish only when every campaign item is merged, explicitly deferred with an owner and reason, or
   blocked on a named human decision.
2. Reconcile the campaign ledger with pull requests, merge state, verification, deferrals, and
   remaining risk.
3. Preserve only verified lessons whose loss would force rediscovery. Link every durable update in
   the campaign ledger.

## Output

Return the campaign ledger and pull-request links, merged/deferred/blocked state, unresolved human
decisions, residual lanes or branches, durable updates, and decisive final verification.

## Boundaries

The campaign orchestrator owns scheduling, routing, evidence, reviewer dispatch, and resolution
checks. Implementation owners own code and review repairs. Humans and project policy own material
decisions, irreversible actions, acceptance, and merge authority.

This method requires isolated worktrees, fresh reviewer dispatch, repository-native pull-request
discussion, and deterministic checks. Name a missing capability and stop; invisible substitutes
destroy the audit trail.
