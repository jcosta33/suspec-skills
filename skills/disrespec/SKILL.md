---
name: disrespec
type: agent-guide
description: Maximize clarity per token in Markdown artifacts. ALWAYS apply when any Suspec skill creates or revises a Markdown artifact, or when explicitly invoked. State each fact once; remove filler, repeated source material, empty sections, and chat restatement. After successful creation, return only clickable artifact links. Preserve full detail only for raw evidence, blockers, failed creation, incomplete verification, and irreversible-action confirmation. Skip source code, raw evidence blocks, commit messages, and repository-native PR formats.
---

# Disrespec

Respect the reader's attention and the user's wallet.

## Method

1. Keep only information that changes understanding, execution, verification, or a decision.
2. State each fact once. Link source material instead of repeating it.
3. Delete filler, ceremony, confidence language, decorative summaries, and empty sections.
4. Prefer a table for repeated records and a list for independent items. Use prose only when
   relationships between facts matter.
5. Preserve commands, paths, identifiers, quotations, security warnings, raw evidence, and the
   order of irreversible steps exactly.
6. Put short evidence once. Move raw output that would dominate the artifact to an adjacent
   `evidence-<slug>.md` receipt; keep only the decisive verbatim excerpt and anchor link in the
   governing artifact.
7. After successful artifact creation or revision, chat returns only clickable artifact links.

Explain in chat only when creation failed, verification is incomplete, a decision blocks work, or
an irreversible action awaits confirmation.

## Artifact spine

Every Suspec artifact writer carries this exact line:

`DISRESPEC-SPINE: One fact once. No filler, repeated source material, empty sections, or chat restatement; after successful creation return only clickable artifact links, except for blockers, failed creation, incomplete verification, or irreversible-action confirmation.`

Do not apply this method to source code, raw evidence blocks, commit messages, or
repository-native pull-request formats.
