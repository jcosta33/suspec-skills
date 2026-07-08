# Reference: grading evidence for a research note

Pull this up when a research question turns on **empirical or scientific evidence** — study
results, effect sizes, benchmark numbers, safety/efficacy or "X is faster/safer/better" claims —
not just an API-shape or library-feature comparison. It gives you a defensible way to rank what a
source is worth and to screen out the untrustworthy ones, so a recommendation rests on the
strongest evidence available, with its weaknesses named.

**Honest framing.** The frameworks below — OCEBM's levels, GRADE, PRISMA's reporting discipline —
come from *clinical* evidence appraisal. Their specifics (RCTs, patient outcomes) rarely map onto
software or product research. What transfers is the **principle**: rank a source by how much its
*design* can support the claim, then **downgrade** for the concrete weaknesses you can see. Use
this as an analogue and a checklist, not a pretense that a library benchmark is a drug trial. It
is a convention — nothing enforces it; the review packet inspects it.

## 1. The source-tier ladder (adapted from OCEBM 2011)

OCEBM ranks study designs into five levels per question type — Level 1 a systematic review, down
to Level 5 mechanism-based reasoning — "the likely strongest evidence is furthest to the left"
[[OCEBM-2011]]. The software-research analogue, strongest first:

1. **A systematic review / meta-analysis** of the question, or an independent multi-study benchmark.
2. **A peer-reviewed study** with a reproducible method and reported data.
3. **A standard or specification** (RFC, W3C, ISO) — authoritative for *what is defined*, not for *what performs*.
4. **Official first-party docs**, then **the source code** (cite repo + version).
5. **Measured product behavior you ran yourself**, output recorded.
6. **Mechanism-based reasoning / a single uncorroborated report / vendor commentary** — Level 5: weakest, cite only with the primary source it rests on.

This re-prioritizes the guide's general rule 3 order for *empirical* questions: a standard or spec
is authoritative for what is *defined* but says nothing about what *performs*, so for a
performance/effect question it ranks below an independent study. A source's level is its *ceiling*,
not its score — §2 takes it down from there.

## 2. Downgrade / upgrade checks (adapted from GRADE)

GRADE starts RCT evidence "high" and observational "low," then moves it for stated reasons
[[GRADE-2008]]. Start each source at its §1 tier, then **downgrade** when you can see:

- **Study limitations** (risk of bias) — no control, cherry-picked workload, author runs the thing being measured.
- **Inconsistency** — other sources on the same question disagree and it isn't reconciled.
- **Indirectness** — the source's setting (version, scale, language, workload) does not match *your* question.
- **Imprecision** — small N, one run, no variance/CI reported, a single anecdote.
- **Reporting / publication bias** — only the favorable result is shown; the method or raw data is withheld.
- **Conflict of interest** — vendor-funded or vendor-authored about its own product (a software-specific addition; treat as a strong downgrade unless the method is independently reproducible).

**Upgrade** only for: a **large, consistent effect** across independent sources; a **dose-response**
pattern; or where **plausible bias would push against** the observed effect and it holds anyway.

Record the result as the finding's **confidence** (high / medium / low), and say *why* it was
downgraded — a confidence with no reason is unauditable.

## 3. Screen the venue before you trust it (Grudniewicz 2019 · Think.Check.Submit)

The 2019 consensus defines predatory journals as ones that "prioritize self-interest at the
expense of scholarship," marked by false/misleading information, deviation from best editorial
practice, lack of transparency, and aggressive solicitation [[PREDATORY-DEF]]. Before citing a
paper, run the practitioner screen [[THINK-CHECK-SUBMIT]] — and apply the same logic to a blog,
vendor page, or preprint:

- **Accountability** — can you identify and contact the publisher/author? Is there a named, expert editorial board (or, for a blog, a named author with standing)?
- **Process** — is the peer-review (or editorial) process stated? For OA papers, is the journal **listed in DOAJ**? Is the publisher a **COPE / OASPA** member?
- **Transparency** — are the method and data shown, or only the conclusion?
- **Provenance** — does the piece cite its own primary source, or assert downstream? An SEO content-farm or an unattributed "studies show" is the software predator: cite the primary or drop it.

A source that fails the screen is **rejected** (§5), not cited with a caveat.

## 4. Keep observation separate from claim

What you *saw* (the benchmark printed 4,200 req/s; the abstract states 91% pass@1) is an
**observation**. What it *means for the question* (library A scales for our load) is a **claim**,
and it carries the confidence from §2. Blur the two and an indirect or imprecise observation gets
laundered into a high-confidence claim. PRISMA's reporting discipline makes this concrete: report
the full search and the per-outcome certainty so a reader can re-judge [[PRISMA-2020]] — for a
research note, that means the evidence field shows what you found and how, not just the conclusion.

## 5. The Rejected trail (auditable)

Record sources you evaluated and **rejected**, each with the reason — *predatory/untrustworthy
venue*, *could not verify (paywalled, dead link)*, *superseded by a newer source*, or *failed the
§2 downgrade so hard it carries no weight*. A rejection that leaves no trace invites the next
author to re-cite the same bad source; the trail is the evidentiary audit. (This mirrors the
`Rejected` section convention in the framework's own `docs/research/sources.md`.)

## Sources

- **[[OCEBM-2011]]** *The Oxford 2011 Levels of Evidence.* OCEBM Levels of Evidence Working Group
  (Howick, Chalmers, Glasziou, Greenhalgh, Heneghan, et al.), Oxford Centre for Evidence-Based
  Medicine, 2011. *Tier: primary-official (an official evidence-grading framework; self-published,
  not peer-reviewed).* Five-level study-design hierarchy per question type (L1 systematic review →
  L5 mechanism-based reasoning), graded down for quality/imprecision/indirectness/inconsistency/
  very-small-effect, up for a large effect.
  <https://www.cebm.ox.ac.uk/resources/levels-of-evidence/ocebm-levels-of-evidence>
- **[[GRADE-2008]]** *GRADE: an emerging consensus on rating quality of evidence and strength of
  recommendations.* Guyatt, Oxman, Vist, et al., for the GRADE Working Group. **BMJ 2008;336:924–926**,
  DOI 10.1136/bmj.39489.470347.AD. *Tier: peer-reviewed.* Four certainty levels; RCTs start high,
  observational starts low; downgrade domains (study limitations, inconsistency, indirectness,
  imprecision, reporting bias) and upgrade criteria (large effect, dose-response, confounding
  against the effect). *(The 2008 labels "study limitations"/"reporting bias" were standardized to
  "risk of bias"/"publication bias" in the 2011 GRADE series; substance unchanged.)*
  <https://www.bmj.com/content/336/7650/924>
- **[[PRISMA-2020]]** *The PRISMA 2020 statement: an updated guideline for reporting systematic
  reviews.* Page, McKenzie, Bossuyt, et al. **BMJ 2021;372:n71**, DOI 10.1136/bmj.n71. *Tier:
  primary-official (peer-reviewed reporting guideline).* A 27-item checklist; item 7 requires the
  full search strategy; items 18 and 22 require describing the methods for, and presenting, a
  per-outcome certainty assessment (GRADE named as the example method).
  <https://www.bmj.com/content/372/bmj.n71>
- **[[PREDATORY-DEF]]** *Predatory journals: no definition, no defence.* Grudniewicz, Moher, Cobey,
  et al. (35-author consensus). **Nature 2019;576(7786):210–212**, DOI 10.1038/d41586-019-03759-y.
  *Tier: peer-reviewed Comment (a consensus statement, not primary research — opinion-tier; never a
  MUST).* The consensus definition of predatory journals/publishers.
  <https://www.nature.com/articles/d41586-019-03759-y>
- **[[THINK-CHECK-SUBMIT]]** *Think. Check. Submit. — Journals checklist.* Cross-industry initiative
  (ALPSP, AUP, COPE, DOAJ, ISSN, LIBER, OAPEN, OASPA, STM, UKSG), 2015– (checklist last amended
  2023). *Tier: practitioner checklist (no named author; community standard).* The operational
  screen for vetting a journal/publisher: contactable publisher, stated peer-review process, COPE/
  OASPA membership, DOAJ listing for OA.
  <https://thinkchecksubmit.org/journals/>
