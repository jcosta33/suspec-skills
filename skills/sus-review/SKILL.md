---
name: sus-review
description: Reconcile finished work against a Suspec spec or scoped task. ALWAYS apply when asked to review completed work, a diff, branch, or pull request against its governing requirements. Use an independent reviewer, rerun verification, assess every scoped ID as Supported, Unsupported, Unverified, or Blocked, and capture the human decision. Never review your own implementation, edit the target, hide waivers, or issue acceptance.
---

# Sus Review

Evidence decides assessment. The human decides acceptance.

Every choice uses the native picker with automatic `Other`. Without one, render the same numbered
options plus `Other`.
Never ask a bare question.

Ordinary conversation and direct action create no review. Write one only when requested or required
as a live workflow input.

## Contract

- Pin the target state and governing artifact paths.
- Read the spec at its explicit companion path first. Require exactly `status: ready`; a missing or
  different status blocks review before artifact creation. A task packet narrows IDs; it never
  replaces the spec.
- Refuse review of work you implemented.
- Keep the target read-only.
- Before creating the artifact, prove the harness can dispatch one fresh independent reviewer
  context with no implementation history or prior review prose. If it cannot, stop with structured
  choices: enable fresh dispatch and retry; run the review in a separate clean task and return it;
  cancel. Recommend the best available option, explain each in one sentence, and include `Other`.
  Never simulate independence in the current context.
- Start one artifact with this minimal frontmatter:

  ```yaml
  ---
  type: review
  id: REVIEW-{{slug}}
  reviewer: {{reviewer}}
  decision: pending
  ---
  ```

  Add `task` or `pr` only when that locator exists. Never put `spec` or `target` in frontmatter;
  record the explicit companion spec path and pinned target state in the body.

## Place

Resolve `~/.agents/artifacts/<workspace>/` to an absolute path, deriving `<workspace>` from the
repository or working-directory basename. Write under that resolved directory. Never write into the
repository, vendor storage, or an OS temporary directory. Never overwrite unrelated work. Stop with
structured choices on a collision or blocked write.

## Assess

1. Enumerate every scoped requirement and preservation guarantee.
2. Rerun every applicable verification item after the final relevant change. Treat worker evidence
   as a claim, not proof.
3. Read the diff and its callers. Check behavior, scope, preservation, trust boundaries, and
   unrequested changes.
4. Use this exact coverage shape, with exactly one data row per scoped ID:

   ```markdown
   ## Requirement coverage

   | ID | Assessment | Evidence |
   | --- | --- | --- |
   | {{scoped ID}} | {{assessment}} | {{exact evidence}} |
   ```

   - `Supported`: decisive current evidence proves it.
   - `Unsupported`: evidence disproves it.
   - `Unverified`: evidence is absent, stale, indirect, or cannot run.
   - `Blocked`: an external condition prevents assessment.
5. Add findings, changed files, open decisions, or plan coverage only when they carry unique facts.
6. Keep short raw output once. Move dominating output to an adjacent evidence receipt with stable
   anchors, command, working directory, state identifier, exit status, and untouched output.

Never infer support from a green unrelated suite, author confidence, or majority agreement. Never
write a ship verdict.

## Decision

After assessment, present a state-aware native picker. Use Accept, Request changes, and Defer; add
Accept with waivers only when unsupported or unverified IDs exist. Put the evidence-backed
recommendation first, explain each option in one sentence, and rely on automatic `Other`.

Only the human selection changes `decision` to `accepted`, `changes-requested`, or `deferred`.
Add `waivers` only when the human explicitly accepts while waiving named unsupported or unverified
IDs. `waivers` is an optional string list such as `waivers: [AC-002]`; never write it as a scalar.
Ordinary acceptance and every pending review omit `waivers`.
Return only the clickable review path after recording the choice.

The review remains live while requested changes or acceptance work continues. If this skill is the
final consumer, a non-empty transient artifact set exists, no earlier disposition prompt occurred,
and no downstream step needs any transient artifact or sidecar created or consumed by the active
work, ask once about the complete transient set: Delete, Leave, or Promote. Repository-native and
other durable inputs never enter disposition. Recommend from state, explain each option in one
sentence, include every transient path, and include `Other`. Never choose for the human.
