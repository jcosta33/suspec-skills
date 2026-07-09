---
name: save-findings
type: agent-guide
description: >-
  Close a run by saving what it taught: sweep the run's Findings section, write
  one finding artifact per durable lesson with its evidence, and leave each one
  ready for triage at `suspec done` — promote to a GitHub issue, keep with an
  expiry, or discard deliberately. Use at Close — after the review, before the
  run is marked done — or whenever a session surfaced something the next run
  would want to know. One claim per finding, evidence attached, searchable
  title. Skip mid-run; the run file's Findings section is the staging area
  until Close.
---

# Saving findings

An agent session ends and its context evaporates — anything not written to a file is gone, and
the next run re-discovers it the expensive way. Close is where you stop that: **before closing
a run, record anything durable as a finding.** This is a convention — nothing enforces it at
edit time; it costs one short file per lesson.

## The close flow

1. **Sweep the staging area.** Read the run file's `## Findings` section and the run
   summary. List every candidate: facts learned, quirks hit, decisions made, gotchas survived.
2. **Decide each candidate deliberately.** Durable → a finding artifact. Not durable → drop it,
   knowingly. The failure mode is neither saving nor dropping — candidates rotting in a closed
   run file nobody reopens.
3. **Write one artifact per lesson** in the store, beside the run file (`finding-NNN.md`,
   flat, same folder the launch prompt pointed you at — no launch prompt? it lives in your personal store — the same user-level territory as your plans and session files, never the repo; exact directory `suspec store path` (collision-safe), default `~/.claude/state/<repo-name>/` without the CLI.): what we learned (one claim),
   the evidence, where it applies, where it does not, what to do differently next time. The
   `from:` field names the run or review it came out of — a finding without provenance can't
   be re-checked when someone doubts it later.
4. **Leave each finding triage-ready.** Findings are transient store artifacts — they are
   triaged at `suspec done`, one decision per finding: **promote** (a GitHub issue via
   `suspec promote` — the durable channel), **keep** (with an expiry date — a fact only your
   next few runs need), or **discard** (the default for non-critical leftovers). A finding
   with `severity: critical` is never silently discarded — it requires an explicit choice.
   Write each finding so a triage pass can decide it on its own text: the claim, the evidence
   link, and the blast radius must be in the file.
5. **Route the outgrown ones.** A decision big enough to outlive the feature is an ADR in the
   repo's decision ledger, not a finding. New intended behavior is a spec amendment, not a
   finding. A reproduced defect is a bug report — and usually a promoted issue. The finding
   artifact is for reusable project facts awaiting their triage.

## What counts as durable

The test: _would the next run in this area want to know this?_

- **Provider quirks** — "the payments sandbox rate-limits at 10 rps; the docs say 100."
- **Hidden contracts** — "the export job assumes `user.email` is never null."
- **Decisions with rationale** — "we retry idempotent calls only; see the review packet."
- **Gotchas** — "the suite passes locally with a stale fixture; regenerate first."

What does **not** count: run logs, transcripts, "the tests passed" (that lives in the review
packet), local environment details, anything you'd never search for again.

## Writing one well

- **One claim per finding.** Writing three? Write three files — a grab-bag finding is
  unsearchable and un-retractable, and triage cannot promote half a file.
- **Evidence attached.** Link the review packet, PR, or pasted output that grounds the claim.
  An evidence-free finding is a rumor with a filename.
- **Bound it honestly.** "Where it does not apply" is what keeps a true-in-March finding from
  misleading someone in November.
- **Title you'd search for.** A kept finding comes back through grep over the store; a
  promoted one through the issue tracker's search. "payments-sandbox-rate-limit" gets found;
  "notes-from-run-12" doesn't.

## How findings come back

Durability happens by promotion, not by residence. A promoted finding is a GitHub issue —
visible to the team, searchable, assignable, and it survives a store wipe (`suspec fix #123`
rebuilds the working context from the issue alone). A kept finding lives in the store until
its expiry and comes back through grep — plain markdown with real words in it. When you write
the next spec touching the same area, link the finding (or its issue) in its `sources:` —
that's the whole feedback loop: lessons from one run become input to the next.

## Gotchas

- **Saving a finding with no evidence link.** The lesson feels obviously true, so you write
  the claim and skip the link to the review packet, PR, or pasted output. An evidence-free
  finding is a rumor with a filename — when someone doubts it in November, there is nothing
  to re-check, and the finding quietly loses the next argument it should have won.
- **Writing findings mid-run instead of at Close.** A quirk bites you, so you spin up a
  finding file right then. The run file's `## Findings` section is the staging area until
  Close; premature files skip the deliberate keep-or-drop sweep and land in triage half-baked.
- **Packing several lessons into one file under a generic title.** Three discoveries land in
  "notes-from-run-12." A grab-bag is unsearchable, triage cannot promote one claim in it
  without dragging the others along, and you cannot retract one claim either.
- **Treating "keep" as the safe default.** Keep is a decision with an expiry, not a way to
  avoid deciding. A finding worth keeping past a few runs is worth promoting; one that isn't
  is a discard. The store stays useful because it is small.

## Before you finish

- [ ] Every candidate in the run file's Findings section was saved or deliberately dropped.
- [ ] Each saved finding states one claim, with evidence linked and a `from:` provenance.
- [ ] Each finding says where it applies _and_ where it does not.
- [ ] Decisions that outlive the feature went to the repo's ADR ledger, not into findings.
- [ ] Each finding is triage-ready: the claim, evidence, and blast radius stand on the file's
      own text, so `suspec done` can promote, keep, or discard it without this session's
      context.
