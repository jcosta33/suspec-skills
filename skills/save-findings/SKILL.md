---
name: save-findings
type: agent-guide
description: >-
  Close work by preserving what it taught: collect finding candidates from the
  active run, save each durable personal lesson through the harness's native
  memory when available, and route team-facing residue through project channels.
  ALWAYS apply at Close, after review and before handoff, or when a session
  surfaces a verified lesson future work needs. Never invent a memory file,
  save secrets or private data, preserve an unevidenced claim, bundle unrelated
  lessons, or let a severe issue disappear as ephemeral. Skip mid-task; keep
  candidates in the active working artifact until Close.
---

# Saving findings

Close turns verified lessons into retrievable state. It does not create a Suspec findings store or
assume every harness exposes memory.

## Close flow

1. **Collect every candidate.** Read the active task packet's `## Findings` when work was split,
   the review packet's findings and Findings or Open decisions, the spec's current `## Execution` notes for
   direct work, and any verified lesson surfaced in the session. The carrier varies; the sweep does
   not.
2. **Classify deliberately.** Mark each candidate:
   - **ephemeral:** useful only to this completed run;
   - **personal durable:** a verified fact, contract, or gotcha future work in this area needs;
   - **team durable:** a decision, defect, invariant, or operational fact collaborators need; or
   - **severe:** a security, correctness, privacy, data-loss, or compliance issue requiring explicit
     human attention before close.
3. **Apply the privacy gate.** Never save credentials, tokens, private keys, personal data, customer
   data, confidential prompts, or raw output containing them. Redact evidence while preserving the
   part that proves the claim. When redaction would make the evidence meaningless, route the finding
   through the project's approved restricted channel instead of memory.
4. **Use native memory when it exists.** Call the harness's actual memory capability. Save one claim
   per memory under a searchable title, with evidence, scope, and where it does not apply. Do not
   guess a filesystem convention or write `CLAUDE.md`, `AGENTS.md`, or another ad hoc memory file.
5. **Use an honest fallback when native memory does not exist.** Create no substitute store. Route
   team-durable findings through project channels. Leave personal task-local observations ephemeral;
   do not invent a handoff section that behaves like an unsanctioned memory store. Severe candidates
   still go to Findings or Open decisions and the project's approved escalation path.
6. **Route team residue by ownership.** Decisions go to the project's ADR process. Reproduced defects
   go to its issue or bug-report process. Invariants that must never regress become tests when that
   change is authorized. Operational facts use the team's documented runbook or issue channel.

## A good memory

```markdown
Title: payments-sandbox-rate-limit

Claim: The sandbox returned HTTP 429 above the recorded request rate on 2026-07-11.
Evidence: `<redacted command>` returned `<non-sensitive response excerpt>`; run id `<durable id>`.
Applies to: sandbox account plan and region used by the run.
Does not establish: production limits or behavior on another account plan.
```

The evidence must survive the working packet. Prefer durable source pointers, committed tests, issue
links, or a redacted proving excerpt. A pointer only to transient agent context is not evidence for a
future session.

## Refuses

| Temptation | Response |
| --- | --- |
| Save a plausible lesson with no evidence | Verify it or leave it unsaved |
| Put several lessons in one generic memory | Split by independently correctable claim |
| Invent a memory file or handoff store because no API exists | Route team residue; leave personal-only observations ephemeral |
| Paste raw logs containing secrets or personal data | Redact or use an approved restricted channel |
| Keep a team issue only in personal memory | Route it through the project's shared channel |
| Drop a severe candidate as run noise | Put it in Findings or Open decisions and escalate before close |
| Save mid-task before the evidence settles | Keep it staged until Close |

## Memory hygiene

- Save what was verified, not what was assumed.
- Name time, version, environment, and population bounds that can expire.
- Correct or remove a native memory when later evidence contradicts it.
- Never infer that native memory auto-loads; use the harness's documented retrieval behavior.
- Do not duplicate a durable team record into personal memory unless the memory links to that record
  and adds a genuinely personal retrieval cue.

## Completion gate

- [ ] Every candidate was classified and accounted for.
- [ ] Severe candidates appear in Findings or Open decisions and an approved escalation path.
- [ ] Native memories, when supported, each contain one verified claim, evidence, and bounds.
- [ ] When memory was unavailable, no ad hoc file or handoff store was invented.
- [ ] Team-durable findings went through project-owned channels.
- [ ] Saved or routed material contains no secret, credential, personal, customer, or confidential
      data outside its approved channel.
