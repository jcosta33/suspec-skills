---
name: sus-audit
description: Audit present code against direct evidence. ALWAYS apply to debt surveys, cleanup assessments, single-implementation benchmarks, current-state quality assessments, and fresh passes over prior audits when no governing spec or task defines conformance. Skip conformance review, rotating adversarial review, and option research.
---

# Sus Audit

Observe. Prove. Prescribe nothing.

## Place

Resolve `~/.agents/artifacts/<workspace>/` to an absolute path. Derive `<workspace>` from the
repository or working-directory basename. Write there with `type: audit` and a unique `AUDIT-` ID.
A collision or ambiguous workspace requires human-readable name choices. A blocked write requires:
grant access and retry, choose another agent-neutral user directory, or cancel. Never overwrite or
fall back to a repository, vendor directory, or temporary path. Keep linked sidecars beside the
audit.

Start with:

```yaml
---
type: audit
id: AUDIT-{{slug}}
---
```

## Method

1. Lock the goal, surface, and exclusions.
2. Freeze repository state.
3. Inspect source, callers, tests, configuration, generated surfaces, and runtime wiring.
4. Run safe checks for dynamic claims. Record exact commands, exits, and decisive output.
5. Anchor every observation to `file:line`, search result, or pasted output.
6. Express each risk as evidence, failure mode, firing condition, and blast radius.
7. Grade Blocker, Major, or Minor by impact and reach.
8. Expose unverified areas and missing evidence.

Re-derive current state before reading a prior audit's framing. Recheck every retained citation.

Negative structural claims require a whole-scope search and result. Dynamic behavior requires a run;
static reading cannot prove timing, concurrency, cleanup, or lifecycle. If no supported risk exists,
write `None observed in scope` instead of inventing one.

Ambiguous boundaries block the audit.

Strip fixes, target states, requirements, and recommendations. Write each fact once. Hand off
absolute paths for the audit and every sidecar. After the artifact is fully actioned and no downstream step needs it, require one
human disposition for it and its sidecars: Delete, Leave, or Promote.
Delete selection confirms removal. Verify every selected path is absent; failure blocks close and
reports survivors.
