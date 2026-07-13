---
name: revolver
description: Run a broad, purpose-agnostic inspection over code, diffs, artifacts, plans, or systems. ALWAYS apply when asked for a Revolver inspection, broad adversarial audit, or many-angle check. Derive every stance from the target, complete each rotation, and stop after a quiet rotation or three cycles. Default to fixed-snapshot inspect mode; refine only when explicitly requested. Reviewers never edit or issue a ship verdict.
---

# Revolver

Breadth comes from distinct attack surfaces, not a canned persona list.

Investigate discoverable facts before asking. Every material choice uses the native picker:
recommendation first, three genuine options by default or two when binary, one-sentence tradeoffs,
and automatic `Other`. Without a native picker, render the same numbered options plus `Other`.
Never ask a bare question. Batch only independent choices; ask dependent choices sequentially.

## Contract

- Pin the target state.
- Derive every materially distinct stance justified by requirements, trust boundaries, failure
  modes, changed surfaces, users, and operating conditions. Use no default menu or numeric floor.
- Default to read-only `inspect`. Use `refine` only on explicit request.
- Write one artifact with `type: inspection`, `method: revolver`, and
  `target: <path-or-stable-identifier>`. Add `mode: refine` only when refine was explicitly
  requested. Round logs may use sidecars.
- Reviewers report findings. The orchestrator alone applies verified fixes.

Before creating the artifact, prove the harness can dispatch fresh reviewer contexts. If it cannot,
stop for a material choice: enable fresh dispatch and retry; run each stance in a separate clean
task and return the reports; cancel. Never simulate independence in one context.

## Place

Resolve `~/.agents/artifacts/<workspace>/` to an absolute path, deriving `<workspace>` from the
repository or working-directory basename. Write under that resolved directory. Never write into the
repository, vendor storage, or an OS temporary directory. Never overwrite unrelated work. Stop with
structured choices on a collision or blocked write.

## Rotate

1. Dispatch one fresh reviewer per stance on the cheapest model adequate for that stance.
2. Give it the target, stance, scope, and evidence rules. Hide prior reviewer prose.
3. In inspect mode, keep the snapshot fixed.
4. In refine mode, verify findings, apply only evidence-backed fixes, and pin the revised state
   before dispatching the next reviewer.
5. Finish the entire rotation.
6. Start another rotation only when the completed rotation found something new.
7. Stop after one quiet rotation or three cycles, whichever comes first.

Reconcile duplicates and disagreements through evidence, never vote. Record findings once. Never
issue a ship verdict.

When a downstream consumer remains, return only the clickable absolute artifact path. At true
lifecycle close, skip the path-only handoff and issue the disposition choice instead. Prompt only
when this skill is the final consumer, a non-empty transient artifact set exists, no earlier
disposition prompt occurred, and no downstream step needs any transient artifact or sidecar created
or consumed by the active work. Ask once about the complete transient set: Delete, Leave, or Promote.
Repository-native and other durable inputs never enter disposition. Include every transient path.
Never choose for the human.
