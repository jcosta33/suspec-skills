---
name: campaign
description: Orchestrate multi-pull-request software delivery across reusable worktree lanes and independent review. Use for one goal with dependency-aware, write-disjoint implementation streams across repositories. Exclude planning-only, contained, sequential, single-pull-request, and review-only work.
---

# Campaign

Project systems own history. Owners own code. The orchestrator owns flow.

1. Read project governance, governing requirements, dependency state, branch protection, CI,
   release constraints, current worktree, and existing native worktrees.
2. Create or select one project-native issue or issue-backed epic as the ledger.
3. Load [Delivery lanes](./references/delivery-lanes.md). Complete its capability preflight before
   allocating a worktree or dispatching implementation. Missing control stops dependent autonomy.
4. Prove write-disjoint, dependency-ready parallelism. Sequence shared contracts, generated
   surfaces, unknown scope, and overlapping files.
5. Exhaust discoverable facts and reversible conventions. If any user response remains required,
   stop dependent work and use the native picker: recommendation first, three genuine options by
   default, two when binary, plain tradeoffs, and `Other`. Without a picker, render numbered choices
   plus `Other`.
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
Implementation owners edit and repair. Project systems enforce delivery transitions. Humans own
material decisions, irreversible actions, acceptance, and merge authority.

Skill instructions are advisory. Project commands provide deterministic local enforcement.
Harness permissions provide isolated authority. Separate worktrees, fresh
reviewers, repository-native pull-request discussion, and deterministic checks remain mandatory.
Implementation on `main` requires project or human authority.
