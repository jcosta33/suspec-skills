---
name: sus-research
description: Write a decision-informing research artifact with traceable evidence. ALWAYS apply when asked to research, compare options, evaluate APIs or products, size a market, map competitors, study customers, synthesize reviews, inspect UX patterns, or assess positioning. Match sources to claims, separate observation from inference, preserve uncertainty, and recommend without deciding. Never fabricate, turn synthetic output into market fact, write requirements, or replace a present-state code audit or multi-stance inspection.
---

# Sus Research

One question. Evidence fit for the claim. No counterfeit certainty.

Ordinary conversation and direct action create no research artifact. Write one only when requested
or required as a live workflow input.

## Frame

State the decision the research informs, the audience or segment, scope, time horizon, and what
evidence would change the direction. Map candidate options and counter-evidence before drilling into
the first attractive answer.

Investigate discoverable facts before asking. If a material scope choice remains, use the native
picker: three genuine options by default, two when binary, recommendation first, one-sentence
tradeoff each, automatic `Other`. Without a picker, render the same numbered options plus `Other`.
Never ask a bare question. A deferred choice blocks dependent research.

## Place

Resolve `~/.agents/artifacts/<workspace>/` to an absolute path, deriving `<workspace>` from the
repository or working-directory basename. Write one artifact with frontmatter `type: research` and
a unique `id` using the `RESEARCH-` prefix under that resolved directory. Never write into the
repository, vendor storage, or an OS temporary directory. Never overwrite unrelated work. Stop with
structured choices on collision or blocked writes.

## Evidence

Match source competence to the claim:

- standards and specifications for defined contracts;
- current official docs and versioned source for APIs;
- safe direct exercise for current product behavior;
- inspectable studies or benchmarks for comparative and outcome claims;
- contemporaneous first-party records for announcements and intent;
- disclosed user research for user experience; and
- secondary analysis for its own analysis or as a route to primary evidence.

For empirical, scientific, safety, reliability, or performance claims, load
[`references/research-methodology.md`](./references/research-methodology.md). For market, customer,
competitor, UX, positioning, sizing, review, or synthetic-respondent work, load
[`references/market-method.md`](./references/market-method.md).

Exercise current behavior when lawful, safe, and affordable. Otherwise state the access boundary.
Never imply a run occurred when it did not. Mark unreachable or unsupported claims `[unconfirmed]`.

## Write

Use only sections that carry information:

- **Question and scope**
- **Method and coverage**
- **Findings**
- **Options comparison**
- **Open questions**
- **Advisory recommendation**

Each finding gets stable `R-NNN`, one claim, exact evidence, confidence, and what it bears on.
Separate observation, source claim, inference, and recommendation. Put comparable options in a
table with named criteria. Preserve disconfirming evidence and material rejected sources.

The recommendation cites its finding IDs and commits nothing. If evidence cannot support one, name
the exact open question or test that would unblock it. Never settle intent, write requirements, or
edit the researched target.

Write each fact once. Return only the clickable artifact path unless blocked or verification failed.
If this skill is the final consumer, a non-empty transient artifact set exists, no earlier
disposition prompt occurred, and no downstream step needs any transient artifact or sidecar created
or consumed by the active work, ask once about the complete transient set: Delete, Leave, or
Promote. Repository-native and other durable inputs never enter disposition. Recommend from state,
explain each option in one sentence, include every transient path, and include `Other`. Never choose
for the human.
