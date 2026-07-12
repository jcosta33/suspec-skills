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

> **Documentation task** — write for a human who has not read the code and arrived with one
> question. One frame held throughout. Lead with what the reader must do. Every example runs as
> written; every behavior claim is checked against an authoritative current source. No hedging.
>
> **Commands** resolve from the code repo's `AGENTS.md` Commands table (format; doc-lint if the
> project has one). The runner for a code *example* is the example's own command. For any command
> you need that is undefined, ask the user — do not guess.

## Scope (from the task packet or direct intent)

- Document: the requirements the packet lists — nothing wider.
- Do not change: docs outside the packet's areas; "while I'm here" polish goes to Findings.

## Doc target

- **File:** `{{path}}`
- **Frame (exactly one):** tutorial (linear, no choices) / how-to (a recipe for one task) /
  reference (lookup, no narrative) / explanation (the why)
- **Audience:** {{specific — "developers integrating our SDK for the first time", not "developers"}}
- **Reader's question:** {{the one question, stated as the reader would ask it}}

## Source material

What the doc draws on — code, the packet's requirements, prior docs, runtime behavior. Every claim
in the doc traces to one of these.

-

## Examples to verify

Every code example runs as written. The captured output goes under Evidence.

| Example | Run command | Expected outcome |
|---|---|---|
| | | |

## Plan

What is the lead — the answer or action the reader's question asks about? What supports it? Which
examples and source checks does each requirement need?

1.
2.

## Progress checklist

- [ ] Task packet or direct intent read; frame, audience, and reader's question fixed above
- [ ] Doc opening answers the reader before unrelated history or setup
- [ ] Every example run as written; output captured and pasted below
- [ ] Every behavior claim checked against an authoritative current source; published citations
      follow project convention and audience needs
- [ ] Hedges removed — behavior stated, or its condition stated
- [ ] In-scope docs that contradict this one reconciled; out-of-scope contradictions recorded as
      findings
- [ ] Format / doc-lint run on every touched file (output pasted)
- [ ] Findings recorded; self-review answered

## Evidence (paste actual command output — never paraphrase)

- Per example: the captured run output proving it works as written:
- Format command on touched files (runner summary + exit):
- Doc-lint, if the project has one (runner summary + exit):

## Decisions

Authoring choices the requirements did not constrain — frame, structure, what to cut. A behavior
claim you could not verify goes to Blocked questions, not here.

-

## Findings

Contradicting docs outside the packet's areas, behavior no requirement covers, real issues spotted
while writing. Keep them here for review; only evidence-backed, durable lessons move into native
memory or project channels at close.

-

## Blocked questions

A requirement the code contradicts, a claim with no authoritative source — surfaced, not papered over
in prose.

-

## Next steps

-

## Handoff

- [ ] Final evidence, summary, and findings copied into the controlling task/spec when one exists;
      otherwise included in the direct handoff. Nothing final lives only in these private notes.

## Self-review

Answer in writing, evidence pasted. A doc that hedges, ships unrun examples, or contradicts the
code actively misleads — and the reader cannot tell.

- **Reader-first:** does the opening answer the reader before unrelated history or setup?
- **Examples:** every example executed as written — self-contained, output pasted?
- **Currency:** every behavior claim checked against a current authoritative source? Public
  citations fit the audience and project convention? No `TODO`/`FIXME` left behind?
- **Frame:** one frame held throughout — no tutorial/how-to/reference/explanation drift?
- **Hedging:** every "should"/"might"/"could" replaced with the behavior or its condition?
- **Scope:** only the packet's requirements documented; contradictions out of scope recorded as
  findings; no review result issued on your own work.
