# The design behind these skills

This directory records why the catalog uses its current skill shape. It separates
specification requirements, official guidance, empirical results, and local conventions so
contributors can tell which claims are binding and which remain design choices.

| Document | Question it answers |
| --- | --- |
| [Activation](./activation.md) | How should a description make the trigger and exclusions clear? |
| [Body anatomy](./body-anatomy.md) | What belongs in `SKILL.md`, and what moves to bundled references? |
| [Execution](./execution.md) | How does a skill make completion claims inspectable? |
| [Self-containment](./self-containment.md) | How does one installed skill work without the rest of the catalog? |
| [Task files](./task-files.md) | When does an execution skill need private run notes? |
| [Scope](./scope.md) | What belongs in this repository? |
| [Sources](./sources.md) | What evidence supports the guidance? |

## Design summary

- A description names the work, the triggers, the refused shortcut, and adjacent work it does
  not claim.
- A body carries the complete runnable discipline. Bundled references hold fillable or lookup
  material that is useful only after activation.
- A completion claim is paired with visible evidence. Commands come from the consuming
  repository, not from this catalog.
- Each skill works when installed alone.
- Specs, task packets, and reviews use the agent's native artifact location unless project
  governance places them elsewhere. Execution run notes are private working state, not task
  packets or project records.
- Suspec always has intent, review, and findings. Specs, task splits, inventories, change plans,
  and deterministic checkers are scaffold used when the work earns them.

The source ledger is updated with any guidance change that depends on new evidence. Unsupported
or superseded claims are removed from the public guidance rather than repeated as folklore.
