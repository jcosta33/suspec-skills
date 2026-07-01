# Changelog

All notable changes to the Suspec skills catalog are recorded here. The format follows
[Keep a Changelog](https://keepachangelog.com/en/1.1.0/), and the catalog is versioned with
[semantic versioning](https://semver.org/spec/v2.0.0.html): a **major** bump removes or
renames a skill or breaks a skill's contract, **minor** adds a skill or non-breaking guidance,
**patch** is a fix or wording change.

The catalog is pull-updatable — you install it with `npx skills add jcosta33/suspec-skills` (pin to
a tag or commit for stability) and re-run to re-fetch. Watch the
[releases](https://github.com/jcosta33/suspec-skills/releases) and re-pull when a bump matters.

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

First versioned release. The catalog shipped cross-cutting conditioning and evidence
skills, plus the code-authoring depth guides `write-feature`, `write-fix`, `write-refactor`, `write-rewrite`,
`write-migration`, `write-performance`, `write-testing`, `write-documentation`, `fix-flaky-test`;
and `implement-task`.

This baseline reflects two recent decisions:

- **[Suspec ADR-0093](https://github.com/jcosta33/suspec/blob/main/docs/adrs/0093-collapse-1to1-personas.md)** — authoring disciplines live in their work guides; the catalog focuses on cross-cutting
  stances and evidence discipline, each grounding-first (a stance's leverage is the external evidence it
  forces, not a role label).
- **Reference-load wiring** — every guide that bundles a `references/` file now carries a Rule-0
  load directive (a point-of-need 1-hop link; top-of-body for the work guides), so the reference is
  actually loaded rather than merely listed.
