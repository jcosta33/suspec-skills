---
name: drill
description: Lock one change from language through obligation, place, and slice before writing. ALWAYS use when those levels mix, implementation starts before place is locked, or a lower question fires while a higher lock is open. Do not use for a checked staged transformation.
---

# Drill

Lock the next seam. Write only that seam.

## Method

Work one level at a time. A higher lock that moves drops the in-flight slice.

1. **Language.** Name the thing in the project's words. Stop until the name is shared.
2. **Obligation.** Name the product, architectural, and operational guarantees for this slice:
   preservation, verify-with, and rollback. Do not open a staged transformation artifact.
3. **Place.** Name the files, symbols, and runtime boundary. When coupling is unproven, trace the
   path to closure first.
4. **Slice.** Name the smallest write that keeps the obligation. Then write it.

Prove discoverable technical questions from evidence. Structure remaining human-owned locks as
explicit choices. Do not ask a lower question while a higher lock is open.

Escalate when ordered waves plus rollback must outlive the session.

Native notes only. No `CONTEXT.md`. No Suspec artifact.

## Output

Return the four locks, the write, and the verify evidence as rendered Markdown. Keep evidence to the
smallest untouched decisive excerpt.
