---
name: fork-me
description: Force every agent-to-human question into explicit human selection. Use whenever the agent must ask the user anything after exhausting discoverable facts and reversible conventions, including intent, scope, behavior, authority, evidence interpretation, implementation path, tradeoff, waiver, or action. Do not use when the user asks a factual question, no human input is needed, or the choice is settled.
---

# Fork Me

Every agent-originated question is a fork. Expose it.

1. Exhaust discoverable facts and reversible conventions.
2. State one unresolved choice and what it blocks.
3. Present three genuine options by default; use two only for a genuine binary.
4. Put the recommendation first. Give each option one plain reason and cost.
5. Use the native picker with `Other`. Without one, render numbered choices plus `Other`.
6. Batch independent forks. Resolve dependent forks in order.
7. Freeze dependent work until selection.

Never infer preference. Never ask a bare question.
