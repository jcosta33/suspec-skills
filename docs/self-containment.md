# Self-Containment

Every skill must work when it is the only catalog skill installed.

## Rules

- Carry every load-bearing instruction in `SKILL.md` or that skill's own bundled reference.
- Never require another catalog skill, external decision record, shared boilerplate, or
  repository-relative source.
- Route adjacent work by task type, never by another command name.
- Use artifact roles and absolute paths, never assumed vendor folders or implicit shared context.
- Only artifact authors state placement and lifecycle close.
- Cross-cutting conditioning may co-activate but cannot carry a writer's core contract.
- References stay inside the skill directory and are linked directly from `SKILL.md`.

## Isolation Test

Copy one skill directory into an empty catalog. Its metadata must activate correctly; every linked
reference must resolve; its method must run without another Suspec skill, repo document, alias, or
hidden convention.
