# Run notes: {{title}}

- Run notes: {{full path or stable native-artifact identifier for this file}}
- Task packet: {{full path when dispatched from one; otherwise None}}
- Spec: {{full path when one exists; otherwise None}}
- Change plan (baseline, batches, rollback): {{full path when one governs; otherwise None}}
- Worktree / branch: {{branch}}
- Created: {{YYYY-MM-DD}} · Status: active

Place the file next to your own native artifacts — the same place you keep your plans,
notes, and memories for this work, in a folder named after the repo you are working on
(or wherever fits your harness best). You choose the exact spot; keep it out of the repo
unless the project's own governance says otherwise, and carry the file's full path
forward — every later step names artifacts by explicit path.

> **Refactor task** — restructure code while observable behavior holds, proven by an
> equivalence check that would fail on drift (a green suite is not one). Syntax-aware transforms
> are bounded and diff-reviewed; checks run at every batch; every deletion proven safe by
> pasted search; every shim carries a removal criterion.
>
> **Commands** resolve from the code repo's `AGENTS.md` Commands table; the test and check
> commands run together at every batch. For any command you need that is undefined, ask the
> user — do not guess.
>
> **Behavior moving?** If any observable behavior changes, this is no longer a refactor — it
> is a rewrite (behavior changes on purpose) or a migration (API A → B). Relabel the task and
> load that guide; do not proceed under the wrong label.

## Scope (from the task packet or direct intent)

- Restructure: {{what moves / extracts / collapses / gets deleted}}
- Preserve: the ACs and guarantees the packet lists as held behavior.
- Do not change: {{areas the packet rules out}}; "while I'm here" improvements go to Findings.

## Equivalence check (captured before touching code)

How preservation is proven — the check that would _fail_ if behavior changed: property-based,
differential (old path kept reachable behind a shim and diffed until clean), or golden-output
pinned before the change. If the existing suite is the only check, state why it is a
sufficient oracle for this change.

-

## Batch checkpoints

Define each batch from coherent behavior and risk. Follow the change plan's waves when one governs;
otherwise derive the bounded batch from the direct scope here. It must be small enough to
diagnose and reverse if its checks fail. Paste check output per batch: drift caught one batch old is cheap to undo;
accumulated drift is its own untangling project.

| Batch | Files in batch | Check output (pasted) |
| ----- | -------------- | --------------------- |
| 1     |                |                       |

## Compatibility shims

Record each shim _before_ introducing it. A shim with no removable-when criterion is
permanent by default — exactly the debt the refactor was meant to reduce.

| Shim path | Forwards to | Removable when (verifiable)              |
| --------- | ----------- | ---------------------------------------- |
|           |             | e.g. `git grep -c '<old-name>' src/` = 0 |

## Deletion safety

For each deleted symbol: paste the search showing zero callers across source _and_ tests,
plus a separate search for the symbol's **string form** (dynamic dispatch, registries,
reflection, generated code, config) that a call-syntax search cannot reach.

| Deleted symbol | Caller search (pasted) | String-form search (pasted) |
| -------------- | ---------------------- | --------------------------- |
|                |                        |                             |

## Progress checklist

- [ ] Controlling intent or packet read; change plan read when one governs; scope recorded above
- [ ] Equivalence check captured; suite green before any change
- [ ] Any syntax-aware transform was bounded and diff-reviewed; outliers were hand-edited; check
      output pasted per batch
- [ ] Every deletion proven safe — caller and string-form searches pasted
- [ ] Every shim documented with a verifiable removal criterion
- [ ] Old locations confirmed empty of what moved — nothing orphaned
- [ ] Equivalence check run after the final edit; output pasted
- [ ] Findings recorded; self-review answered

## Evidence (paste actual command output — never paraphrase)

- Per-batch check output (each batch):
- Final test + check output (runner summaries + exits):
- Equivalence check output (or the recorded sufficiency justification):
- Deletion searches (per symbol — call syntax and string form):

## Decisions

-

## Findings

Semantic improvements the restructuring tempted, neighboring debt, missing tests. Keep them here
for review; only evidence-backed, durable lessons move into native memory or project channels at
close.

-

## Blocked questions

-

## Next steps

Larger refactors span sessions — leave the next batch's concrete starting point.

-

## Handoff

- [ ] Final evidence, summary, and findings copied into the controlling task/spec when one exists;
      otherwise included in the direct handoff. Nothing final lives only in these private notes.

## Self-review

Answer in writing, evidence pasted. Guard against two prominent failure modes — a behavior delta
smuggled in under the "purely internal" label, and a shim that quietly becomes permanent.

- **Equivalence:** would the check fail if behavior had changed — and did it pass after the
  final edit, output pasted? If the suite was the only oracle, is the sufficiency reasoning
  written down?
- **Scope:** is the diff purely structural — no semantic tweak, no contract change? Anything
  in the old location that should have moved? Anything moved that should not have?
- **Deletions:** every deleted symbol backed by pasted caller and string-form searches?
- **Shims:** every shim carries a mechanically checkable removal criterion; none that this
  task should have removed survives?
- **Cadence:** did checks run at every batch with output pasted — or did checking slip to
  the end?
- **Handoff:** findings recorded; no review result issued on your own work.
