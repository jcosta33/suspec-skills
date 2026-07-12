---
type: task
id: "TASK-{{slug}}"
source:
  - "{{SPEC-id}}"
scope: ["{{AC-001}}"]
status: ready
---

# Task: {{title}}

## Source

- Spec: `{{full path}}`
- Change plan: `{{full path when one governs; otherwise None}}`
- Source commit: `{{commit SHA at split time}}`

### Requirement snapshot

Copy each scoped requirement and its `Verify with:` line verbatim from the source. This is a pinned
execution snapshot; the spec remains canonical. Re-cut this packet after a material spec change.

## Scope

- {{AC-001}} - {{the source obligation, unchanged}}

## Do not change

- {{paths, contracts, or behaviors outside this slice}}

## Affected areas

- `{{write path or directory}}`

## Verify

- [ ] {{AC-001}} - `{{exact command from the source}}`

## Agent instructions

- Read this packet, its source, and the repository's `AGENTS.md` before editing.
- Stop and ask if the requirement conflicts with a non-goal or Do not change boundary.
- Paste each Verify command, exit status, and relevant output in Run summary after the final edit.
- Do not issue a review result on your own work.

## Findings

- None yet.

## Run summary

- Status: not started
- Changed files: none
- Verify evidence: not run
- Scope drift: none
- Blocked questions: none

## Self-review

- [ ] Every changed file is inside Affected areas or explicitly listed as an exception.
- [ ] Every scoped id has fresh Verify evidence after the final edit.
- [ ] Findings and blocked questions are recorded; no review result was issued.
