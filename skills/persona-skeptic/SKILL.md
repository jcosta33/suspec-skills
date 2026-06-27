---
name: persona-skeptic
type: agent-guide
description: Retired — merged into adversarial-review. The refute-by-default review stance, the re-run-from-a-clean-checkout lever, the adversarial questions, the Refuses red-flag table, and adversarial self-review at completion now all live in adversarial-review. Use that skill instead.
---

# Skill: persona-skeptic (retired)

This skill has been merged into [`adversarial-review`](../adversarial-review/SKILL.md). The two
overlapped: persona-skeptic was the refute-by-default *stance* and adversarial-review the *procedure*,
and the split forced loading both for one job. They are now a single best-in-class review skill.

**Use [`adversarial-review`](../adversarial-review/SKILL.md).** Everything persona-skeptic carried now
lives there:

- the **refute-by-default** stance (a claim is unproven until evidence forces the opposite conclusion);
- the **re-run-the-checks-yourself-from-a-clean-checkout** lever;
- the **adversarial questions** (including *what would falsify this?* and *did the change alter behavior
  outside its stated scope?*);
- the **required-evidence** list;
- the **Refuses** red-flag → action table;
- **adversarial self-review at completion** — turning the stance on your own work before declaring done,
  which yields fixes and a recorded critique, never a self-issued verdict.

One correction carried over in the merge: the outcome is **findings + evidence + a human-attention
list**, never a self-issued approval or sign-off — a human or an independent reviewer owns the
ship/merge call.
