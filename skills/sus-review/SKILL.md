---
name: sus-review
description: Review finished work against its governing Suspec spec or task. Use when checking completed work, diffs, branches, or pull requests for conformance. Do not use for present-state audits without a governing artifact or broad adversarial review.
---

# Sus Review

Evidence judges conformance. Humans judge acceptance.

## Method

- Freeze target state and absolute governing paths.
- Read the companion spec first. Require exactly `status: ready`. A task narrows IDs; it cannot
  replace the spec.
- With a task, read its `scope` and review exactly those source-spec IDs. Without a task, review
  every source-spec requirement.
- Reject self-review. Freeze the target.
- A task opened explicitly as the clean-review fallback, with no implementation history or prior
  review prose, is the independent reviewer: execute here.
  Otherwise, before creating the artifact, prove the harness can dispatch one fresh independent
  reviewer. If it cannot, stop for human selection. Contaminated context is not independence.
## Artifact

Resolve `~/.agents/artifacts/<workspace>/` to an absolute path. Derive `<workspace>` from the
repository or working-directory basename. Write there; keep linked sidecars beside it. A collision
or ambiguous workspace requires human-readable name choices. A blocked write requires: grant access
and retry, choose another agent-neutral user directory, or cancel. Never overwrite or fall back to a
repository, vendor directory, or temporary path.

Start one artifact with this minimal frontmatter:

```yaml
---
type: review
id: REVIEW-{{slug}}
spec: {{spec ID}}
reviewer: {{reviewer}}
decision: pending
---
```

Add `task` or `pr` only when present. Put every governing artifact's absolute path and the frozen
target state in the body.

## Verify

1. Enumerate every scoped requirement and preservation guarantee.
2. Prove completed implementation against direct evidence. Rerun every applicable verification after
   the final relevant change. Worker evidence is a claim.
3. Read the diff and its callers. Check behavior, scope, preservation, trust boundaries, and
   unrequested changes.
4. Use this exact coverage shape, with exactly one data row per scoped ID:

   ```markdown
   ## Requirement coverage

   | ID | Assessment | Evidence |
   | --- | --- | --- |
   | {{scoped ID}} | {{assessment}} | {{exact evidence}} |
   ```

   Keep this as one contiguous GFM table: the delimiter immediately follows the header, every row
   stays together, and structured `verify` blocks follow all rows.

   - `Supported`: decisive current evidence proves it.
   - `Unsupported`: evidence disproves it.
   - `Unverified`: evidence is absent, stale, indirect, or cannot run.
   - `Blocked`: an external condition prevents assessment.
   When a governing change plan applies, add a contiguous `## Change-plan coverage` table with the
   same columns and one row per applicable preservation guarantee.
5. Add sections only for unique facts.
6. Keep short raw output once. Move dominating output to an adjacent evidence receipt with stable
   anchors, command, working directory, state identifier, exit status, and untouched output. Link
   each used anchor from its coverage row.

Unrelated green suites, author confidence, and votes prove nothing. Emit no ship verdict.

## Decision

After assessment, present a state-aware native picker:

- All rows Supported: Accept, Request changes, or Defer.
- Unsupported or Unverified rows and no Blocked row: Accept with named waivers, Request changes, or
  Defer. Never offer plain Accept.
- Any Blocked row: Request changes or Defer. Never offer either acceptance option.
- Any non-Supported preservation row: Request changes or Defer. Preservation cannot be waived.
- Any other unresolved material finding: Accept with a named risk decision, Request changes, or
  Defer. Never offer plain Accept. Preservation findings never enter this branch.

If the picker is unavailable, leave `decision: pending` and report the capability blocker.
Only human selection changes `decision` to `accepted`, `changes-requested`, or `deferred`.
Add `waivers` only when the human explicitly accepts while waiving named unsupported or unverified
IDs. `waivers` is an optional string list such as `waivers: [AC-002]`; never write it as a scalar.
Ordinary acceptance and pending reviews omit `waivers`.
Before acceptance, fix and verify every material finding or record its owner, explicit accepted-risk
decision, reason, and follow-up in the project's decision channel. Until then, repeat it under `Open
decisions`. If no project-owned decision channel exists, acceptance with risk stays blocked.
Non-material notes may expire.

## Output

Before handoff, compress and harden the Markdown: remove repetition, softness, ceremony, and
structural bloat; write each fact once. Hand off absolute paths for the review and every sidecar.

## Close

After the artifact is fully actioned and no downstream step needs it, require one human disposition
for it and its sidecars: Delete, Leave, or Promote. If Promote is selected, move the transient
working material into project-owned permanence.
Delete selection confirms removal. Verify every selected path is absent; failure blocks close and
reports survivors.
