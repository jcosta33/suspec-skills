---
name: write-migration
type: agent-guide
description: >-
  Implement a migration or upgrade task: move the code from API A to API B —
  framework/library bump or API replacement — surface preserved, green after
  every wave, old-API callsites grepped to zero. ALWAYS apply when asked to
  migrate, upgrade, port, or adopt a breaking change while behavior holds.
  Never use an unreviewed text-only bulk rewrite, skip per-wave checks, finish with old-API
  callsites surviving, or leave a shim without a removal criterion. Skip
  same-API refactors, deliberate behavior changes (rewrite), and net-new
  features at the new version.
---

# Implement a migration

`DISRESPEC-SPINE: One fact once. No filler, repeated source material, empty sections, or chat restatement; after successful creation return only clickable artifact links, except for blockers, failed creation, incomplete verification, or irreversible-action confirmation.`

A migration moves the implementation from API A to API B — a framework upgrade, a version bump, a
library replacement, an internal API sunset — while the behavior callers observe holds. The
implementation moves; the contract does not. Migrations fail in two ways, both producing a diff
that looks finished: the **permanent half-migration** (some callsites on the old API, some on the
new, indefinitely) and the **phantom completion** (old-API callsites still alive in dynamic
dispatch, registries, or generated code that a text search of the call syntax never reached). This
guide carries the migration discipline standalone. When runs are parallel, isolate each in its own
worktree or branch so their writes stay disjoint. These are conventions the review packet inspects
— nothing enforces them at edit time.

Plan the transformation first — the change plan covers baseline, waves, and rollback;
this guide is the execution half. One discipline covers both kinds: an internal API replacement and
a framework/language/library upgrade differ only in trigger, not method. If the new API is _meant_
to behave differently, that is a rewrite — relabel before proceeding.

**Before editing, open [`references/task-template.md`](./references/task-template.md)** and instantiate
it as run notes. Record its path separately from any input task packet and fill it as you go. These
notes are private execution state, not a Suspec task packet; migration waves remain in the change plan.

Place the file next to your own native artifacts — the same place you keep your plans,
notes, and memories for this work, in a folder named after the repo you are working on
(or wherever fits your harness best). You choose the exact spot; keep it out of the repo
unless the project's own governance says otherwise, and carry the file's full path
forward — every later step names artifacts by explicit path.

**Before handoff, close the evidence loop.** These notes are scratch state, not the review index.
When a task or spec governs the work, copy final changed files, fresh Verify evidence, scope drift,
blocked questions, and findings into the task's `## Run summary` / `## Findings` or the spec's
`## Execution`. If neither exists, return the same material in the direct handoff. A reviewer must
not need this private file to find the final evidence.

## Rules

1. **Behavior is preserved — prove it, don't assume it.** Use an equivalence check that would fail
   if behavior changed: differential is the natural fit (keep the old path reachable behind a shim
   and diff old vs new until clean), else golden-output or property-based. A green suite covers
   only what was already tested. If a test fails after a wave, investigate before "fixing" it —
   adapting a test to a new result is how a migration silently becomes a rewrite. If the suite is
   the only oracle, record why it suffices for this migration.
2. **Execute wave by wave; the codebase is green after every wave.** A wave is the smallest atomic
   change that leaves the code compiling and passing checks. Run the test and check commands at the
   end of each wave and paste both before starting the next — per-wave checks localize a break to
   the wave that introduced it; final-only checking lets the breakage tangle into the permanent
   half-migration.
3. **Choose the transformation mechanism by callsite uniformity.** For a mechanically uniform API
   change, a syntax-aware codemod may be safer than hand editing. Dry-run it, limit each wave, inspect
   every changed diff, and run the wave checks. Never use a blind `sed`, regex, or shell sweep over
   syntax; hand-edit callsites that do not match the proven shape.
4. **Track callsites to zero, across the whole codebase.** Count old-API callsites up front; track
   per wave how many moved and how many remain. Done means **zero old-API callsites outside
   explicitly tracked shims**, counted over the whole codebase, not just the modules the work was
   scoped to — and proven by a pasted search, not asserted. "Mostly gone" is unfinished.
5. **Search beyond the call syntax.** After the grep, audit explicitly and paste the results:
   dynamic-dispatch sites, string-based references (registry lookups, DI-by-name), generated code,
   test fixtures and snapshots, reflection. The phantom completion lives precisely where a text
   search of the call syntax cannot see.
6. **Every shim gets a verifiable removal criterion before it is introduced**: path, forward
   target, and a mechanically checkable removable-when condition (e.g.
   `git grep -c '<old-API>' src/` returns 0). Without one, "temporary" means forever.
7. **No semantic improvements ride along.** "While I'm migrating" tweaks destroy the work's
   reviewability as a mechanical change — note them as finding candidates.
8. **Paste real output; resolve commands from `AGENTS.md`; ask when one is undefined.** And never
   write a review result on your own work.

## Refuses

| Temptation                                                    | Do instead                                                         |
| ------------------------------------------------------------- | ------------------------------------------------------------------ |
| "I'll sed this across the tree in one step"                   | Use a syntax-aware transform in reviewed waves; hand-edit outliers |
| "I'll skip wave checks; it's all the same change"             | Check after every wave; paste the output                           |
| "The shim is temporary, no need to document removal"          | Path + forward target + removable-when check, or no shim           |
| "Old API is mostly gone; I'll handle the rest in a follow-up" | Enumerate and convert the rest, or track each exception explicitly |
| "Behavior drifted slightly but the tests still pass"          | Surface it; a migration moves surface, not semantics               |
| "No remaining callers" with no pasted search                  | Grep source, tests, and the string form; paste it                  |
| "I'll improve the API's behavior while I'm in here"           | Finding candidate; a behavior change is a different task           |
| Adapting a failing test to the new API's output               | Investigate first — that is a behavior change in disguise          |

## Self-review gate

Before declaring the task done:

- [ ] Every wave ended green — test + check output pasted per wave, not only at the end.
- [ ] The callsite count is proven zero outside tracked shims by a pasted whole-codebase search.
- [ ] The beyond-the-grep audit (dynamic dispatch, string references, generated code, fixtures,
      reflection) is done and pasted.
- [ ] Every shim has a documented, verifiable removal criterion — and none that should have been
      removed in _this_ migration survives.
- [ ] The equivalence check (or recorded sufficient-oracle justification) is pasted; behavior held.
- [ ] No half-migrated files, TODOs, or stub-shimmed modules left behind; ride-along discoveries
      are finding candidates.
- [ ] You issued no review result on your own work.

## Gotchas

- **Ran an unreviewed bulk rewrite.** A text substitution swept the tree in one pass and mangled an
  unusual callsite. Use syntax-aware transforms only in bounded waves, inspect every resulting diff,
  and hand-edit outliers.
- **Finished with old-API callsites surviving.** The diff looked done but old-API callsites lived on
  in dynamic dispatch, string-based registry lookups, generated code, or fixtures the call-syntax
  grep never reached — the phantom completion. Done means zero old-API callsites outside tracked
  shims, proven by a pasted whole-codebase search plus the beyond-the-grep audit.
- **Left a shim with no removal criterion.** A "temporary" compatibility shim shipped without a
  path, forward target, and mechanically checkable removable-when condition — so "temporary" became
  permanent and the half-migration ossified. Every shim gets its removal criterion before it is
  introduced.

## Bundled resources

- [`references/task-template.md`](./references/task-template.md) — private run notes for the
  equivalence check, callsite tracker, shims, per-wave evidence, and self-review. Migration waves
  remain in the change plan.
