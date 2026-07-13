# Changelog

All notable changes to the Suspec skills catalog are recorded here. The format follows
[Keep a Changelog](https://keepachangelog.com/en/1.1.0/), and the catalog is versioned with
[semantic versioning](https://semver.org/spec/v2.0.0.html): a **major** bump removes or
renames a skill or breaks a skill's contract, **minor** adds a skill or non-breaking guidance,
**patch** is a fix or wording change.

The catalog is pull-updatable — install it for your runner (for example,
`npx skills add jcosta33/suspec-skills -g -a codex`), pin to a tag or commit for stability,
and re-run to re-fetch. Watch the
[releases](https://github.com/jcosta33/suspec-skills/releases) and re-pull when a bump matters.

## [Unreleased]

### Changed

- The catalog surface is `bulletproof`, `demolition`, `dissect`, `disrespec`, `promote`, `remember`,
  `revolver`, `triple-check`, `sus-audit`, `sus-change-plan`, `sus-inventory`, `sus-research`,
  `sus-review`, `sus-spec`, and `sus-task`. Each skill installs alone; no aliases ship.
- `sus-spec` now distinguishes plain Markdown requirements from flush-left SOL blocks, and
  `sus-task` requires a governing spec, supports all requirement ID classes, and records CI proof
  as `CI: https://...`.
- Ordinary Suspec artifacts use `~/.agents/artifacts/<workspace>/` so local agents share one
  transient file without repository changes, copies, or symlinks. Full-path handoffs remain.
- `promote` remains durable-only; it does not relocate files between transient roots.
- `revolver` creates no artifact. It derives at least six target-specific stances, runs one fresh
  reviewer at a time, and requires every finding to be addressed before the next stance sees the
  current target.
- Fixed commands execute or report a concrete blocker without carrying irrelevant decision-picker
  boilerplate. `dissect` now states its bounded return directly instead of warning against unrelated
  artifact workflows.
- Released sections remain byte-for-byte historical; current corrections stay under Unreleased.

## [4.0.0] - 2026-07-10

### Changed

- **Placement is described, never prescribed** (breaking): every artifact-authoring skill now
  carries one canonical placement paragraph — place the file next to your own native artifacts,
  in a folder named after the repo you are working on (or wherever fits your harness best), and
  carry the full path forward. The store, its environment/config resolution, and launch-prompt
  path handover are gone from every skill.
- **`save-findings` routes durable lessons to native harness memory** (breaking): one claim per
  memory, evidence attached, searchable title, written the way the harness records memories.
  Ephemeral findings ride the review packet. The finding artifact and its triage flow are gone.
- **Checking is path-explicit**: a spec or change plan is checked with `suspec check <path>`; a
  review packet with `suspec check <review-path> --spec <spec-path> --task <task-path>`. Task
  templates and core-loop skills hand every artifact over by explicit full path.

## [3.0.0] - 2026-07-09

### Added

- The **Suspec methodology group** — the full skill family that runs the Suspec loop, relocated
  into this catalog from the starter kit so one global install carries the whole methodology:
  `implement-task`, `review-output`, `spec-check`, `split-work`, `save-findings`, `write-spec`,
  `write-prd`, `write-rfc`, `write-research`, `write-audit`, `write-inventory`,
  `write-change-plan`, `write-bug-report`, `write-feature`, `write-fix`, `write-refactor`,
  `write-rewrite`, `write-migration`, `write-performance`, `write-testing`,
  `write-documentation` (21 skills).

### Changed

- **Suspec v2 artifact model** (ADR-0137) across the relocated skills: artifacts are transient
  personal working files in the store (`~/.claude/state/<repo-name>/`), handed to agents by
  absolute path in the launch prompt — the committed workspace, the board (`status.md`), the
  flow folders (`specs/`, `tasks/`, `reviews/`, `findings/`, `intake/`), and the in-repo
  `.suspec/` state dir are gone. Durability happens by promotion: decisions to ADRs, behavior
  to tests, findings to GitHub issues (triaged at `suspec done`), the evidence digest to a PR
  comment. Each skill's discipline (refute-by-default, evidence rules, scope rules) is
  unchanged.
- `save-findings` — findings are store artifacts triaged at `suspec done`
  (promote / keep-with-expiry / discard); the board update is gone.
- `review-output` — the review packet is a store artifact; reconcile against the spec; no board
  row to close.
- `implement-task` — the task packet and spec arrive by absolute store path in the launch
  prompt; the spec-external `.suspec/` mode is gone.
- README — two catalog groups (Suspec methodology / universal disciplines); global install
  (`npx skills add jcosta33/suspec-skills -g`, or manual copy to `~/.claude/skills` +
  `~/.agents/skills`) is the primary path; per-repo install stays for pinning; the zero-overlap
  rule (global = methodology, in-repo = repo-specific guides) is stated.

## [2.0.0] - 2026-07-05

### Removed

- **`adversarial-review`** — removed as a standalone skill. Its refute-by-default stance and
  adversarial procedure are now folded into `revolver-review` (Suspec ADR-0132), so there is no
  longer a skill for one skill to depend on. This is the major-bump trigger: the catalog no longer
  ships a skill it shipped in 1.1.0.

### Changed

- **`revolver-review` — rewritten to the rotating adversarial refine-loop** (Suspec
  [ADR-0132](https://github.com/jcosta33/suspec/blob/main/docs/adrs/0132-revolver-rotating-refine-loop.md),
  refined by [ADR-0133](https://github.com/jcosta33/suspec/blob/main/docs/adrs/0133-examine-dont-ruminate.md)).
  It is no longer a bounded panel that picks a few lenses, runs them blind and isolated, and stops
  when marginal findings dry up. It now cycles a pool of **at least 6 distinct stances one reviewer
  at a time** on cheap, varied models; the orchestrator **fixes between rounds** and the next stance
  reviews the **revised** change; up to 3 cycles per unit; it stops when a **full rotation surfaces
  nothing new**. It absorbs the refute-by-default adversarial stance directly — a contract change,
  not a wording tweak.
- **Purged all skill-to-skill references** (Suspec
  [ADR-0134](https://github.com/jcosta33/suspec/blob/main/docs/adrs/0134-self-contained-spine.md)):
  no skill names or assumes another skill is installed. Every skill is now self-contained.

As of 2.0.0 the catalog ships: `bulletproof`, `codebase-exploration`, `concise-output`, `debugging`,
`empirical-proof`, `fix-flaky-test`, `git-pr`, `market-research`, `persona-challenger`,
`planning-spec`, `revolver-review`, `security-review`.

## [1.1.0] - 2026-07-02

### Added

- **`bulletproof`** — a persona-free, evidence-gated critique protocol for hardening a claim,
  decision, spec, or plan: expose unsupported claims, hidden assumptions, failure modes,
  disconfirming tests, and kill criteria; the verdict gates on already-run evidence, never
  confidence or consensus. Read-only, reconcile-only, manually invoked.
- **`revolver-review`** — the bounded, lead-orchestrated multi-lens review strategy: a lead picks
  a few distinct lenses from a menu by risk, runs them blind and isolated (draft-before-compare),
  reconciles their candidate findings, and stops when marginal unique findings dry up. The
  orchestration around `adversarial-review`; a human owns the verdict.

### Changed

- **Re-baselined the catalog to the universal set, 2026-06-27.** The catalog is now
  universal-only — skills that hold for any repo regardless of the Suspec workflow — per
  **[Suspec ADR-0112](https://github.com/jcosta33/suspec/blob/main/docs/adrs/0112-two-tier-skills.md)**.
  Added from a live adoption census: `codebase-exploration`, `concise-output`, `debugging`, `git-pr`,
  `planning-spec`, `security-review`, `market-research`, and `adversarial-review` (which now carries both the
  refute-by-default stance and the review procedure). As of 1.1.0 the catalog ships:
  `adversarial-review`, `bulletproof`, `codebase-exploration`, `concise-output`, `debugging`,
  `empirical-proof`, `fix-flaky-test`, `git-pr`, `market-research`, `persona-challenger`,
  `planning-spec`, `revolver-review`, `security-review`.

### Moved

- **The `write-*` depth guides and `implement-task` moved to the starter kit** (ADR-0112): the
  Suspec-workflow guides — `write-feature`, `write-fix`, `write-refactor`, `write-rewrite`,
  `write-migration`, `write-performance`, `write-testing`, `write-documentation`, and
  `implement-task` — now live in `suspec-starter-kit` at `.agents/skills/`, not in this catalog.

## [1.0.0] - 2026-06-22

First versioned release. The catalog ships **14 skills**: the cross-cutting conditioning stances
`persona-skeptic`, `persona-challenger`, `persona-surveyor`, and `empirical-proof`; the
code-authoring depth guides `write-feature`, `write-fix`, `write-refactor`, `write-rewrite`,
`write-migration`, `write-performance`, `write-testing`, `write-documentation`, `fix-flaky-test`;
and `implement-task`.

This baseline reflects two recent decisions:

- **[Swarm ADR-0093](https://github.com/jcosta33/swarm/blob/main/docs/adrs/0093-collapse-1to1-personas.md)** — the four 1:1 authoring personas (architect / auditor / researcher / documentarian) were
  collapsed into their work guides (single source); the catalog keeps only the cross-cutting trio
  plus `empirical-proof`, each rebuilt grounding-first (a stance's leverage is the external
  evidence it forces, not a role label).
- **Reference-load wiring** — every guide that bundles a `references/` file now carries a Rule-0
  load directive (a point-of-need 1-hop link; top-of-body for the work guides), so the reference is
  actually loaded rather than merely listed.
