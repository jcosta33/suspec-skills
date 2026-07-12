# Run-note templates

Several execution skills bundle `references/task-template.md`. The filename is part of the shipped
skill layout; the instantiated document is **run notes**, not a Suspec task packet.

## Distinction

| Artifact | Purpose | Owner |
| --- | --- | --- |
| Suspec task packet | a scoped dispatch artifact created when work must be split | the work coordinator |
| execution run notes | private state for one implementation run | the implementing agent |
| deliverable | code, test, documentation, or another requested output | the project |

A task packet may be an input to run notes. The run-note template therefore records both paths
separately. It never labels its own path as the task packet.

## Placement

Run notes live under `~/.agents/artifacts/<workspace>/`. Resolve `~`, derive
`<workspace>` from the repository or working-directory basename, and carry the absolute
path through the session. Do not edit `.gitignore` or commit private run notes; use explicit
durable promotion when the whole document must enter a project channel.

## When a template helps

Bundle a template when the skill routinely needs state that is expensive to reconstruct, such as:

- a baseline and repeated measurement protocol;
- a reproduction and hypothesis trail;
- transformation checkpoints and rollback state;
- callsite or compatibility tracking; or
- multiple verification outputs tied to separate requirements.

No numeric threshold decides this. The question is behavioral: will persistent notes materially
reduce lost state, repeated work, or false completion on realistic runs? If not, keep the procedure
in `SKILL.md`.

## Template contract

Every execution run-note template begins with its own identity and any dispatch packet:

```markdown
# Run notes: {{title}}

- Run notes: {{absolute path to this file}}
- Task packet: {{full path, when the work was dispatched from one; otherwise None}}
```

The next fields identify the discipline's actual driving inputs: a spec, change plan, bug report,
audit, or other driving document as applicable. The template then carries only state needed by that
execution discipline. Common sections include scope, progress, evidence, decisions, and self-review.
A specialized skill may add a hypothesis tracker, measurement protocol, callsite table, or
equivalence checkpoints.

## Evidence boundary

Scratchpad and planning research supports explicit intermediate state for multi-step work
[[24]](./sources.md#24)[[25]](./sources.md#25). Anthropic documents structured note-taking, to-do
lists, progress files, and persistent task systems for long-running agents
[[20]](./sources.md#20)[[21]](./sources.md#21)[[23]](./sources.md#23). These sources support the
general technique; they do not prescribe this catalog's exact sections, filenames, or a universal
file set.

## Review checklist

- The instantiated file identifies itself as run notes.
- Task packet and spec inputs are separate fields and may be `None`.
- Placement uses the agent-neutral artifact workspace, never the repository.
- Every section preserves state the skill actually consumes later.
- The template does not duplicate a durable project artifact.
