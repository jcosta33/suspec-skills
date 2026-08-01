# Pull requests, review, and merge

## Pull requests

1. Keep one independently reviewable concern per pull request and merge in dependency order. Split
   mixed features, refactors, and migrations before implementation.
2. Repository size policy wins. Without one, 500 reviewable changed lines or 15 handwritten source
   files stops the pull request. Exclude generated files, lockfiles, pure deletion, and mechanical
   output. Crossing the stop requires explicit human approval.
3. Open a draft when reviewable code exists. Follow project title and body conventions. Without
   them, use an imperative title, Summary, and Verification. Add Dependencies or Risks only when
   material. Link the ledger and dependencies once.
4. Rewrite stale body text. Remove agent names, transient material, internal review mechanics, head
   diaries, repeated evidence, and anything a reviewer cannot act on.
5. Mark ready only after implementation checks pass.

## Review

1. Run exhaustive multi-angle review and sequential repair after implementation checks pass. Merged
   code is the product; review is a gate.
2. Derive the smallest fixed pool covering the change's material risks. A stance earns a slot only
   for a unique risk. Three is the default. More than five requires human approval. Split the pull
   request when five cannot cover it. Freeze the pool before review.
3. Add a stance only when repair creates or exposes a material trust boundary, public contract,
   failure mode, or previously unknown risk. Never rebuild the pool because a finding was fixed.
4. Send one fresh reviewer at a time the current head, code, diff, governing requirements, accepted
   decisions, and one stance. Hide pull-request conversation and prior reviewer prose.
5. Verify every finding as supported, refuted, a human decision, unverified, or blocked. Remove
   duplicates, stale findings, and preference dressed as defect. Unverified or blocked stops the
   stance. A human decision stops dependent work for explicit selection.
6. Publish only supported actionable findings. Use the narrowest changed-line thread for local
   defects, a file comment for file-wide defects, and one short body item for cross-cutting defects.
   Collapse instances only when one repair and owner resolve them.
7. Submit one nonempty pending review per stance with no summary. Quiet stances and refutations
   produce nothing.
8. Write each comment as one terse paragraph: defect, consequence, required outcome. Use project
   severity. Without one, label only merge blockers as [blocking]. Add evidence only when the diff
   or linked check does not prove the claim. Omit greetings, praise, process, identities, stance
   labels, speculation, and solution essays.
9. Send the owner thread links. The owner fixes, pushes, and replies once:
   `Fixed in <sha>. <decisive proof>.`
   A disagreement gets one evidence-backed reason. Verify current head, rerun proof, and resolve.
   Post no completion recap.
10. Start the next stance only after every current item resolves. Review the new head.
11. Finish the pool once. Run no quiet rotation or ceremonial pass.

## Merge

1. Record reviewed head and base SHAs. Once review, CI, approvals, and conversations pass, merge
   immediately under the ledger-authorized mode.
2. Use a protected queue or revalidate both SHAs and the tested merge result. Drift resets affected
   checks and review.
3. Update dependent branches after prerequisites merge. Keep cross-repository dependencies as
   explicit blockers. Rerun affected checks and review.
4. Follow project merge strategy. Fold fixup-only commits when policy allows.
5. Recycle a lane only after merge or closure and a clean worktree.
6. Delete merged branches and remove clean worktrees without force only under explicit human or
   project-policy authority at campaign shutdown.
