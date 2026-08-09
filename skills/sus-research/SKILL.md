---
name: sus-research
description: Research a decision until evidence can carry it. Use when comparing options, evaluating APIs or products, sizing markets, mapping competitors, studying customers, synthesizing reviews, inspecting UX, or testing positioning. Do not use as the owner of settled fact-checking, present-state audits, or intent authoring.
---

# Sus Research

One question. Fit evidence. Zero counterfeit certainty.

Ask required questions through the native picker, or numbered choices plus `Other`. Put the
recommendation first; offer three genuine options, two if binary; give each one plain reason and
cost.

## Method

Lock the decision, audience or segment, scope, time horizon, and reversal evidence. Map options and
counter-evidence before chasing the first attractive answer.

Force material ambiguity in scope into explicit human selection. Block dependent research until
selection.

### Evidence

Match source competence to each claim:

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

Exercise current behavior when lawful, safe, and affordable. State every access boundary. Mark
unreachable or unsupported claims `[unconfirmed]`.

## Artifact

Resolve `~/.agents/artifacts/<workspace>/` to an absolute path; derive `<workspace>` from the
repository or working-directory basename. Write there with `type: research`, a unique `RESEARCH-`
ID, and linked sidecars beside it. On collision or ambiguous workspace, present human-readable name
choices. On a blocked write, offer grant and retry, another agent-neutral user directory, or cancel.
Never overwrite or fall back to a repository, vendor directory, or temporary path.

Write local source references relative to the artifact. Use absolute paths only for runtime handoff.

Start with:

```yaml
---
type: research
id: RESEARCH-{{slug}}
---
```

### Shape

Use only sections carrying payload:

- **Question and scope**
- **Method and coverage**
- **Findings**
- **Options comparison**
- **Open questions**
- **Advisory recommendation**

Give each finding stable `R-NNN`, one claim, exact evidence, confidence, and decision relevance.
Separate observation, source claim, inference, and recommendation. Put comparable options in a
table with named criteria. Preserve disconfirming evidence and material rejected sources.

Tie the recommendation to finding IDs. When evidence cannot support direction, name the exact
question or test that unlocks it. Keep intent and requirements human-owned.

## Output

Before handoff, cut repetition, softness, ceremony, and structural bloat without changing contracts,
identifiers, verbatim source text, evidence, or behavior. Rerun applicable checks. Return only
clickable Markdown links for the research artifact and every sidecar, with compact `~/.agents/...`
labels and fully expanded absolute destinations. Explain only a blocker, failed creation, incomplete
verification, or irreversible-action confirmation.

## Close

Once fully actioned and no downstream step needs it, require one human disposition for the artifact
and its sidecars: Delete, Leave, or Promote. Promote moves transient material into project-owned
permanence. Delete every selected path and verify absence; survivors block close.
