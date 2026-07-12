# Run notes: {{title}}

- Run notes: {{full path or stable native-artifact identifier for this file}}
- Task packet: {{full path when dispatched from one; otherwise None}}
- Spec: {{full path when one exists; otherwise None}}
- Worktree / branch: {{branch}}
- Created: {{YYYY-MM-DD}} · Status: active

Place the file next to your own native artifacts — the same place you keep your plans,
notes, and memories for this work, in a folder named after the repo you are working on
(or wherever fits your harness best). You choose the exact spot; keep it out of the repo
unless the project's own governance says otherwise, and carry the file's full path
forward — every later step names artifacts by explicit path.

> **Feature task** — build exactly the listed ACs. Survey before you invent. Halt on ambiguity.
> No opportunistic refactoring. Nothing leaves your hand unverified.
>
> **Commands** resolve from the code repo's `AGENTS.md` Commands table. For any command you need
> that is undefined, ask the user — do not guess.

## Scope (from the task packet or direct intent)

Implement:

- AC-001 — {{one line}}
- AC-002 — {{one line}}

Do not change: {{areas the packet rules out}}

## Plan

Written before implementation. Every AC mapped to a step.

1.
2.
3.

## Progress checklist

- [ ] Task packet and spec read in full
- [ ] Every AC mapped to an implementation step
- [ ] Pattern survey done — existing helpers/types consulted before inventing
- [ ] Core logic implemented
- [ ] A test per AC added or updated
- [ ] Each new test fails for its targeted violation → implemented state passes (transition below)
- [ ] Checks run after each batch; output pasted below
- [ ] Every Verify item run after the final edit; output pasted below
- [ ] Findings recorded; self-review answered

## Evidence (paste actual command output — never paraphrase)

- Check command (runner summary + exit):
- Test command (runner summary + exit):
- Intended-failure transition per new test (targeted violation fails → implemented state passes):

## Decisions

Implementation choices the requirements did not constrain — and why a new pattern was introduced
instead of reusing an existing one, if it was. Silently resolved ambiguities never go here; they go
to Blocked questions.

-

## Findings

Candidate discoveries — debt spotted, a neighboring gap, a missing AC. Keep them here for review;
only evidence-backed, durable lessons move into native memory or project channels at close.

-

## Blocked questions

Ambiguous or contradictory ACs surfaced for the spec owner. Do not invent the requirement.

-

## Next steps

Concrete starting points if this session ends incomplete.

-

## Handoff

- [ ] Final evidence, summary, and findings copied into the controlling task/spec when one exists;
      otherwise included in the direct handoff. Nothing final lives only in these private notes.

## Self-review

Answer in writing, evidence pasted. A feature that diverges silently from its ACs ships drift.

- **Scope:** every change traces to a listed AC — or is recorded as an exception with a reason.
  Anything beyond the ACs?
- **Coverage:** does every AC map to a part of the diff you can point at? Anything missing?
- **Patterns:** reused what exists; any new pattern justified in Decisions?
- **Tests:** does each new test fail for its targeted violation and pass after implementation,
  transition pasted?
- **Evidence:** every Verify item ran after the final edit, output pasted — no "tests passed"
  without output?
- **Findings:** nothing left only in this session; no review result issued on your own work.
