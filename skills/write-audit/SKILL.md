---
name: write-audit
type: agent-guide
description: >-
  Write an audit: a present-state record of a code area — what is true today, the risk it
  carries, and the evidence behind every claim. Observation-only. ALWAYS apply when asked for a
  code audit, tech-debt survey, cleanup or benchmark report, or a quality assessment of existing
  code — including deepening a prior audit. Never assert intended behavior, prescribe a fix,
  write requirements, or leave an observation without file:line or pasted-output evidence. Skip
  when writing a forward-looking spec, diagnosing one defect to its root cause, or surveying
  open options against external sources.
---

# Writing an audit

`DISRESPEC-SPINE: One fact once. No filler, repeated source material, empty sections, or chat restatement; after successful creation return only clickable artifact links, except for blockers, failed creation, incomplete verification, or irreversible-action confirmation.`

An audit makes a code area legible so the work on it can be planned. It records what is true
**today**, grounds each claim in evidence, names the risk that state carries — and stops there.
An audit has these sections: **Scope · Observations · Risks · Open questions / unverified areas**.

Audits fail in two directions: they drift into prescription (telling the reader what to build —
a spec's job), or they stay vague (impressions and TODO-scrapes nobody can act on). The rules
below pin the audit to its **observation-only** boundary. They are conventions backed by review —
nothing in this repository enforces them automatically.

## Working principle

Record only what is present or what follows from identified evidence. What the system _should_ do
is intent; it does not belong in an audit.

## Rules

### 1. State the goal and bound the scope first

Without a goal, "current state" has no meaning. Write a measurable goal ("surface anything
blocking a Q3 change to the pricing engine"), not a vague intention ("improve billing"). Then
fill the scope section with both **in scope** and **out of scope**. An unstated boundary makes
the audit unfalsifiable, and the scope silently expands under whoever acts on it.

### 2. Ground every observation in evidence

Each observation cites the observable that grounds it: `path:line`, command output, a grep
result. State the fact, never the fix. The citation makes the observation checkable and lets the
next reader navigate straight to it; an ungrounded claim is an opinion wearing a fact's clothes.

### 3. Run the dynamic checks; do not trust static reading

Concurrency, lifecycle, resource cleanup — reading the source does not prove these. When the audit
makes a dynamic claim, run the project's test or check commands (the Commands table in the repo's `AGENTS.md`; if a command
is missing, ask, because a guessed command silently audits the wrong thing) and paste the output. The highest-value findings are properties
that _look_ held in the source but are not held at runtime.

### 4. Grep for callers across the whole codebase

For every public surface you observe, search for callers everywhere, not just the audited
module. Zero-caller code is itself an observation (a cleanup candidate). The cross-module grep
is the only thing distinguishing a live surface from a fossil.

### 5. Name each risk with its firing condition

Risks are evidence-backed inferences about what could go wrong but was not observed firing. Each
names the evidence, failure mode, and firing condition — not the remedy. A risk without that chain
is unactionable noise. If no supported risk is found, say `None observed in scope`; never invent one
to fill the section.

### 6. Calibrate severity by blast radius

Tag each risk Blocker / Major / Minor by _what breaks and how far the damage
spreads_ — never by how hard it was to surface or how alarming it feels. Observations remain facts;
they need no severity unless they themselves record a concrete failure. A subtle
defect with a one-edge-case blast radius is Minor; an obvious gap that lets unsafe work proceed
is a Blocker. When a call is contestable, record the reasoning inline so a reviewer can re-derive it.

### 7. Deepening a prior audit: read it closed

Set the prior audit's framing aside and re-derive every finding from the code; verify that its
cited `path:line` references still resolve. Inheriting a conclusion is how a real defect stays
hidden across two audits.

## What does not belong

- Prescriptions ("we should refactor X") or any fix, patch, or remedy design.
- Assertions of intended behavior ("the new behavior will be Y") — that is spec material.
- Requirements or recommendations in any form.
- TODO-comment scrapes, surface impressions, or any claim with no evidence anchor — sharpen
  each until it cites an observable, or cut it.
- Code edits. An audit session is read-only on source; it produces a document.

## Gotchas

- **Prescribing a fix instead of recording present state.** An observation reads "extract this
  into a helper" or "switch to a connection pool" — that is a spec's decision wearing an
  observation's clothes. The reader lifts it into a plan as if the choice were already made and
  approved, when all the audit was licensed to say is what the code does today and what risk that
  carries.
- **Asserting a structural claim without grepping it.** You write "this handler has no other
  callers" or "the retry path is dead" from reading one file, never running the cross-module
  search. A single uncited structural claim that turns out wrong discredits every finding around
  it, and the live caller you missed is exactly the one the next change breaks.
- **Ranking findings flat instead of by impact.** Every observation lands at the same weight, or
  severity tracks how alarming a finding felt rather than its blast radius. The reader cannot tell
  the one Blocker that lets unsafe work proceed from the cosmetic Minor beside it, and triages the
  wrong thing first.

## Before you finish

Walk the draft once as its harshest reviewer; fix what you find before delivering:

- [ ] Every observation cites `path:line`, command output, or a grep result — none ungrounded.
- [ ] Every risk names its evidence and firing condition; supported risks carry calibrated severity.
- [ ] An empty Risks section explicitly says none were observed in scope.
- [ ] Dynamic claims were run, not read — the output is pasted, not paraphrased.
- [ ] No fix, intended behavior, requirement, or recommendation appears anywhere.
- [ ] The scope section matches what you actually examined.
- [ ] Durable lessons are identified for later routing through native memory or project channels;
      they are not converted into prescriptions inside the audit.
