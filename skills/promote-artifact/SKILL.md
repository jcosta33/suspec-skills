---
name: promote-artifact
type: agent-guide
description: Promote a whole transient artifact into a project-native durable destination. Apply only when explicitly asked to promote, preserve, make permanent, or commit an artifact. Discover destinations, present structured choices, sanitize private content, move by default, repair references, validate, and optionally commit when selected. Never create a registry, Suspec store, lifecycle state, CLI/MCP surface, or implicit push. Skip extracting individual lessons; use save-findings for that.
---

# Promote artifact

`DISRESPEC-SPINE: One fact once. No filler, repeated source material, empty sections, or chat restatement; after successful creation return only clickable artifact links, except for blockers, failed creation, incomplete verification, or irreversible-action confirmation.`

## Method

1. Confirm the source exists and identify every inbound and outbound reference.
2. Inspect project governance and existing durable channels. If the source is already durable,
   return it unchanged.
3. Scan for secrets, private paths, transient state, raw prompts, personal data, and stale links.
   Block on sensitive content.
4. Present project-native destination choices with the recommendation first, tradeoffs, and `Other`.
   Include commit as a separate selected behavior where relevant.
5. Sanitize the selected form. Move by default; copy only when the human explicitly needs both.
6. Repair references and validate links, format, and project checks.
7. Commit only when selected. Never push implicitly.

Create no promotion registry, state field, owned directory, CLI verb, MCP tool, or lifecycle record.
