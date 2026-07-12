---
name: write-research
type: agent-guide
description: >-
  Write a research note: survey the options and evidence behind ONE decision-informing question,
  and commit to no decision. ALWAYS apply when asked for research, an options / library / API
  comparison, an evidence survey, or a recommendation feeding a later decision. Never present
  opinion as a finding, ask a source to support a claim outside its competence, fabricate or leave
  a claim unmarked when you could not verify it, settle an open question by asserting a choice, or write
  requirements. Skip when writing a spec, recording the present state of code, diagnosing a
  defect, or sizing markets / mapping competitors / synthesizing customer evidence — research
  is their upstream input, not a substitute.
---

# Writing a research note

`DISRESPEC-SPINE: One fact once. No filler, repeated source material, empty sections, or chat restatement; after successful creation return only clickable artifact links, except for blockers, failed creation, incomplete verification, or irreversible-action confirmation.`

A research note answers one decision-informing question by mapping the options and the evidence,
then stops. Its job is to leave the decision space well-mapped, not to close it: the decision is
made later, when someone lifts the findings into a spec or an ADR. A research note has these sections:
**Question · Findings (R-NNN) · Open questions · Recommendation**; do not reinvent them.

The discipline is evidentiary: cite or omit. A claim that cannot survive a citation falls out of
the document. These rules are conventions backed by review — nothing in this repository enforces
them automatically.

## Working principle

Investigate one question in depth against primary sources. Keep observation distinct from claim,
keep your confidence honest, and refuse to let the inquiry harden into a decision. This guide is for
**depth** on one question; market, customer, competitor, or UX-pattern **breadth** research is a
different job — survey many sources, triangulate, grade confidence — and not this note.

## Rules

### 1. State the one question before searching

Write the question section first, in one or two sentences, naming the decision it informs.
"Which message-broker library minimizes operational complexity at our 10K msg/sec target?" — not
"look into message brokers". If the question will not state concisely, the scope is unclear, and
an unbounded survey returns noise. One note, one question; split a double topic in two.

### 2. Map breadth-first, then drill down

List the sub-topics and candidate options before drilling into any one. Going depth-first on the
first option found is how a survey silently becomes an advocacy piece for whatever you read first.

### 3. Match sources to claims

Choose evidence by what the claim asks it to establish:

- a standard or specification for what is defined;
- official docs and versioned source for an API or supported contract;
- direct product exercise for current behavior when feasible and lawful;
- a study or benchmark with inspectable method and data for comparative or outcome claims;
- a contemporaneous first-party record for what an actor announced, believed, or intended; and
- secondary analysis for its own analysis or as a route to underlying evidence.

A blog may be primary evidence for its author's announcement and weak evidence for an independent
performance claim. Peer review does not make an indirect study fit the question. Disclose the search
scope and stop when the relevant option and counter-evidence space is covered; no fixed source count
establishes coverage.

**When the question turns on empirical or scientific evidence** — study results, effect sizes,
benchmark numbers, or "X is faster/safer/better" claims — open
[`references/research-methodology.md`](./references/research-methodology.md) and grade each source
by it before you cite: the claim-fit matrix and the downgrade checks (small N, indirect setting,
conflict of interest, single unreplicated result). Carry
the result into the finding's confidence (rule 4) with the reason it was downgraded.

### 4. Record each finding as R-NNN with its confidence

Give every finding a stable id (`R-001`, `R-002`, …) and four fields: the one durable **claim**,
the **evidence** (source, command, or output — enough for a reader to re-verify), a
**confidence** (high / medium / low), and what it **bears on** (the option or question it
informs). A finding with no evidence field is an opinion with an id; a missing confidence hides
how much weight the recommendation can bear. Stable ids let a spec or ADR cite the exact finding
it rests on.

### 5. Exercise product behavior when feasible

When a finding turns on current product behavior and safe access exists, run it (a curl, sandbox
script, or recorded session) and record the observed output. If access, cost, safety, or legality
prevents exercise, use the strongest available contract or first-party evidence and state that the
behavior was not independently exercised. Never imply a live trial occurred when it did not.

### 6. Mark every unverified claim `[unconfirmed]` — never fabricate

If you could not reach the source, it was paywalled, or the claim is conjecture from secondary
material, bracket it `[unconfirmed]` rather than presenting it as fact. A fabricated finding
poisons every document that later cites it; the bracket pushes the gap into the page where the
next reader sees it.

### 7. Compare options in a table, not narrative

Where several options exist, put them side by side with named criteria. A narrative comparison
hides which option wins on which axis and forces the next author to re-derive the table.

### 8. Surface what you could not answer as open questions — do not settle them

Every point the inquiry raised but did not answer becomes an open question (`Q-001`, …), with a
note on what answering it would unblock. Resolving it here by asserting a choice breaks the
stance and hides the unknown from the person who should decide.

### 9. Close with an advisory recommendation — or say why none is possible

The recommendation names a specific direction and the R-NNN findings that ground it; it commits
nothing and writes no requirements. If no clear recommendation is possible, say so explicitly
and name the open question that would unblock one — "it depends" without saying _on what_ hands
the reader back the question they came with.

## What does not belong

- Requirements in any form: no AC items, no SOL blocks (see write-spec's
  "structured (SOL) form") — those belong in the spec someone writes _from_ this note.
- Opinion or "best practice" with no evidence fitted to the claim.
- A decision. Findings survey; they do not conclude.
- Sources you did not actually consult.
- Code edits — a research session is read-only on source; it produces a document.

## Gotchas

- **Presenting an opinion as a finding.** An R-NNN entry asserts "library X is the better fit"
  with an evidence field that just restates the claim, no source, command, or recorded output
  behind it. It looks like a finding because it has an id, but an id does not make it checkable;
  the spec that later cites R-007 inherits a hunch dressed as established fact.
- **Using a source outside its competence.** A vendor post is treated as independent evidence that
  its product outperforms alternatives, or a benchmark is treated as proof of a supported API
  contract. Refit the source to the claim and trace load-bearing downstream numbers to their origin.
- **Settling the open question instead of surfacing options.** The note quietly picks a winner —
  "we should use X" in the body, or an Open question resolved by assertion — when its job was to
  map the decision space and hand it over intact. The person who owns the decision never sees the
  alternatives were live, and a choice nobody deliberated arrives looking already made.

## Before you finish

- [ ] The question is stated first and the whole note answers it — no scope drift.
- [ ] Every R-NNN finding has a non-empty evidence field and a confidence value.
- [ ] Every claim you could not verify is marked `[unconfirmed]`; none is dressed as fact.
- [ ] Every source is fit for the claim it supports; load-bearing downstream claims trace to their
      origin when available.
- [ ] Product behavior was exercised when feasible, with output recorded; otherwise the access
      boundary is explicit.
- [ ] Open questions are listed, not silently settled.
- [ ] The recommendation names the findings it rests on — or names the open question blocking one.
- [ ] For empirical/scientific claims, each source was appraised against the methodology reference
      and material rejected sources are recorded.

## Bundled resources

- [`references/research-methodology.md`](./references/research-methodology.md) — how to appraise
  evidence when a question turns on empirical or scientific claims: claim fit, method quality,
  downgrade/upgrade checks, observation-versus-inference, and the auditable Rejected trail. Load it at
  rule 3 when the evidence is empirical — not needed for a plain API/feature comparison.
