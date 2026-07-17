---
name: sus-audit
description: Audit present code against direct evidence. Use when running debt surveys, cleanup assessments, single-implementation benchmarks, current-state quality assessments, or fresh passes over prior audits without a governing spec or task. Do not use for conformance review, rotating adversarial review, or option research.
---

# Sus Audit

Observe. Prove. Prescribe nothing.

## Method

1. Lock the goal, surface, and exclusions.
2. Freeze repository state.
3. Inspect source, callers, tests, configuration, generated surfaces, and runtime wiring. Trace any
   unfamiliar or dangerous code path to closure before assessing it.
4. Run safe checks for dynamic claims. Record exact commands, exits, and decisive output.
5. Anchor every observation to `file:line`, search result, or pasted output.
6. Express each risk as evidence, failure mode, firing condition, and blast radius.
7. Grade Blocker, Major, or Minor by impact and reach.
8. Expose unverified areas and missing evidence.

Re-derive current state before reading a prior audit's framing. Recheck every retained citation.

Negative structural claims require a whole-scope search and result. Dynamic behavior requires a run;
static reading cannot prove timing, concurrency, cleanup, or lifecycle. If no supported risk exists,
write `None observed in scope` instead of inventing one.

## Artifact

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

## Output

Before handoff, compress and harden the document without changing its contract, identifiers,
verbatim source text, evidence, or behavior. Remove repetition, softness, ceremony, and structural
bloat; write each fact once. Rerun applicable checks. Hand off absolute paths for the audit and every
sidecar.

## Boundaries

Force material ambiguity in audit boundaries into explicit human selection. Block the audit until
selection.

Strip fixes, target states, requirements, and recommendations.

## Close

After the artifact is fully actioned and no downstream step needs it, require one human disposition
for it and its sidecars: Delete, Leave, or Promote. If Promote is selected, move the transient
working material into project-owned permanence.
Delete selection confirms removal. Verify every selected path is absent; failure blocks close and
reports survivors.
