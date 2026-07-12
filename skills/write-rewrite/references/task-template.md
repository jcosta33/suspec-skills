# Run notes: {{title}}

- Run notes: {{full path or stable native-artifact identifier for this file}}
- Task packet: {{full path when dispatched from one; otherwise None}}
- Spec: {{full path when one exists; otherwise None}} · Change plan: {{full path to the change plan}}
- Worktree / branch: {{branch}}
- Created: {{YYYY-MM-DD}} · Status: active

Place the file next to your own native artifacts — the same place you keep your plans,
notes, and memories for this work, in a folder named after the repo you are working on
(or wherever fits your harness best). You choose the exact spot; keep it out of the repo
unless the project's own governance says otherwise, and carry the file's full path
forward — every later step names artifacts by explicit path.

> **Rewrite task** — distinct from a refactor: behavior changes on purpose. The recorded delta is
> the contract; everything outside it is preserved and proven preserved. Halt on any emergent
> change the delta does not name.
>
> **Commands** resolve from the code repo's `AGENTS.md` Commands table. For any command you need
> that is undefined, ask the user — do not guess.

## Scope (from the task packet or direct intent)

Implement (the delta) and preserve (everything else):

- AC-001 — {{delta: behavior that changes}}
- AC-002 — {{preservation: behavior that must not change}}

Do not change: {{areas the packet rules out}}

## Behavior delta (as recorded in the sources)

Copied from the spec / change plan — not invented here. Anything not listed is preserved. No row
left undecided.

| Aspect | Before | After |
|---|---|---|
| | | |

## Equivalence check for the preserved surface

The check that would *fail* if behavior outside the delta changed: differential (old path behind a
shim, diffed on the preserved surface), golden-output captured before the change, or
property-based. If the existing suite is the only check, state why it suffices for this change.

-

## Caller inventory

Every caller of every rewritten symbol, whole codebase, string forms included (dynamic dispatch,
registries, reflection, generated code, config). Paste the search; account for each caller.

| Caller | Updated for the new behavior / verified under the preserved one |
|---|---|
| | |

## Progress checklist

- [ ] Packet, spec, and change plan read; the delta is recorded in the sources before any code
- [ ] ACs cover the delta *and* the preserved surface
- [ ] Equivalence baseline captured before touching code; suite green
- [ ] Caller inventory complete; search output pasted
- [ ] Rewrite in batches; checks run and pasted per batch
- [ ] Delta ACs proven (intended-failure transition pasted for new tests)
- [ ] Preserved surface proven by the equivalence check (or the sufficiency note recorded)
- [ ] Findings recorded; self-review answered

## Evidence (paste actual command output — never paraphrase)

- Check command (runner summary + exit):
- Test command (runner summary + exit):
- Intended-failure transition per new delta test:
- Equivalence check output (or the recorded sufficiency justification):
- Caller search (call syntax + string form):

## Decisions

In-scope choices the requirements did not constrain. Work that grew beyond the estimate is noted
here, not reverted.

-

## Findings

"Redesign while we're here" temptations, off-delta discoveries. Keep them here for review; only
evidence-backed, durable lessons move into native memory or project channels at close.

-

## Blocked questions

An emergent behavior change the delta does not name (halt: amend upstream or preserve), an
ambiguous AC.

-

## Next steps

-

## Handoff

- [ ] Final evidence, summary, and findings copied into the controlling task/spec when one exists;
      otherwise included in the direct handoff. Nothing final lives only in these private notes.

## Self-review

Answer in writing, evidence pasted. Behavior is permitted to change here — which is exactly where
an unintended change hides.

- **Delta integrity:** does every behavior change in the diff appear in the recorded delta?
  Did anything sneak in?
- **Two surfaces:** is every delta AC proven by its check, and the preserved surface by the
  equivalence check (or recorded sufficiency note)?
- **Callers:** every caller found — string forms included — and accounted for, search pasted?
- **Scope:** nothing outside the packet's areas; off-delta discoveries recorded as findings.
- **Completeness:** nothing stubbed or half-rewritten; the next session could continue from this
  file alone.
- **Independence:** no review result issued on your own work.
