---
name: triple-check
description: Crush a narrow target through exactly three fresh top-tier passes. ALWAYS apply when asked to triple-check code, a diff, artifact, plan, or system. Each pass sees the current target and no peer prose. Fix and verify every real defect before the next pass. Leave only refutations and human decisions. Skip ordinary tracing without an explicit three-pass request.
---

# Triple-check

Three fresh minds. No defect survives by inertia.

1. Freeze the target state.
2. Derive exactly three materially distinct stances from its highest-consequence risks.
3. Dispatch one fresh top-tier reviewer for stance one. Give it the current target and no peer prose.
   If fresh top-tier dispatch is unavailable, stop. Self-review is invalid.
4. Kill every finding:
   - supported: apply the fix and run decisive verification when settled authority determines the
     fix; otherwise stop as a human decision;
   - refuted: reject it with evidence;
   - human decision: stop until selected;
   - unverified or blocked: obtain the missing evidence; if capability blocks it, stop the sequence.
5. After every finding resolves, freeze the addressed target. Dispatch the next fresh top-tier
   reviewer without prior prose.
6. Complete exactly three passes, even after a quiet pass.

Reviewers return location, consequence, evidence, and minimal fix. The orchestrator fixes and
verifies. An unresolved real defect blocks the next pass.

Return material fixes and verification, consequential refutations, and unresolved human decisions.
For each decisive run, include command, working directory, state identifier, numeric exit, and
untouched decisive output once.
