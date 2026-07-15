---
type: task
id: "TASK-{{slug}}"
source:
  - "{{spec-id}}"
  - "{{additional-source-id; omit when none}}"
scope: ["{{requirement-id}}"]
status: ready
---

# Task: {{title}}

## Source

- Spec: `{{absolute path}}` (`{{spec-id}}`)
- Change plan: `{{absolute path or None}}`
- Source state: `{{commit or stable snapshot}}`

### Requirement Snapshot

Copy every scoped requirement block and its `Verify with:` or `VERIFY BY` line verbatim. Scope may
contain `AC-`, `C-`, `I-`, or `IF-` IDs. The spec remains canonical; a change plan supplies only
additional source and wave context. Re-cut this packet after a material source change.

## Scope

List assigned requirement IDs only. The snapshot above owns their text.

- {{requirement-id}}

## Preservation scope

Omit without a change plan. Otherwise copy every preservation guarantee this packet could violate:

- {{PG-NNN or governing requirement ref}} - {{behavior}} - Verify with: {{exact check}}

## Do not change

- {{paths, contracts, or behavior outside this slice}}

## Affected areas

- `{{write path or directory}}`

## Verify

Paste final evidence here and nowhere else. Replace every pending field after the final relevant
edit. `ready` and `running` packets may retain pending evidence. Before setting `status` to
`review-ready` or `closed`, every Verify entry must contain one of: an exact command with numeric
exit status and fenced decisive raw output; `CI: https://...`; or a justified `n/a`.

Repeat for every assigned requirement and preservation guarantee.

### {{requirement-or-preservation-id}}

- Command: `{{exact source check}}`
- Working directory: `{{absolute path}}`
- State: `{{commit or stable snapshot}}`
- Exit status: pending
- Raw output:

  ```text
  pending
  ```

## Agent instructions

- Read this packet, every source above, and repository instructions before editing.
- Stop on conflict, ambiguity, or pressure to cross Scope or Do Not Change.
- Put each final Verify command, numeric exit status, and fenced decisive raw output under its
  `## Verify` entry, or record `CI: https://...` or a justified `n/a` there.
- `ready` and `running` may retain pending evidence; `review-ready` and `closed` may not.
- In Run summary, cite each Verify entry once; never paste its output again.
- Do not assess your own work.
- When finished work reaches `review-ready`, review it against its governing spec or task in a fresh
  independent context.

## Run order

1. {{TASK-first}} - {{why first}}
2. {{TASK-next}} - {{dependency or proven parallel relationship}}

- This packet: {{TASK-id}}
- Starts after: {{task IDs or None}}
- May run with: {{task IDs proven write-disjoint or None}}

## Findings

- None.

## Run summary

- Status: not started
- Changed files: none
- Verify evidence: {{requirement-or-preservation-id}} - pending
- Scope drift: none
- Blocked questions: none

## Self-review

- [ ] Every changed file is in Affected Areas or listed as an exception.
- [ ] Every scoped requirement and preservation ID has fresh final evidence.
- [ ] Findings and blockers are recorded.
- [ ] No self-assessment or acceptance was issued.
