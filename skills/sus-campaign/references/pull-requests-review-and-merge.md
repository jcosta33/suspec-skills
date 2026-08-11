# Pull requests, review, and merge

## Oracle

1. Define the strongest observable check before changing behavior when one can be known.
2. For a bug, reproduce the original failure and expected reason before editing.
3. Trust a regression only when it fails on the defect, passes on the repair, exercises production
   behavior, and invents no requirement.
4. Carry command, working directory, current state, exit, and decisive output. Add inputs,
   configuration, toolchain, or environment only when they can change the result. Re-run after
   material drift.
5. Hosted status checks are optional. Project-approved local proof is valid.

## Pull requests

1. Keep one independently reviewable concern per pull request and merge in dependency order. Split
   mixed behavior, refactors, and migrations before implementation.
2. Repository size policy wins. Without one, warn when reviewability degrades and split unless the
   concern is genuinely indivisible. Suspec supplies no line or file threshold.
3. Open a draft when reviewable code exists. Follow project title and body conventions. Without
   them, use an imperative title, Summary, and Verification. Add Dependencies or Risks only when
   material. Link the ledger once.
4. Remove agent names, internal review mechanics, process diaries, repeated evidence, and anything a
   reviewer cannot act on.
5. Mark ready only after required implementation checks pass.

## Review

1. Derive the smallest review set that covers the change's material risks. Repository policy and
   current risk decide breadth; Suspec supplies no reviewer or stance count.
2. Give every reviewer the current head, diff, governing requirements, accepted decisions, and one
   distinct risk. Hide prior reviewer prose unless resolving its finding.
3. Verify findings. Publish only supported actionable defects. Local defects use changed-line
   threads; file-wide defects use file comments; cross-cutting defects use one short review item.
4. Write one terse paragraph per finding: defect, consequence, required outcome. Omit greetings,
   praise, process, identities, stance labels, speculation, and solution essays.
5. The implementation owner fixes, pushes, and replies with the repaired head and decisive proof. A
   distinct reviewer or named review authority validates the repair.
6. Resolve current findings before dispatching another sequential reviewer. Restart broad review
   only when repair changes a contract, trust boundary, failure mode, or requirement.
7. Stop when material risks are covered. Run no quiet rotation, reviewer quota, or completion recap.

The implementation owner cannot accept its own work. The campaign names the reviewer or project
mechanism that provides independent assessment at the strength the campaign claims.

## Merge

1. Reconcile governing artifacts when they exist. Re-resolve the current head, base, required proof,
   review state, and open conversations immediately before merge.
2. The owner may delegate merge execution to a named orchestrator, project command, protected queue,
   or human. Bind the operation to the expected head. Do not claim independence unless the worker
   cannot bypass the authority.
3. Drift resets affected checks and review.
4. Update and revalidate dependent branches after prerequisites merge.
5. Follow project merge strategy. Fold fixup-only commits when policy allows.
6. Recycle a lane only after merge or closure and a clean worktree.
7. Delete only campaign-owned merged branches and clean campaign-created worktrees through the named
   cleanup owner. Preserve every other branch and lane.
