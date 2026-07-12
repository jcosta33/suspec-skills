# Reference: appraising evidence for a research note

Use this reference when a question turns on empirical results, comparative performance, safety,
reliability, or another outcome claim. Appraise whether the evidence can support the exact claim;
do not rank sources by venue label alone.

## 1. Match evidence to the claim

| Claim type | Strong direct evidence | Common mismatch |
| --- | --- | --- |
| what a standard defines | the current standard or specification | an implementation blog paraphrasing it |
| what an API supports | versioned official docs plus source or executable contract tests | a review or tutorial for another version |
| how a product behaves now | safe direct exercise under recorded conditions | a marketing statement presented as observation |
| comparative performance | a representative benchmark with method, data, variance, and matched conditions | one vendor's unreported workload |
| causal effect | a design that controls alternatives and reports uncertainty | before/after correlation presented as causation |
| prevalence or frequency | a disclosed sampling frame and denominator | examples collected without a population |
| actor intent or announcement | a contemporaneous first-party record | later commentary inferring intent |
| user experience | appropriately sampled user evidence with method disclosure | one anecdote generalized to all users |

A source can be strong for one row and weak for another. Official documentation is authoritative
for its stated contract, not for independent superiority. Peer review raises confidence in process,
not relevance to a different version, population, or workload.

## 2. Appraise the method

For each load-bearing source, record:

- **provenance:** author, publisher, date, version, funding, and conflicts of interest;
- **design:** experiment, observational study, benchmark, survey, case study, or analysis;
- **population and setting:** who or what was measured, under which conditions;
- **measurement:** outcome definition, instruments, baselines, and whether raw data or code exists;
- **uncertainty:** sample size, variance or intervals, missing data, and sensitivity analysis;
- **replication and conflict:** independent corroboration and contrary results; and
- **directness:** how closely the source matches this decision's version, scale, users, and task.

Downgrade confidence for uncontrolled confounding, selective reporting, indirect settings,
imprecision, stale versions, undisclosed methods, conflicts of interest, or unresolved contradictory
evidence. Upgrade only when stronger design or independent replication justifies it. Record the reason,
not just a label.

## 3. Exercise products carefully

When current behavior is load-bearing and safe access exists:

1. record version, account level, region, flags, and date;
2. define the exact action and expected observable before running it;
3. capture the unedited output or screenshot; and
4. distinguish the observed behavior from the inference drawn from it.

Do not exercise a product when doing so would violate access terms, create cost or risk without
authorization, or expose private data. In that case, state the access boundary and rely on the
strongest available contract evidence without claiming direct observation.

## 4. Separate observation from inference

An observation is what the source or run exposes. An inference is what that observation means for
the research question. Keep both visible:

```markdown
Observation: benchmark B reports 4,200 requests/second under workload W on version V.
Inference: this supports the target load only if W, V, hardware, and latency constraints match ours.
Confidence: Moderate; hardware matches, request mix does not.
```

## 5. Preserve material rejections

Record a rejected source when another researcher could reasonably find and reuse it. Name the source
and the specific reason it carries no weight: wrong identity, retracted or corrected result, method
unavailable, superseded version, population mismatch, fabricated citation, or unresolved conflict.
Do not reject solely because a source is a preprint, blog, vendor publication, or unpopular venue;
judge provenance, method, and claim fit.
