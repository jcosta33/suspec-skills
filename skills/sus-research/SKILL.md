---
name: sus-research
description: Research a decision until evidence can carry it. ALWAYS apply when asked to compare options, evaluate APIs or products, size markets, map competitors, study customers, synthesize reviews, inspect UX, or assess positioning. Match source competence to every claim, preserve uncertainty, and recommend without deciding. Reject fabrication and synthetic market fiction.
---

# Sus Research

One question. Fit evidence. Zero counterfeit certainty.

## Frame

Lock the decision, audience or segment, scope, time horizon, and reversal evidence. Map options and
counter-evidence before chasing the first attractive answer.

Ambiguous scope blocks dependent research.

## Place

Resolve `~/.agents/artifacts/<workspace>/` to an absolute path. Derive `<workspace>` from the
repository or working-directory basename. Write there with `type: research` and a unique
`RESEARCH-` ID; keep linked sidecars beside it. A collision or ambiguous workspace requires
human-readable name choices. A blocked write requires: grant access and retry, choose another
agent-neutral user directory, or cancel. Never overwrite or fall back to a repository, vendor
directory, or temporary path.

Start with:

```yaml
---
type: research
id: RESEARCH-{{slug}}
---
```

## Evidence

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

## Write

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

Write each fact once. Hand off absolute paths for the research artifact and every sidecar. After the artifact is fully actioned and no
downstream step needs it, require one human disposition for it and its sidecars: Delete, Leave, or
Promote.
Delete selection confirms removal. Verify every selected path is absent; failure blocks close and
reports survivors.
