---
name: write-bug-report
type: agent-guide
description: >-
  Write a diagnosis-only bug report: reproduce the defect, isolate the root cause to file:line +
  state + input + caller, and name the requirement it violates — no fix. ALWAYS apply when asked
  to report, diagnose, or root-cause a bug, regression, or unexpected behavior, even an
  intermittent one. Never write the fix, conflate symptom with cause, write new requirements, or
  finish without the verbatim failing reproduction pasted. Skip when fixing the defect (that is
  its own task), recording the present state of a whole area, or writing a spec.
---

# Writing a bug report

`DISRESPEC-SPINE: One fact once. No filler, repeated source material, empty sections, or chat restatement; after successful creation return only clickable artifact links, except for blockers, failed creation, incomplete verification, or irreversible-action confirmation.`

## Artifact placement

Place the file under `~/.agents/artifacts/<workspace>/`, resolving `~` to the absolute
home path and deriving `<workspace>` from the repository or working-directory basename. Keep it
out of the repository and carry its absolute path forward. If the workspace name or target path
conflicts with unrelated work, stop for a structured human choice; never overwrite. If the root is
unwritable, offer grant access and retry, another agent-neutral user directory, or cancel. Never
fall back to vendor storage, the repository, or a temporary directory.

A bug report is a defect record, not a remedy: symptom, reproduction, root cause, and the
requirement the defect violates. The fix is a separate, later task. The report must preserve enough
state that a fixer can rerun the reproduction and evaluate the diagnosis without reconstructing
unrecorded conditions. A bug report has these sections:
**Symptom · Reproduction · Root cause · Affected requirements**; do not reinvent them. These rules are conventions backed by review — nothing in this
repository enforces them automatically.

## The stance

Forensic, hypothesis-driven, read-only on code. Mistrust your first plausible explanation — a
wrong cause wastes the fixer's whole session and lets the defect ship. When an explanation fits,
try to disprove it before you write it down. Diagnosis and remedy are different mindsets; a
combined "diagnose-and-fix" instinct short-circuits diagnosis at the first fit.

## Rules

### 1. Reproduce before you explain

A bug is a hypothesis until reproduced. Run the reproduction (the test command from the
repo's `AGENTS.md` Commands table, or the run command for a runtime defect — if the command
is missing, ask, never guess) and confirm the symptom fires before writing a word about cause.
If you cannot reproduce, say so and investigate the discrepancy (versions, seeds, fixtures,
data, clock, OS) — do not speculate about a cause from a symptom you never saw fire.

### 2. Isolate the smallest reliable reproduction protocol

Once it fires, narrow it: minimal input, minimal environment, fewest steps. Make it deterministic
when the system permits. For an intermittent defect, freeze every controllable condition and report
the repetition count, seeds, concurrency, and observed failures instead of claiming determinism.
The fixer reruns exactly what you hand them; keep failed investigative attempts outside the lead.

### 3. State the root cause as a precise interaction, never the symptom

The root cause is _file:line + what state combines with what input + which caller mishandles
the result_.

- Symptom, not cause: "The function returns null."
- Cause: "`getPricing()` (`src/billing/pricing-adapter.ts:42`) returns null when the cache is
  cold and the upstream call is rate-limited; the caller (`quote.ts:88`) reads null as 'fall
  back to default pricing band' instead of failing."

A cause stated as a symptom recurs through a different path the moment the same state is hit
again; stated as an interaction, it tells the fixer exactly where the defect lives and why.

### 4. Keep observation and inference apart

An **observation** is what the reproduction shows ("fires deterministically with
`NODE_ENV=production` and a 12 MB input"). An **inference** is your explanation ("the proxy is
dropping bytes"). Track each candidate explanation with a status — supports / disproven /
confirmed — and what you tried next. A confirmed cause backed by refuted alternatives is far
stronger than one plausible guess, and the recorded dead ends save the fixer from re-exploring
them.

### 5. Search for the pattern, not just the file

For the root cause you found, grep the codebase for the same shape — same call pattern, same
null handling, same missing guard. Note every related instance, even out of scope. A cause in
one place usually exists in several; surfacing the family lets the fix widen scope or spawn a
sibling report instead of fixing one instance and shipping the rest.

### 6. Name the regression test; do not write the fix

Identify the test that would catch a recurrence: its location and the assertion it must make
against the reproduction's conditions. State the plan only — writing the test belongs to the fix
task. No patch, no diff, no "the function should return X instead" anywhere in the report.

### 7. Name the violated requirement — or record the coverage gap

Point at the existing requirement the defect violates, by id (`SPEC-x#AC-NNN`), and say how the
observed behavior breaks it. Write no new requirement. If no requirement covers the broken
behavior, say so explicitly and save that as a finding. The owner then decides whether intent stays
inline for a trivial fix or needs a spec before the repaired behavior can be accepted.

### 8. Paste the failing reproduction verbatim

The report is not finished until the reproduction section holds the **exact command**, the
**verbatim failing output** (fenced, unedited — no paraphrase, no "should reproduce"), and a
reproducibility note (fires every run / fires N of M runs under the recorded protocol /
`[unable to reproduce]` with what you
tried). A claim without pasted output counts as unverified.

## What does not belong

- The fix: patch, diff, or remedy design — that is the fix task's work.
- Speculation in the root-cause section: only what the reproduction and code verify; unconfirmed
  explanations live in the hypothesis list with a status.
- New requirements, or behavior the system "should" have — reference the violated requirement by
  id, or record the coverage gap as a finding.
- "Should reproduce" or "in theory" — either it reproduces (paste it) or it is marked
  `[unable to reproduce]` with an explanation.
- Source edits. A bug-report session changes no code; the working-tree status proves it.

## Gotchas

- **Wrote the fix instead of diagnosing.** The combined "diagnose-and-fix" instinct short-circuits
  diagnosis at the first plausible cause and ships a patch nobody verified against a reproduction.
  A bug report ends at the root cause and the named regression test; "the function should return X"
  is the fix task's job, not yours.
- **Conflated symptom with root cause.** "Returns null" is where the defect surfaced, not where it
  lives. Stated as a symptom, the cause recurs through a different path the moment the same state is
  hit again. The root cause is file:line + what state meets what input + which caller mishandles
  the result — anything less hands the fixer a re-investigation, not a diagnosis.
- **Finished without the verbatim failing reproduction.** "Should reproduce" or a paraphrased
  output is an unverified claim — the fixer re-runs exactly what you paste, and if it isn't the
  exact command and exact fenced output with a reproducibility note, they isolate the bug you already
  isolated. No paste, not finished.

## Before you finish

Close as the engineer about to hand this to a fixer — look for anything that could mislead them:

- [ ] The exact command and its verbatim failing output are pasted, with conditions (env,
      version, state) and a reproducibility note.
- [ ] The root cause is a file:line + state + input + caller interaction — not the symptom.
      Would the bug recur via another path if the cause is what you say?
- [ ] Every explanation is confirmed or carried with a status; none asserted as fact unproven.
- [ ] You searched the pattern, not just the file, and noted the related instances.
- [ ] No fix anywhere; the violated requirement is named by id, or the coverage gap is recorded
      as a finding.
- [ ] The regression test that would catch a recurrence is identified (or its absence noted).
- [ ] A fixer can rerun the reproduction and evaluate the cause without reconstructing omitted
      environment or state.
