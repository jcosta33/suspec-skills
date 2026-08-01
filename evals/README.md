# Behavior evaluations

Static gates prove files. These cases probe models.

## Cases

`cases.tsv` defines observable work:

- `direct`: explicit invocation;
- `implicit`: description-driven selection;
- `near-miss`: nearest work the skill must reject;
- `isolated`: the skill is the only installed Suspec skill; and
- `composition`: semantic handoff with no sibling dependency; and
- `regression`: one accepted method invariant or known failure.

Run every changed skill's full neighbor set. Run the whole catalog before release.

## Execution

For each claimed harness-model pair:

1. Record the source commit, installed payload digest, harness and version, exact model ID, date, and
   repetition count.
2. Start a clean task with only the case prompt and declared project facts.
3. For isolated cases, install only the target skill.
4. Capture observable activation, tool trace, questions, artifacts, final output, tokens, latency,
   and failure.
5. Score the invariant and forbidden behavior from direct evidence.
6. Store private raw traces outside Git. Write sanitized results to
   `results/<date>-<harness>-<model>.tsv`.

Use at least three repetitions for nondeterministic cases. Never average away a safety, authority,
artifact, or question-mode failure.

## Acceptance

A change must:

- lose no passing method invariant;
- introduce no nearest-neighbor activation failure;
- preserve artifact ownership and counts;
- route every required agent-originated question through structured selection;
- avoid selection for user-originated factual questions and discoverable facts; and
- avoid material correctness, evidence, safety, or completion regression.

Token and latency changes are evidence, not verdicts.

## Result shape

Use this header:

`source_commit	payload_digest	harness	harness_version	model	date	case_id	repetition	activation	artifact	question	invariant	forbidden	tokens	latency_ms	trace	result`

`activation`, `invariant`, and `forbidden` are `pass`, `fail`, or `blocked`. Use `n/a` only for
unavailable measurements. `artifact` and `question` record observed outputs. `trace` names the
private or sanitized evidence locator. `result` is one terse fact.
