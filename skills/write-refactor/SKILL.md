---
name: write-refactor
type: agent-guide
description: >-
  Implement a refactor task: restructure code while observable behavior holds,
  proven by an equivalence check that would fail on drift — a green suite is
  not one. ALWAYS apply when asked to restructure, extract, clean up, or remove
  dead code with behavior preserved. Never change behavior, use an unreviewed
  text-only bulk rewrite, delete a symbol without pasted grep evidence of zero callers, or
  leave a shim without a removal criterion. Skip deliberate behavior changes
  (rewrite), API/version moves (migration), performance tuning, and net-new
  features.
---

# Implement a refactor

`DISRESPEC-SPINE: One fact once. No filler, repeated source material, empty sections, or chat restatement; after successful creation return only clickable artifact links, except for blockers, failed creation, incomplete verification, or irreversible-action confirmation.`

Restructure code so it reads, factors, or layers better — **without moving any observable
behavior**. Two prominent failure modes are a behavior delta smuggled in under the "purely
internal" label and a compatibility shim that quietly becomes permanent. This guide carries the
refactor discipline standalone. When runs are parallel, isolate each in its own worktree or branch
so their writes stay disjoint. These are conventions the review packet inspects — nothing enforces
them at edit time.

Plan the transformation proportionately. A broad or multi-wave refactor earns a change plan for its
baseline, waves, and rollback; a bounded single-batch cleanup can run from direct intent and these
run notes. This guide is the execution half. The defining test: if any observable behavior moves, the work is
no longer a refactor — it is a rewrite (behavior changes on purpose) or a migration (API A → B).
Stop and say so; do not proceed under the wrong label.

**Before editing, open [`references/task-template.md`](./references/task-template.md)** and instantiate
it as run notes. Record its path separately from any input task packet and fill it as you go. These
notes are private execution state, not a Suspec task packet. When a change plan governs the work,
its baseline, waves, and rollback remain there.

Place the file under `~/.agents/artifacts/<workspace>/`, resolving `~` to the absolute
home path and deriving `<workspace>` from the repository or working-directory basename. Keep it
out of the repository and carry its absolute path forward. If the workspace name or target path
conflicts with unrelated work, stop for a structured human choice; never overwrite. If the root is
unwritable, offer grant access and retry, another agent-neutral user directory, or cancel. Never
fall back to vendor storage, the repository, or a temporary directory.

**Before handoff, close the evidence loop.** These notes are scratch state, not the review index.
When a task or spec governs the work, copy final changed files, fresh Verify evidence, scope drift,
blocked questions, and findings into the task's `## Run summary` / `## Findings` or the spec's
`## Execution`. If neither exists, return the same material in the direct handoff. A reviewer must
not need this private file to find the final evidence.

## Rules

1. **Prove preservation with an equivalence check that would fail if behavior changed** — not with
   a green suite. A passing suite covers only what was already tested; a behavior delta in an
   untested corner passes silently. The strongest available oracle is the gate: property-based,
   differential (keep the old path reachable behind a shim and diff the two until clean), or
   golden-output pinned _before_ the change. If no stronger check than the suite exists, write down
   why the suite is a sufficient oracle for this change — "the suite is green", alone, is not that.
2. **If a test fails after your change, the behavior changed.** Investigate before touching the
   test — adapting a test to a new result is how a rewrite disguises itself as a refactor.
3. **Choose the transformation mechanism by structural uniformity.** A syntax-aware codemod can be
   safer than repeated hand edits when the transformation is truly uniform. Dry-run it, bound the
   batch, inspect every resulting diff, and run the checks. Never use blind text substitution over
   syntax; hand-edit exceptions.
4. **Run the checks at every batch, not only at the end.** A layering violation caught one batch
   old is cheap to undo; accumulated drift is its own untangling project. Paste output as you go.
   Define batch boundaries from coherent behavior and risk. Follow the change plan's waves when one
   governs; otherwise record the bounded batch in the run notes. A batch must be small
   enough to diagnose and reverse when its check fails; "one batch" that hides unrelated surfaces is
   end-loaded checking.
5. **Prefer deletion over modification — and prove every deletion safe.** For each deleted symbol,
   paste the search showing zero callers across source _and_ tests, plus a separate search for the
   symbol's **string form** (dynamic dispatch, registries, reflection, generated code, config) that
   a call-syntax search cannot reach. "I checked, it's unused" is not evidence; the uncaught caller
   fails in production.
6. **Every shim gets a verifiable removal criterion before it is introduced**: its path, what it
   forwards to, and a mechanically checkable removable-when condition (e.g.
   `git grep -c '<old-name>' src/` returns 0). A shim without one is permanent by default — exactly
   the debt the refactor was meant to reduce.
7. **No "while I'm here" semantic improvements.** A tempting behavior tweak mid-move is a stop
   signal: it is a behavior change wearing a refactor's clothes. Note it as a finding candidate.
8. **After a relocation, confirm the old location is empty of what moved.** A leftover orphan is
   invisible until something still references it.
9. **Paste real output; resolve commands from `AGENTS.md`; ask when one is undefined.** And never
   write a review result on your own work.

## Refuses

| Temptation                                                | Do instead                                                                      |
| --------------------------------------------------------- | ------------------------------------------------------------------------------- |
| "It's faster to run sed over the whole tree"              | Use a bounded syntax-aware transform, inspect the diff, and hand-edit outliers  |
| "I'll improve the semantics while I'm restructuring"      | That is a different change in a different scope — note it, don't fold it in     |
| "I'm pretty sure this code has no callers"                | Grep source, tests, and the string form; paste the output, then delete          |
| A shim added with no removal criterion                    | Give it a path, a forward target, and a removable-when check — or do not add it |
| "The test failed after my refactor, so I'll fix the test" | A failing test means behavior changed; investigate first                        |
| A green suite offered as equivalence evidence             | Demand the check that would fail on drift, or record why the suite suffices     |
| A public contract changed under a "cleanup" label         | That is a rewrite or migration decision — surface it                            |
| Silencing an unrelated checker complaint to get green     | Fix the violation or report it; never edit the gate                             |

## Self-review gate

Before declaring the task done:

- [ ] The equivalence check (or the recorded sufficient-oracle justification) is pasted, and it
      would fail if behavior had changed.
- [ ] Every deleted symbol carries pasted grep evidence — call syntax and string form — of zero
      callers.
- [ ] Every shim has a documented, verifiable removal criterion.
- [ ] Checks ran at every batch and after the final edit; output pasted.
- [ ] The diff is purely structural — no semantic tweak, no unauthorized contract change, no file
      touched merely because it was open.
- [ ] Old locations are empty of what moved; nothing orphaned.
- [ ] The summary names changed files, commands with output, and finding candidates; you issued no
      review result on your own work.

## Gotchas

Failure modes that show up at run time, not in the rules:

- **You changed behavior under cover of "refactor"** — a "while I'm here" semantic tweak, a tidied
  edge case, a contract nudged during a "cleanup" — and the task is no longer a refactor; it is a
  rewrite or a migration wearing a refactor's label, reviewed against the wrong checks. The
  tempting behavior tweak mid-move is a stop signal, not a bonus.
- **You deleted a symbol without grep evidence of zero callers** — "I'm pretty sure it's unused"
  instead of a pasted search — and a caller reached through dynamic dispatch, a registry,
  reflection, or generated config survives the call-syntax search and fails in production. Grep the
  call form _and_ the string form, and paste both, before the symbol goes.
- **You mistook a green suite for an equivalence check.** A passing suite covers only what was
  already tested, so a behavior delta in an untested corner ships silently — and a test that goes
  red after the change tempts you to "fix the test", which is how a rewrite disguises itself. A
  failing test means behavior moved; investigate the code, not the assertion.

## Bundled resources

- [`references/task-template.md`](./references/task-template.md) — private run notes for the
  equivalence check, checkpoints, shims, deletion searches, and self-review. When a change plan
  governs the work, baseline, waves, and rollback remain there.
