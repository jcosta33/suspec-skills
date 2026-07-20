---
name: campaign
description: Orchestrate broad software delivery across reusable worktree lanes, delegated implementation, multiple pull requests, adaptive model routing, and independent review. Use when one delivery goal contains multiple dependency-aware, write-disjoint implementation streams across one or more repositories. Do not use for planning or task decomposition alone, contained or sequential implementation, a single pull request, or review of existing work.
---

# Campaign

## Method

### Frame

1. Read project governance, governing requirements, dependency state, branch protection, CI, and
   release constraints.
2. Create or select one project-native issue or issue-backed epic as the campaign ledger. Define
   done, repositories, dependency order, risk classes, branch integration policy, review policy,
   merge mode, and ownership there. Use milestones only as grouping metadata.
3. Prove the parallel boundaries. Shared contracts, generated surfaces, unknown scope, or overlapping
   files force sequencing.
4. Force material ambiguity into explicit human selection before dependent work starts. Present
   three genuine options by default, two when genuinely binary, recommendation first, with one plain
   sentence explaining each cost.

### Allocate

1. Size one global lane budget from proven independent width, machine capacity, CI throughput, and
   reviewer capacity; partition it into fixed per-repository pools. A ten-lane campaign has ten total
   worktrees.
2. Create each worktree once at a stable path. Keep one active branch and one implementation owner
   per lane. Repartition only when dependency topology changes; moving capacity between repositories
   retires one lane and creates another.
3. Reuse the worktree after each pull request. Require empty tracked and untracked status; fetch;
   detach at the accepted remote-base commit; then create the next branch. Keep ignored dependencies
   only while lockfile and toolchain identity match the next branch; refresh them when either changes.
   Force-clean nothing.
4. A branch or worktree has one writer. Never dispatch concurrent owners into either.

### Dispatch

1. Schedule only dependency-ready, write-disjoint work.
2. Give every implementation owner the objective, ledger link, repository, lane, branch, exact
   scope, exclusions, dependencies, acceptance conditions, required checks, and pull-request policy.
3. One pull request carries one independently reviewable concern and merges in declared dependency
   order. Split mixed features, refactors, and migrations before implementation. Repository limits
   win. Without them, 500 reviewable changed lines or 15 handwritten source files is a stop signal;
   exclude generated files, lockfiles, pure deletion, and mechanical output. Cross it only with
   explicit human approval.
4. Open a draft pull request as soon as reviewable code exists. Follow the project template and title
   convention. Without one, use an imperative title, `Summary`, and `Verification`; add
   `Dependencies` or `Risks` only when material. Link the campaign ledger and dependencies once.
5. Rewrite stale body text instead of appending chronology. Cut agent names, transient artifacts,
   internal review mechanics, head diaries, repeated evidence, and anything a reviewer cannot act
   on. Mark the pull request ready only after implementation checks pass.
6. Reassign an abandoned lane only after the harness confirms the prior owner stopped and the branch
   head remains expected. Hand the replacement the lane, branch, pull request, head, checks,
   unresolved comments, and exact blocker.

### Route

1. Run deterministic checks first and after every relevant edit.
2. Use the cheapest model proven adequate by repository evaluation, comparable accepted work, or a
   bounded task with a deterministic oracle. Use the standard tier when adequacy is unknown. Reserve
   stronger agents for architecture, security, migrations, conflicting evidence, cross-repository
   judgment, and disputed severe findings.
3. Escalate the blocked decision, not the whole task. Return to the cheaper tier after resolution.
4. Route from scope, risk, reversibility, check results, repeated failure, and reviewer disagreement.
   Ignore model self-confidence.

### Build

1. The implementation owner edits, tests, commits, pushes, and answers review in its lane.
2. The campaign orchestrator tracks dependencies, evidence, CI, and ownership. It does not hijack an
   owner's branch to make review fixes.
3. A blocked owner records the exact blocker on the pull request or campaign ledger. Resolve the
   decision, replace the owner, or stop the dependent work.

### Review

1. After implementation checks pass, run exhaustive multi-angle review and sequential repair across
   a fixed target-justified stance pool. The product is merged code. Review is a gate.
2. Derive the smallest pool that covers the change's material risks. A stance earns a slot only when
   it tests a unique risk no other stance covers. Three is the default. More than five requires
   explicit human approval. If five cannot cover the change, split the pull request.
3. Freeze the pool for one rotation. Add a stance only when a repair creates or exposes a material
   trust boundary, public contract, failure mode, or previously unknown risk. Never rebuild the pool
   because a finding was fixed.
4. Dispatch one fresh reviewer at a time against the current pull-request head. Give it the code,
   diff, governing requirements, accepted decisions, one stance, and no pull-request conversation or
   prior reviewer prose.
5. Fact-check every finding as supported, refuted, a human decision, unverified, or blocked. Kill
   duplicates, stale findings, and preference dressed as defect. An unverified or blocked finding
   stops the stance. Route a human decision through the project decision channel.
6. Keep the method private. Publish only supported actionable findings. Put a local defect in one
   thread on the narrowest changed line that owns it. Use a file comment for a file-wide defect and
   one short review-body item for a cross-cutting defect. Collapse repeated instances only when one
   repair and owner resolve them together. Batch each stance in one pending review; submit only when
   nonempty, with no summary. Quiet stances and refutations produce nothing.
7. Write each comment as one terse paragraph: defect, consequence, required outcome. Use the
   project's severity scheme. Without one, label only merge blockers as `[blocking]`. Cut greetings,
   summaries, praise, headings, speculation, process narration, reviewer identity, stance labels,
   and solution essays. Include evidence only when the diff or linked check does not prove the claim.
8. Send the implementation owner the thread links, not a restatement. The owner fixes every supported
   item in the same lane, pushes, and replies once: `Fixed in <sha>. <decisive proof>.` A disagreement
   gets one evidence-backed reason. The review orchestrator checks the current head, reruns decisive
   proof, and resolves the thread. Post no follow-up review event or completion recap.
9. Dispatch the next stance only after every item from the current stance is resolved. Review the new
   head, not the superseded snapshot.
10. Finish the frozen pool once, then merge. Run no quiet rotation, findings recap, or ceremonial
    review pass.

### Merge

1. Record the reviewed head and base SHAs. Once the pool is exhausted, supported findings are
   resolved, and required CI, approvals, and conversations pass, merge immediately under the
   ledger-authorized mode. Use a protected merge queue or revalidate both SHAs and the tested merge
   result before an expected-head merge. Head or base drift resets affected checks and review. Never
   leave an authorized mergeable pull request open.
2. The implementation owner updates its dependent branch after prerequisites merge using project
   policy. Cross-repository dependencies remain explicit pull-request blockers. Rerun affected checks
   and review.
3. Follow the project merge strategy. Fold fixup-only review commits before merge when policy allows.
4. Recycle the lane only after the pull request merges or closes and the worktree is clean.
5. With explicit human or project-policy authorization, delete merged local and remote branches and
   remove clean worktrees without force once, at campaign shutdown.

### Close

1. Finish only when every campaign item is merged, explicitly deferred with an owner and reason, or
   blocked on a named human decision.
2. Reconcile the campaign ledger with pull requests, merge state, verification, deferrals, and
   remaining risk.
3. Preserve only verified lessons whose loss would force rediscovery. Link every durable update in
   the campaign ledger.

## Output

Return the campaign ledger and pull-request links, merged/deferred/blocked state, unresolved human
decisions, residual lanes or branches, durable updates, and decisive verification of acceptance
conditions against every merged SHA.

## Boundaries

The campaign orchestrator owns scheduling, routing, evidence, reviewer dispatch, and resolution
checks. Implementation owners own code and review repairs. Humans and project policy own material
decisions, irreversible actions, acceptance, and merge authority.

This method requires separate worktrees, fresh reviewer dispatch, repository-native pull-request
discussion, and deterministic checks. Name a missing capability and stop; invisible substitutes
destroy the audit trail.
