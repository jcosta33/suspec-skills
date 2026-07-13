---
name: promote
description: Move a transient artifact into project-owned permanence. Apply only when asked to promote, preserve, make permanent, or commit it. Find real destinations, block sensitive content, move by default, repair references, validate, and commit only when selected.
---

# Promote

Move the document. Leave no broken trail.

## Method

1. Confirm every selected artifact and sidecar. Find every inbound and outbound reference.
2. Inspect project governance and existing durable channels. If the source is already durable,
   return it unchanged.
3. Scan for secrets, private paths, transient state, raw prompts, personal data, and stale links.
   If sensitive content exists, stop with a binary choice: **Sanitize and retry** or **Cancel**.
   Recommend sanitization only when removal preserves the artifact's purpose.
   Change nothing until the human selects.
4. Present real project-owned destinations. Make commit a separate choice.
5. Move by default. Copy only when the human explicitly needs both versions.
6. Repair references. Validate links, format, and project checks.
7. Commit only when selected. Never push implicitly.

Reject transient-to-transient moves and invented destinations. Return the durable absolute path or
the blocker.
