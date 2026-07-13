# AGENTS.md - Suspec skills

This repository ships portable, self-contained Agent Skills in plain Markdown. Each folder under
`skills/` is independently installable. Evidence and catalog conventions live under `docs/`.

## Editing Rules

- One skill per `skills/<name>/SKILL.md`. Add `references/` only for material that skill loads on
  demand.
- Frontmatter contains `name` and a directive `description`. The description states the action,
  observable triggers, refusals, and adjacent task types it skips.
- Every skill works when installed alone. Never require another catalog skill, external decision
  record, shared boilerplate, or hidden repository context.
- Write commands as hard, concise instructions. Keep one fact in one place. Cut rationale the model
  does not need to execute correctly.
- Investigate discoverable facts before asking. Material ambiguity gets structured choices:
  recommendation first, genuine alternatives, one-sentence tradeoffs, and `Other`.
- Ordinary conversation and direct action create no Suspec artifact. Create one only when requested
  or required as a live workflow input.
- Artifact writers resolve `~/.agents/artifacts/<workspace>/` to an absolute path before writing,
  never using the repository, vendor storage, or an OS temporary directory.
- Ask Delete, Leave, or Promote only at true lifecycle close, after no downstream step needs the
  complete artifact-and-sidecar set.
- Skills name abstract command slots when needed. The consuming repository supplies actual commands.
- Skill payloads are Markdown only. Repository checks may use shell scripts; installed skills never do.
- Add or remove the matching `README.md` catalog row with every skill directory change.
- Preserve historical `CHANGELOG.md` entries.

## Verification

Run `sh scripts/lint-current.sh` and `sh scripts/lint-released-changelog.sh`. The first checks current
Markdown, links, frontmatter, exact membership, standalone references, and stale names. The second
protects released history.
