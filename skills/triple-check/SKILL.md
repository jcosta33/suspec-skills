---
name: triple-check
description: Run exactly three fresh, target-derived, top-tier inspection passes for narrow depth. ALWAYS apply when asked to triple-check, deeply inspect, or obtain three independent high-end checks of code, a diff, artifact, plan, or system. Default to a fixed read-only snapshot with peer reports hidden. Refine only when explicitly requested. Reviewers never edit or issue a ship verdict.
---

# Triple-check

Three fresh minds. No shared story.

## Contract

- Pin the target state.
- Derive exactly three materially distinct stances from the target's highest-consequence risks.
- Use a top-tier model adequate for each pass.
- Default to read-only `inspect`. Use `refine` only on explicit request.
- Write one `type: inspection`, `method: triple-check` artifact.

Before creating the artifact, prove the harness can dispatch three fresh contexts. If it cannot,
stop with structured choices: enable fresh dispatch and retry; run three separate clean tasks and
return their reports; cancel. Recommend the best available option, explain each in one sentence,
and include `Other`. Never simulate independence in one context.

## Place

Resolve `~/.agents/artifacts/<workspace>/` to an absolute path, deriving `<workspace>` from the
repository or working-directory basename. Write under that resolved directory. Never write into the
repository, vendor storage, or an OS temporary directory. Never overwrite unrelated work. Stop with
structured choices on a collision or blocked write.

## Passes

1. Dispatch pass one with no peer report.
2. In inspect mode, hold the snapshot fixed and hide all peer reports through pass three.
3. In refine mode, verify findings, apply only evidence-backed fixes, pin the revised state, and
   dispatch the next fresh pass without prior prose.
4. Complete all three passes even when an earlier pass is quiet.
5. Reconcile by evidence. Preserve real disagreement and evidence gaps.

Never vote, merge three opinions into false certainty, or issue a ship verdict. Record each finding
once. Return only the clickable artifact path.

After the artifact and sidecars are fully actioned and no downstream step needs them, ask once:
Delete, Leave, or Promote. Recommend from state, explain each option in one sentence, and include
`Other`. Never choose for the human.
