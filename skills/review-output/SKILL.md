---
name: review-output
type: agent-guide
description: >-
  Reconcile finished work against its spec: independently rerun checks, assess every scoped
  requirement as Supported, Unsupported, Unverified, or Blocked, and present the human decision
  picker. ALWAYS apply when reviewing a finished task, diff, or PR against a spec. Never review your
  own implementation, edit the target, issue acceptance, or hide waivers. Skip spec conformance,
  present-state audits, and original implementation.
---

# Review output

`DISRESPEC-SPINE: One fact once. No filler, repeated source material, empty sections, or chat restatement; after successful creation return only clickable artifact links, except for blockers, failed creation, incomplete verification, or irreversible-action confirmation.`

## Artifact placement

Place the file under `~/.agents/artifacts/<workspace>/`, resolving `~` to the absolute
home path and deriving `<workspace>` from the repository or working-directory basename. Keep it
out of the repository and carry its absolute path forward. If the workspace name or target path
conflicts with unrelated work, stop for a structured human choice; never overwrite. If the root is
unwritable, offer grant access and retry, another agent-neutral user directory, or cancel. Never
fall back to vendor storage, the repository, or a temporary directory.

## Method

1. Pin the target state. Read the spec first; a task only scopes requirement IDs.
2. Confirm independence. Refuse review of work you implemented.
3. Rerun every applicable `Verify with:` item. Treat worker evidence as a claim.
4. Read the diff; inspect behavior, scope, preservation guarantees, and trust boundaries.
5. Write one `ID | Assessment | Evidence` row per scoped requirement. Use `Supported`,
   `Unsupported`, `Unverified`, or `Blocked`. Every `Supported` row carries decisive evidence.
6. Add findings, changed files, open decisions, or change-plan coverage only when informative.
7. Leave `decision: pending`. Never write acceptance yourself.
8. Present a state-aware human picker: Accept; Request changes; Defer; or, when applicable,
   Accept with waivers. Recommendation comes first and follows the evidence.
9. Write the selection. Accepted reviews list each waived `Unsupported` or `Unverified` ID under
   `waivers`.
10. Return only the clickable review artifact link.

The checker reports structural facts. It never replaces evidence judgment or human acceptance.
