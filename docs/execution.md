# Execution

Loading a skill does not prove that every step ran. Completion must be tied to evidence another
reader can inspect.

## Visible evidence

When a skill asks an agent to validate a claim, it also defines the output that records the result.
Examples:

| Claim | Required evidence |
| --- | --- |
| a test suite passes | verbatim runner summary from the post-edit run |
| a defect is reproduced | the failing command and output before the fix |
| a requirement is satisfied | a review row tied to the requirement and rerun evidence |
| a source supports a finding | a resolvable citation and the source's relevant result |
| a deleted symbol has no callers | the exact search and its empty result |

The pattern addresses an execution failure described in practitioner analysis: an agent may load a
skill, skip a late verification step, and still produce plausible completion prose
[[4]](./sources.md#4). That observation motivates the design; it does not establish a universal
failure rate.

## Catalog rules

1. **Resolve commands from the consuming repository.** Read its `AGENTS.md`, contributor docs, or
   package metadata. Never invent a toolchain command.
2. **Run after the last relevant edit.** Earlier output no longer describes the current state.
3. **Paste rather than paraphrase.** A summary written by the agent is a new claim, not the tool's
   evidence.
4. **Match proof to claim.** A focused test proves its named behavior; it does not prove the full
   suite, build, or unrelated requirements.
5. **Make failed verification visible.** Preserve the command, output, and resulting status instead
   of converting an unknown into a pass.
6. **Use the right falsification.** A new test must be shown to fail for the intended reason before
   the production behavior exists. This does not require mechanically flipping every assertion.
7. **Review independently.** A reviewer reruns every applicable `Verify with:` item against the code
   being judged. Implementer output is an indexed claim, not review evidence.

## Working state

Written plans and notes can preserve progress across long runs
[[20]](./sources.md#20)[[21]](./sources.md#21)[[23]](./sources.md#23). Use them when they change
execution. Do not infer a prescribed filename set or turn private run notes into durable project
records.

## Completion checklist

- Every completion claim has evidence from the current state.
- Every command is shown with enough verbatim output to identify the command's result.
- Failed, unavailable, and inapplicable checks are distinguished.
- No evidence was inherited from another agent without an independent rerun where rerunning was
  possible.
