---
name: sus-audit
description: Write an evidence-bound audit of what is true in a code area now and the risk that state carries. ALWAYS apply when asked for a present-state code audit, technical-debt survey, cleanup assessment, benchmark of one existing implementation, quality assessment, or a fresh pass over a prior audit. Stay observation-only. Never prescribe fixes, assert intended behavior, write requirements, or leave a claim without exact evidence. Skip multi-stance inspections and decision-informing comparisons or option research.
---

# Sus Audit

Observe. Prove. Stop before prescription.

Investigate discoverable facts before asking. Every material choice uses the native picker:
recommendation first, three genuine options by default or two when binary, one-sentence tradeoffs,
and automatic `Other`. Without a native picker, render the same numbered options plus `Other`.
Never ask a bare question. Batch only independent choices; ask dependent choices sequentially.

Ordinary conversation and direct action create no audit. Write one only when requested or required
as a live workflow input.

## Place

Resolve `~/.agents/artifacts/<workspace>/` to an absolute path, deriving `<workspace>` from the
repository or working-directory basename. Write one artifact with frontmatter `type: audit` and a
unique `id` using the `AUDIT-` prefix under that resolved directory. Never write into the
repository, vendor storage, or an OS temporary directory. Never overwrite unrelated work. Stop with
structured choices on collision or blocked writes.

## Method

1. State the audit goal, in-scope surface, and exclusions.
2. Pin the repository state.
3. Inspect source, callers, tests, configuration, generated surfaces, and runtime wiring.
4. Run safe checks for dynamic claims. Record exact commands, exits, and decisive output.
5. Write stable observations. Every claim cites `file:line`, a search result, or pasted output.
6. Write each risk as evidence, failure mode, firing condition, and blast radius.
7. Calibrate risk as Blocker, Major, or Minor by impact and reach, never alarm or discovery effort.
8. Record open questions and unverified areas with the missing evidence.

When deepening a prior audit, ignore its framing until the current state has been re-derived. Verify
every old citation before retaining the claim.

Negative structural claims require a whole-scope search and result. Dynamic behavior requires a run;
static reading cannot prove timing, concurrency, cleanup, or lifecycle. If no supported risk exists,
write `None observed in scope` instead of inventing one.

If the audit boundary remains materially ambiguous after investigation, stop for a material
boundary choice.

Refuse fixes, target states, requirements, recommendations, and code edits. Write each fact once.
When a downstream consumer remains, return only the clickable absolute artifact path. At true
lifecycle close, skip the path-only handoff and issue the disposition choice instead.

Keep the audit while downstream planning or review needs it. If this skill is the final consumer, a
non-empty transient artifact set exists, no earlier disposition prompt occurred, and no downstream
step needs any transient artifact or sidecar created or consumed by the active work, ask once about
the complete transient set: Delete, Leave, or Promote. Repository-native and other durable inputs
never enter disposition. Include every transient path. Never choose for the human.
