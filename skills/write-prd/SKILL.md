---
name: write-prd
type: agent-guide
description: >-
  Write a PRD — a product-intent artifact a spec may later be written from:
  the problem, who it affects, the outcomes that define success, and what is
  deliberately out of scope. ALWAYS apply when new product behavior needs its "why" written
  down before anyone drafts requirements. Never write requirements, strength words,
  or solution mechanisms into a PRD. Skip when the intent is already clear enough
  to spec directly — then write the spec.
---

# Writing a PRD

`DISRESPEC-SPINE: One fact once. No filler, repeated source material, empty sections, or chat restatement; after successful creation return only clickable artifact links, except for blockers, failed creation, incomplete verification, or irreversible-action confirmation.`

A PRD records **what outcome is wanted and why**. The spec written from it records what the
system must do. Keeping the two apart gives later requirements a traceable origin while the work
is active; project governance decides whether the PRD itself becomes a durable team record.

A PRD has these sections: **Problem · Users · Goals · Non-goals · Success metrics · Release constraints · Linked evidence** (walked below). Fill them — this guide is how to fill them well.

## The one boundary

Every sentence in a PRD sits on the **intent** side of one line:

- **Intent** — a problem, an affected group, a desired outcome, a delivery limit. Belongs here.
- **Requirement or mechanism** — what a component must do, or how it does it. Belongs in the
  spec (or an RFC, if the approach is still being argued).

A PRD that says "users need a Redis cache for sessions" has crossed the line twice: it named a
mechanism (Redis) and implied a requirement. The PRD's version is "session lookups stay fast
under load" — the spec decides what "fast" means and the design decides how.

## Section by section

- **Problem.** What is wrong or missing, and for whom it hurts — in plain prose, naming no fix,
  feature, or API. A problem statement that smuggles in a solution pre-commits every reader to a
  mechanism nobody ever weighed against alternatives.
- **Users.** Who is affected and which group the outcome serves. A population, not an actor —
  "checkout abandoners on mobile", never "the cart service must…".
- **Goals.** Outcome statements: the results that define success. No strength words (must /
  must not / should / may) — a goal worded as a requirement reads as an approved contract that
  nobody approved. Goals seed requirements; they are not requirements.
- **Non-goals.** State the outcomes deliberately outside this intent. If none are known, say
  `None identified` instead of inventing one. The explicit boundary lets a spec author distinguish
  a deliberate exclusion from an oversight.
- **Success metrics.** A table — metric, target, how observed. Each row names _how you'd see
  it_: a number, a dashboard, a query. "The feature feels faster" strands its goal with no path
  to evidence; "p95 checkout time under 2 s, from the existing latency dashboard" doesn't.
- **Release constraints.** Limits on _shipping_ — dates, rollout staging, compliance windows,
  dependency freezes. Not limits on what the solution may do; those are the spec's constraints.
- **Linked evidence.** Point at the research, findings, or data that ground the intent by stable
  path or native-artifact identifier. Avoid duplicating evidence that has an authoritative home.

## Where it lives

A PRD lives beside the spec it will feed — a flat file next to the spec artifact.

Place the file under `~/.agents/artifacts/<workspace>/`, resolving `~` to the absolute
home path and deriving `<workspace>` from the repository or working-directory basename. Keep it
out of the repository and carry its absolute path forward. If the workspace name or target path
conflicts with unrelated work, stop for a structured human choice; never overwrite. If the root is
unwritable, offer grant access and retry, another agent-neutral user directory, or cancel. Never
fall back to vendor storage, the repository, or a temporary directory.

Its frontmatter `type: prd` is what distinguishes it; the spec that follows names the PRD
in its `sources:`.

## Common mistakes

- A goal written as "the system must…" — restate it as the outcome; let the spec author mint
  the requirement.
- An unexplained Non-goals section — record real exclusions or `None identified`; do not invent one.
- A metric with no observation method — if you can't say how you'd see it, you can't later
  claim you hit it.
- A delivery constraint that actually constrains the design ("must use the existing queue") —
  that belongs in the spec, decided there with everything else.
- Treating the PRD as the spec — agents don't build from PRDs. A PRD acquires force only when
  someone writes the spec from it.

## Gotchas

- **Wrote a requirement into the PRD.** A goal phrased "the system must validate the token" is
  a requirement wearing a goal's clothes — it reads as an approved contract nobody approved, and
  the spec author inherits a decision instead of making one. The PRD holds the outcome ("invalid
  sessions never reach checkout"); the spec mints the requirement.
- **Wrote a strength word.** A single must / should / may anywhere in Goals or Problem turns
  intent into obligation. This slips in constantly — nothing checks it for you; re-read
  every goal as "is this a result or a rule?"
- **Wrote the solution mechanism.** "Cache sessions in Redis" names a fix nobody weighed against
  alternatives and pre-commits every reader to it. A PRD is the *why*, not the *what*: state the
  outcome ("session lookups stay fast under load") and let the design choose the mechanism.

## Before you finish

- [ ] No requirement language anywhere: search the file for "must", "must not", "should",
      "shall" — every hit is either rewritten as an outcome or moved out.
- [ ] Problem and Goals name no mechanism, fix, or API.
- [ ] Non-goals records real exclusions or `None identified`.
- [ ] Every success-metric row says how it is observed.
- [ ] Release constraints limit shipping, not the solution space.
- [ ] Evidence is linked by file/ID, not pasted.

These checks are a convention — nothing in this repository enforces them; the reviewer of the
eventual spec is who benefits.

## Next

When the intent is settled, write the spec from it (the `write-spec` skill) and list this PRD in the
spec's `sources:`. If the _approach_ is still contested, an RFC comes between the two.
