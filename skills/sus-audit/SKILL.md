---
name: sus-audit
description: Audit present code and expose its risk with exact evidence. ALWAYS apply to present-state code audits, debt surveys, cleanup assessments, single-implementation benchmarks, quality assessments, and fresh passes over prior audits. Observe and prove. Strip prescriptions, intended behavior, and unsupported claims. Skip multi-angle attacks and option research.
---

# Sus Audit

Observe. Prove. Prescribe nothing.

## Place

Resolve `~/.agents/artifacts/<workspace>/` to an absolute path. Derive `<workspace>` from the
repository or working-directory basename. Write there with `type: audit` and a unique `AUDIT-` ID.
A collision, ambiguous workspace, or blocked write requires human selection. Repository, vendor,
and OS temporary paths are invalid.

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

Strip fixes, target states, requirements, and recommendations. Write each fact once. Hand off the
absolute path. After the artifact is fully actioned and no downstream step needs it, require one
human disposition for it and its sidecars: Delete, Leave, or Promote.
