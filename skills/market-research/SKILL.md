---
name: market-research
type: agent-guide
description: Conduct market, customer, competitor, UX, or category research with traceable evidence. ALWAYS apply this skill when asked to size a market, map competitors, compare product patterns, assess customer/user needs, synthesize reviews, analyze positioning, or use synthetic respondents/LLMs for insight work. Do not turn marketing pages, synthetic data, anecdotes, or one example into market facts. Skip for one-source technical research, present-state code audits, or implementing the recommendation.
---

# Skill: market-research

## Purpose

Market research fails when a confident story outruns the evidence: a landing page becomes
"what competitors do", a review thread becomes "users want", a synthetic respondent becomes a
customer, or a single example becomes a market pattern. This skill turns that work into a
traceable evidence synthesis: claims are typed, sources are dated, confidence is graded, and the
answer separates observed behavior from inference and recommendation.

Use it to produce a market note, competitive scan, UX-pattern survey, customer-needs synthesis,
TAM/SAM/SOM estimate, positioning map, review analysis, or synthetic-research caveat. The output
may inform a decision, but it does not make the decision by itself.

## Rules

### 1. Frame the decision before collecting sources

State the decision the research will inform, the audience/segment, geography, time horizon, and
what would change the decision. This prevents broad "market vibes" research: the right sources for
enterprise DevTools adoption are not the right sources for consumer willingness-to-pay.

### 2. Build a claim-fit source map

Label every source by type before using it:

- observed product behavior: direct product exercise, docs, changelog, pricing flow, screenshots,
  or telemetry;
- user-generated evidence: reviews, support threads, interviews, and community posts, with sampling
  and authenticity limits recorded;
- primary research: interviews, surveys, panels, experiments, usage analytics;
- official market data: filings, standards bodies, government/industry datasets, app-store metrics;
- secondary analysis: analyst reports, media, blog posts, roundups;
- synthetic/LLM output: hypothesis or augmentation only, never a respondent or market fact.

Prefer evidence that directly measures or exposes the claim at issue. Source type alone does not decide
quality: a current pricing page is strong evidence for current price and weak evidence for customer
value; a well-sampled review dataset can support reported experience but not observed behavior.

### 3. Separate observation, claim, inference, and recommendation

Write each finding as one of:

- **Observation:** directly seen in a source or product.
- **Claim:** asserted by a company, respondent, analyst, or source.
- **Inference:** your synthesis across observations/claims.
- **Recommendation:** a proposed action for a later decision.

Do not let an inference masquerade as an observation. Do not let research close a product decision
unless the user explicitly asked for a recommendation.

### 4. Match pattern language to coverage

For "common practice", "most competitors", "standard pattern", or "users expect", disclose the
population searched, the independent instances observed, and contrary cases. Use "most" only when the
sample supports a denominator; use "common" only when coverage is broad enough for the decision. With
sparse evidence, say "example observed" or "candidate pattern". No fixed witness count turns a sample
into a market fact.

### 5. Verify competitor behavior in the working product

For competitor/product behavior, prefer the actual product, docs, changelog, pricing page, API
reference, app-store listing, or current screenshots. Marketing copy can describe positioning, but
not behavior. Record the URL, access date, and what you actually observed.

### 6. Disclose survey and interview method

When using survey/interview evidence, record sample size, recruitment/source, dates, mode, screener,
stimulus, geography, segment, incentives if known, weighting/cleaning if any, and limitations. Do
not cite precision for a non-probability sample unless the model and assumptions are stated.

### 7. Treat synthetic respondents as augmentation, not truth

LLM-generated respondents may help brainstorm attributes, pilot stimuli, or augment a model when
calibrated against real data. They do not replace human respondents, especially for new categories,
new segments, or claims about willingness-to-pay. Mark synthetic results as synthetic and pair them
with the real-data check needed next.

### 8. Size markets with formulas and sensitivity

For TAM/SAM/SOM or revenue opportunity, show the formula, units, source for each variable, date,
segment boundary, and at least one sensitivity range. A single large number without assumptions is
not a market size; it is decoration.

### 9. Grade confidence in controlled language

Rate each major finding:

- **High:** direct, recent, segment-matched, independently triangulated.
- **Moderate:** direct but partial, or triangulated from mixed-quality sources.
- **Low:** indirect, old, small-N, synthetic, single-source, or marketing-derived.
- **Very low:** plausible but mostly assumption; use only to define next research.

Name the downgrade reason: bias, indirectness, imprecision, age, source conflict, weak sample, or
synthetic-only evidence.

### 10. End with an evidence table and next tests

Close with a compact table:

| Finding | Evidence | Confidence | Decision implication | Next test |
| --- | --- | --- | --- | --- |

Include disconfirming evidence and unresolved gaps. A useful market note makes the next action
clear without hiding uncertainty.

## Refuses

| Red flag | Action |
| --- | --- |
| "Users want X" from intuition, one interview, or a review quote | Downgrade to anecdote or gather more evidence |
| A competitor behavior inferred from a landing page headline | Verify in product/docs/pricing/changelog or mark as positioning only |
| Broad pattern language from narrow or undisclosed coverage | State the sample and narrow the claim to what it supports |
| Synthetic respondents presented as real customer evidence | Reject; mark synthetic and specify the needed human-data check |
| Market size with no formula, units, source dates, or sensitivity | Reject; rebuild as a transparent estimate |
| Survey result without sample, recruitment, dates, mode, or limitations | Treat as weak evidence until disclosed |
| Scraped reviews summarized without sampling and duplication/bot caveats | Add method notes and downgrade confidence |
| Conflicting evidence hidden to preserve a clean story | Surface the conflict and explain what would resolve it |
| Research closing on a binding product decision | Reframe as implication/option unless the user asked for a recommendation |

## Output shape

Use this order unless the user asks for a different artifact:

1. **Question and scope:** decision, segment, geography, time horizon.
2. **Method:** source classes searched, inclusion/exclusion criteria, dates accessed.
3. **Findings:** each with observation/claim/inference label and confidence.
4. **Evidence table:** source, quote/paraphrase, source type, date, relevance, caveat.
5. **Implications:** what the evidence suggests, not what it proves.
6. **Next tests:** user interview, survey, product trial, pricing test, analytics pull, or competitor
   verification needed to raise confidence.

## Evidence basis

- ICC/ESOMAR 2025 Code: market, opinion, social research, and data analytics require legality,
  honesty, transparency, privacy, accountability, and human oversight.
- AAPOR disclosure standards: report mode, dates, sample size, precision limits, weighting, quality
  procedures, and limitations for survey/public-opinion evidence.
- PRISMA/GRADE discipline: make search/reporting traceable and downgrade certainty for bias,
  inconsistency, indirectness, imprecision, and publication bias.
- Recent LLM market-research studies: LLM outputs can help with augmentation and exploratory
  consumer-preference work, but naive substitution for human data introduces bias and can fail across
  categories or segments.

## Gotchas

- **The spreadsheet aura.** A formula with weak inputs still produces a precise-looking fiction. Show
  the sensitivity range and downgrade confidence.
- **Marketing-as-behavior.** A page saying "built for teams" does not prove team workflow support.
  Observe the product or docs.
- **Synthetic consensus.** Ten simulated respondents agreeing is still one model distribution unless
  calibrated against real data.
- **Category mixing.** Enterprise buyers, open-source maintainers, hobbyists, and procurement teams
  are different segments; do not average them into one synthetic customer.
- **Recency drift.** Competitor pricing, packaging, and AI features change quickly. Record access dates
  and prefer current primary surfaces.
