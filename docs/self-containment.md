# Self-containment

Installed alone means working alone. Every skill must survive as the only installed Suspec skill.

- Carry load-bearing instructions in its `SKILL.md` or bundled references.
- Depend on no sibling, external decision record, shared boilerplate, repository file, alias, or
  hidden convention.
- Route adjacent work by task type.
- Use roles and absolute paths.
- Keep references inside the skill directory and link them directly.
- State placement and close only in artifact authors.

Isolation test: copy one skill directory into an empty catalog, validate metadata and links, then run
the method without any other Suspec content. A sibling dependency is a broken package boundary.
