---
name: sus-review
description: Put finished work on trial against its governing Suspec spec or task. ALWAYS apply to conformance review of completed work, diffs, branches, and pull requests. Use an independent reviewer, rerun proof, assess every scoped ID, expose waivers, and capture the human decision. Authors cannot review themselves or grant acceptance.
---

# Sus Review

Evidence judges conformance. Humans judge acceptance.

## Contract

- Freeze target state and governing paths.
- Read the companion spec first. Require exactly `status: ready`. A task narrows IDs; it cannot
  replace the spec.
- Reject self-review. Freeze the target.
- A task opened explicitly as the clean-review fallback, with no implementation history or prior
  review prose, is the independent reviewer: execute here.
  Otherwise, before creating the artifact, prove the harness can dispatch one fresh independent
  reviewer. If it cannot, stop for human selection. Contaminated context is not independence.
- Start one artifact with this minimal frontmatter:

  ```yaml
  ---
  type: review
  id: REVIEW-{{slug}}
  reviewer: {{reviewer}}
  decision: pending
  ---
  ```

  Add `task` or `pr` only when present. Put companion spec path and frozen target state in the body.

## Place

Resolve `~/.agents/artifacts/<workspace>/` to an absolute path. Derive `<workspace>` from the
repository or working-directory basename. Write there. A collision, ambiguous workspace, or blocked
write requires human selection. Repository, vendor, and OS temporary paths are invalid.

## Assess

1. Enumerate every scoped requirement and preservation guarantee.
2. Rerun every applicable verification after the final relevant change. Worker evidence is a claim.
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
5. Add sections only for unique facts.
6. Keep short raw output once. Move dominating output to an adjacent evidence receipt with stable
   anchors, command, working directory, state identifier, exit status, and untouched output.

Unrelated green suites, author confidence, and votes prove nothing. Emit no ship verdict.

## Decision

After assessment, present a state-aware native picker:

- All rows Supported: Accept, Request changes, or Defer.
- Unsupported or Unverified rows and no Blocked row: Accept with named waivers, Request changes, or
  Defer. Never offer plain Accept.
- Any Blocked row: Request changes or Defer. Never offer either acceptance option.

Only human selection changes `decision` to `accepted`, `changes-requested`, or `deferred`.
Add `waivers` only when the human explicitly accepts while waiving named unsupported or unverified
IDs. `waivers` is an optional string list such as `waivers: [AC-002]`; never write it as a scalar.
Ordinary acceptance and pending reviews omit `waivers`.
Hand off the absolute path. After the artifact is fully actioned and no downstream step needs it,
require one human disposition for it and its sidecars: Delete, Leave, or Promote.
