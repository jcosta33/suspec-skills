# AGENTS.md — Suspec skills

This repo is the skills catalog for the Suspec framework — the methodology
skill family plus the universal disciplines: self-contained agent guides in
the Agent Skills format, one folder per skill under `skills/`, with the
evidence behind their design under `docs/`. It is a derived-content repo —
methodology rules are canon in the Suspec repo's ADRs; skill content is
edited here.

## Editing rules

The rationale and evidence for each rule live in `docs/` (the rule names its page).

- One skill per folder: `skills/<name>/SKILL.md`, plus `references/` only for
  material the skill itself instantiates (session frames, templates).
- **The description rule** (`docs/activation.md`): the frontmatter `description`
  is the trigger and must be directive — open with the verb of the work, say
  when to ALWAYS apply, name what the skill refuses, end with a `Skip for …`
  clause naming task types (never sibling skill names).
- **The body-length rule** (`docs/body-anatomy.md`): bodies stay under the
  500-line catalog ceiling; depth used only after activation moves to
  `references/`. Rules include a brief rationale when it affects judgment.
- **The forced-output rule** (`docs/execution.md`): a verification step must
  require visible output (a paste, a table, a marker in the deliverable) — a
  step that only asks the agent to "verify" gets silently skipped.
- **Self-containment** (`docs/self-containment.md`): a skill must read
  correctly with no other file from this repo installed. Restate a load-bearing
  sibling rule inline; point at a sibling that _carries_ a discipline only as
  `../<name>/SKILL.md` with an explicit "if installed" marker. A plain mention
  that merely sends a different task elsewhere (`load fix-flaky-test, not this`)
  carries no dependency and needs no marker — the test is whether the skill
  still works when the named guide is absent. Artifacts are referenced by
  role ("the spec", "the task packet", "run notes"); a skill that places an artifact states
  the placement guidance — the placement paragraph, kept byte-identical
  wherever it appears across the catalog — and carries the file's absolute path
  forward, so every later step names artifacts by explicit path. Ordinary Suspec
  artifacts use `~/.agents/artifacts/<workspace>/`; native plans and memory do not.
  Run-note templates identify their own path separately
  from any input task packet. Anything else goes to the Suspec repo by name,
  never by relative path.
- Skills name abstract command slots (`cmdTest`, `cmdLint`, `cmdValidate`, …) —
  never a concrete toolchain command; the consuming repo's `AGENTS.md` supplies
  those. An empty slot means ask.
- Markdown only — no scripts, no executables, no network calls
  (`docs/scope.md`).
- The catalog table in `README.md` gains/loses a row with every skill
  added/removed.

## Commands

| Slot | Command | Resolves                                         |
| ---- | ------- | ------------------------------------------------ |
| —    | (none)  | markdown-only repo; content is checked by review |
