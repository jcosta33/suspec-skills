---
name: promote
description: Move a whole transient artifact into a project-owned durable destination. Apply only when explicitly asked to promote, preserve, make permanent, or commit an artifact. Discover real project destinations, present structured choices, block sensitive content, move by default, repair references, validate, and optionally commit when selected. Never create a registry, lifecycle state, Suspec-owned durable location, CLI/MCP surface, or implicit push.
---

# Promote

Move the document. Do not write a document about the move.

Investigate discoverable facts before asking. Every material choice uses the native picker:
recommendation first, three genuine options by default or two when binary, one-sentence tradeoffs,
and automatic `Other`. Without a native picker, render the same numbered options plus `Other`.
Never ask a bare question. Batch only independent choices; ask dependent choices sequentially.

## Method

1. Confirm every selected artifact and sidecar exists. Find every inbound and outbound reference.
2. Inspect project governance and existing durable channels. If the source is already durable,
   return it unchanged.
3. Scan for secrets, private paths, transient state, raw prompts, personal data, and stale links.
   If sensitive content exists, stop with a binary choice: **Sanitize and retry** or **Cancel**.
   Recommend sanitization only when removal preserves the artifact's purpose.
   Change nothing until the human selects.
4. Present real project-owned destinations as the material choice. Offer commit as a separate
   selected behavior where relevant.
5. Move by default. Copy only when the human explicitly needs both versions.
6. Repair references. Validate links, format, and project checks.
7. Commit only when selected. Never push implicitly.

Never relocate between transient roots. Never invent a destination when the project has none; stop
with structured choices instead. Create no promotion report, registry, state field, owned directory,
CLI verb, MCP tool, or lifecycle record. Return only the clickable durable absolute path or the
blocker.
