---
name: sus-campaign
description: Write or revise a restartable goal contract for one multi-pull-request delivery campaign. Use when one durable objective needs dependency-aware, write-disjoint streams, a project-native progress ledger, and enforceable delivery gates. Do not use for planning-only, contained, sequential, single-pull-request, or review-only work.
---

# Sus Campaign

Snapshots rot. Goals survive.

## Method

Read project governance, governing requirements, dependency state, delivery commands, branch
protection, release constraints, current worktrees, and the live tracker.

Lock one objective and one verifiable stopping condition. Reject unrelated backlogs.

Select one project-native issue, epic, or equivalent ledger. It owns work items, dependencies,
assignments, pull requests, and status. The campaign points to it; it never mirrors its mutable
state.

Load [Delivery lanes](./references/delivery-lanes.md). Run its operation-scoped authority preflight.
A missing mechanism blocks only the transition it governs.

Load [Model routing](./references/model-routing.md) before assigning model classes. Load
[Pull requests, review, and merge](./references/pull-requests-review-and-merge.md) before declaring
delivery authorities complete.

Prove write-disjoint, dependency-ready parallelism. Sequence shared contracts, generated surfaces,
unknown scope, and overlapping files.

Resolve discoverable facts and reversible conventions. For a material behavior, public contract,
security, cost, authority, waiver, or irreversible choice, use the native picker: recommendation
first, three genuine options by default, two when binary, plain tradeoffs, and `Other`. Keep the
campaign `draft` until every blocking choice is resolved.

Instructions advise. Project commands reject. Isolation removes authority. Claim only what the
mechanism proves. Humans own intent, material decisions, waivers, irreversible authority, and
acceptance. They may delegate execution to a named orchestrator or project mechanism.

## Artifact

Resolve `~/.agents/artifacts/<workspace>/` to an absolute path; derive `<workspace>` from the
repository or working-directory basename. Write there with `type: campaign`, a unique `CAMPAIGN-`
ID, and linked sidecars beside it. On collision or ambiguous workspace, present human-readable name
choices. On a blocked or unwritable destination, offer grant and retry, another agent-neutral user
directory, or cancel. Never overwrite or fall back to a repository, vendor directory, or temporary
path.

Write local source references relative to the artifact. Use absolute paths only for runtime handoff.

Start with:

```yaml
---
type: campaign
id: CAMPAIGN-{{slug}}
status: draft
ledger: {{project-native-url-or-relative-path}}
sources:
  - {{governing-artifact-or-url}}
---
```

Write exactly these required sections:

- **Objective:** one durable outcome.
- **Completion contract:** observable conditions that prove the whole campaign done.
- **Authorities:** governing artifacts, ledger, and owners and mechanisms for every intended
  delivery transition.
- **Operating loop:** reread, reconcile, select, execute, verify, record, repeat.
- **Stops:** completion or named human decisions that block dependent work.

Add `Constraints`, `Non-goals`, or `Workstreams` only when they carry information. Workstreams may
name stable ledger IDs; status stays in the ledger.

Every pickup must run the same loop:

1. Read the campaign and every authority.
2. Reconcile repository, ledger, pull-request, worktree, worker, and verification state from live
   evidence.
3. Repair ledger drift before trusting its status.
4. Select the highest-priority dependency-ready work that fits current capacity and ownership.
5. Execute through project implementation, verification, review, and integration gates.
6. Record durable progress in the project-native ledger.
7. Repeat until the completion contract passes or a named human decision blocks progress.

Put no task-list checkbox, current count, branch SHA, lane occupancy, pull-request snapshot,
session identity, first-run step, or handoff diary in the campaign. Point to the live owner.

Use `status: ready` only when every authority is reachable from the target execution environment,
every blocking choice is resolved, and every intended operation names an honest owner, strength,
mechanism, and failure behavior. A named stop may guard a later unavailable transition without
blocking independent work. A local harness receives the fully expanded absolute campaign path. A
harness without path access receives the same artifact body after its authorities become reachable
there.

## Output

Cut repetition, softness, ceremony, and structural bloat without changing contracts, identifiers,
evidence, or behavior. Rerun applicable checks. Return only clickable Markdown links for the
campaign and every sidecar, with compact `~/.agents/...` labels and fully expanded absolute
destinations. Explain only a blocker, failed creation, incomplete verification, or irreversible
action confirmation.

## Close

Once fully actioned and no downstream step needs it, require one human disposition for the artifact
and its sidecars: Delete, Leave, or Promote. Promote moves transient material into project-owned
permanence. Delete every selected path and verify absence; survivors block close.
