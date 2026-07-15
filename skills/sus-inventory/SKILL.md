---
name: sus-inventory
description: Reconstruct an unfamiliar or change-critical code area from evidence. ALWAYS apply when wide change needs a durable current-state map before work begins. Map reality without judgment or prescription. Skip direct implementation and small isolated work with a proven map.
---

# Sus Inventory

Map reality. Invent nothing. Prescribe nothing.

Enter on explicit inventory request or after the human selects a Suspec inventory workflow for a
durable current-state map.

## Place

Resolve `~/.agents/artifacts/<workspace>/` to an absolute path. Derive `<workspace>` from the
repository or working-directory basename. Write there with `type: inventory` and a unique `INV-`
ID; keep linked sidecars beside it. A collision or ambiguous workspace requires human-readable name
choices. A blocked write requires: grant access and retry, choose another agent-neutral user
directory, or cancel. Never overwrite or fall back to a repository, vendor directory, or temporary
path.

Start with:

```yaml
---
type: inventory
id: INV-{{slug}}
---
```

## Map

1. Lock scope and exclusions to the coming change.
2. List current modules: path, observed responsibility, evidence.
3. List current interfaces: signature or surface, direct and dynamic callers, observed contract,
   evidence.
4. Record externally visible behavior with tests, `file:line`, or decisive command output.
5. Map data, state, side effects, persistence, generated surfaces, configuration, and external
   consumers.
6. List existing tests and the behavior each actually controls.
7. Expose unknowns with exact search boundaries and missing evidence. If none surfaced, state
   `None found` and the boundary checked.

Search callers and string registrations. Run safe checks for dynamic claims. Zero-caller and
no-match claims require command and result. Every sentence must fit:
`this exists; it behaves this way; here is the evidence.`

Ambiguous scope blocks mapping.

Strip severity, prescriptions, target architecture, and implementation steps. Write each fact once.
Hand off absolute paths for the inventory and every sidecar. After the artifact is fully actioned and no downstream step needs it,
require one human disposition for it and its sidecars: Delete, Leave, or Promote.
Delete selection confirms removal. Verify every selected path is absent; failure blocks close and
reports survivors.
