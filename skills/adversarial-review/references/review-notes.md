# Review notes — {{what is under review}}

> Working notes for one adversarial review. Not a verdict — you record findings + a recommendation; a
> human or an independent reviewer owns the merge decision. No code edits in this session; fixes are a
> separate task.

## Under review

- Change: {{branch / PR # / commit range}}
- Base: {{base branch or commit}}
- Stated intent: {{the PR description / issue / requirement this change claims to satisfy}}

## Project commands (resolve from AGENTS.md / README / CI — ask if unknown)

- test: `{{...}}` · lint: `{{...}}` · build: `{{...}}` · typecheck: `{{...}}`

## Diff overview

{{files touched, and in one line each what changed}}

## Findings

| # | Severity | File:line | Issue | Evidence | FP-risk | Fix sketch |
| - | -------- | --------- | ----- | -------- | ------- | ---------- |
|   |          |           |       |          |         |            |

Severity = consequence if it ships: `BLOCKER` (must fix), `MAJOR` (fix or justify), `MINOR` (note).
Evidence = the diff line / re-run output / caller that proves it. FP-risk = high/medium/low; drop or
down-rank a high-FP-risk flag rather than flooding noise.

## Cross-module callers checked

{{for each changed public surface: the grep + what the callers do}}

## Suggested decision (a recommendation, not a verdict)

{{merge-worthy / block until the BLOCKERs close / needs author input}} — with the one-line reason.

## Self-review gate

- [ ] Re-ran the checks myself, from a clean checkout (not the author's pasted output)
- [ ] Bound every finding to the stated intent or marked it out-of-scope
- [ ] Read the callers of changed surfaces, not only the diff
- [ ] Every finding has file:line + evidence + an FP-risk; no soft-language concerns left
