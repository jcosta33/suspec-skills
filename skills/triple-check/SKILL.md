---
name: triple-check
description: Run exactly three fresh, target-derived, top-tier inspection passes for narrow depth. ALWAYS apply when asked to triple-check or obtain exactly three independent high-end checks of code, a diff, artifact, plan, or system. Default to a fixed read-only snapshot with peer reports hidden. Refine only when explicitly requested. Skip targeted code-path tracing without an explicit three-pass request. Reviewers never edit or issue a ship verdict.
---

# Triple-check

Three fresh minds. No shared story.

## Contract

- Pin the target state.
- Derive exactly three materially distinct stances from the target's highest-consequence risks.
- Use a top-tier model adequate for each pass.
- Default to read-only `inspect`. Use `refine` only on explicit request.
- Write one artifact with `type: inspection`, `method: triple-check`, and
  `target: <path-or-stable-identifier>`. Add `mode: refine` only when refine was explicitly
  requested.
- A substantive run requires that artifact. An explicit no-write or chat-only request conflicts
  with this method. Report the conflict and stop. Never write against the refusal or simulate
  Triple-check in chat.

Before creating the artifact, prove the harness can dispatch three fresh contexts. If it cannot,
report the blocker and stop. Never simulate independence in one context.

## Place

Resolve `~/.agents/artifacts/<workspace>/` to an absolute path, deriving `<workspace>` from the
repository or working-directory basename. Write under that resolved directory. Never write into the
repository, vendor storage, or an OS temporary directory. Never overwrite unrelated work. Choose a
distinct human-readable workspace or filename on collision. If the root is unwritable, report failed
creation and stop.

## Passes

1. Dispatch pass one with no peer report.
2. In inspect mode, hold the snapshot fixed and hide all peer reports through pass three.
3. In refine mode, verify findings, apply only evidence-backed fixes, pin the revised state, and
   dispatch the next fresh pass without prior prose.
4. Complete all three passes even when an earlier pass is quiet.
5. Reconcile by evidence. Preserve real disagreement and evidence gaps.

Never vote, merge three opinions into false certainty, or issue a ship verdict. Record each finding
once. When a downstream consumer remains, return only the clickable absolute artifact path. At true
lifecycle close, skip the path-only handoff and issue the disposition choice instead.

If this skill is the final consumer, a non-empty transient artifact set exists, no earlier
disposition prompt occurred, and no downstream step needs any transient artifact or sidecar created
or consumed by the active work, ask once about the complete transient set: Delete, Leave, or
Promote. Repository-native and other durable inputs never enter disposition. Include every transient
path. Never choose for the human.
