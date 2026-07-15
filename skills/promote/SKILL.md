---
name: promote
description: Move transient working material into project-owned permanence. Apply only when that material must become durable. Skip transient relocation and already-durable material.
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
4. Present real project-owned destinations. Wait for human selection. Make commit a separate choice.
   Reject collisions and blocked destinations before mutation.
5. Preflight the selected destination, transformed artifact, repaired references, links, format, and
   project checks in isolation. Mutate nothing unless the preflight passes.
6. Apply the preflighted move and reference repairs. Keep a recovery copy until destination,
   references, and complete source removal verify. Copy only when the human explicitly needs both
   versions.
7. Commit only when selected. Never push implicitly.

Reject transient-to-transient moves and invented destinations. On failure, restore every removed
source and repaired reference, remove the destination, then verify rollback. Report anything rollback
could not restore. Return the durable absolute path or the blocker.
