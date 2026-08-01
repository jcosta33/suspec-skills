---
name: campaign
description: Orchestrate multi-pull-request software delivery across reusable worktree lanes and independent review. Use for one goal with dependency-aware, write-disjoint implementation streams across repositories. Exclude planning-only, contained, sequential, single-pull-request, and review-only work.
---

# Campaign

Project systems own history. Owners own code. The orchestrator owns flow.

1. Read project governance, governing requirements, dependency state, branch protection, CI, and
   release constraints.
2. Create or select one project-native issue or issue-backed epic as the ledger.
3. Prove write-disjoint, dependency-ready parallelism. Sequence shared contracts, generated
   surfaces, unknown scope, and overlapping files.
4. Exhaust discoverable facts and reversible conventions. If any agent-originated question remains,
   require explicit human selection before dependent work.
5. Before allocating worktrees or dispatching implementation, load
   [Delivery lanes](./references/delivery-lanes.md).
6. Before selecting a model, load [Model routing](./references/model-routing.md).
7. Before opening the first pull request, load
   [Pull requests, review, and merge](./references/pull-requests-review-and-merge.md).
8. Finish only when every item is merged, explicitly deferred with owner and reason, or blocked on a
   named human decision.
9. Reconcile the ledger with pull requests, merged SHAs, verification, deferrals, remaining risk,
   residual lanes, and branches.
10. Preserve only verified lessons whose loss would force rediscovery. Link each durable update in
    the ledger.

## Output

Return ledger and pull-request links, merged, deferred, and blocked state, unresolved human
decisions, residual lanes or branches, durable updates, and decisive acceptance proof against every
merged SHA.

## Authority

The orchestrator schedules, routes, tracks evidence, dispatches reviewers, and verifies resolution.
Implementation owners edit and repair. Humans and project policy own material decisions,
irreversible actions, acceptance, and merge authority.

Separate worktrees, fresh reviewers, repository-native pull-request discussion, and deterministic
checks are mandatory. Missing capability stops the campaign.
