# Sources

Primary and official sources outrank summaries. A source supports only claims inside its competence.

## Maintenance

- Update this file in the same change as any externally grounded skill or design rule.
- State what each source supports and where its authority ends.
- Lead with primary research, specifications, and official vendor documentation.
- Label secondary and practitioner material as bounded hypotheses.
- Bound field reports by harness, model, version, and date. Never generalize one setup into a
  portable guarantee.
- Remove a source when its claim leaves or the source no longer supports it.

## Skill Format And Context Economy

- **OpenAI Codex skill documentation.** Official discovery model, shared metadata budget,
  description truncation behavior, invocation policy, and authoring guidance.
  <https://developers.openai.com/codex/skills>
- **Open Agent Skills specification.** Defines `SKILL.md`, frontmatter, description limits, and
  layout. <https://agentskills.io/specification>
- **Agent Skills authoring best practices, Anthropic.** Official guidance on concise bodies,
  calibrated instruction freedom, and evaluation.
  <https://platform.claude.com/docs/en/agents-and-tools/agent-skills/best-practices>
- **Using Agent Skills with the API, Anthropic.** Official confirmation that multiple skills
  explicitly supplied in one API request compose for complex workflows. It does not establish
  implicit cross-skill chaining in local harnesses.
  <https://platform.claude.com/docs/en/build-with-claude/skills-guide>
- **Optimizing skill descriptions, Agent Skills.** Guidance on imperative, intent-based discovery
  metadata. <https://agentskills.io/skill-creation/optimizing-descriptions>
- **Anthropic skill-creator.** Official reference workflow for concise bodies, description
  evaluation, and iterative testing.
  <https://github.com/anthropics/skills/tree/main/skills/skill-creator>
- **Frontify skills authoring notes.** Practitioner synthesis on
  [activation](https://github.com/Frontify/skills/blob/main/docs/activation.md),
  [body anatomy](https://github.com/Frontify/skills/blob/main/docs/body-anatomy.md),
  [execution](https://github.com/Frontify/skills/blob/main/docs/execution.md), and
  [source handling](https://github.com/Frontify/skills/blob/main/docs/sources.md). Useful design
  hypotheses; its small activation experiment does not establish universal wording or length rules.
- **OpenCode Agent Skills.** Official description of on-demand loading from available skill metadata
  through the native skill tool. <https://opencode.ai/docs/skills>
- **Claude Code skill activation experiment, Ivan Seleznov.** Open practitioner experiment where
  directive plus bypass-blocking descriptions improved activation across three skills. One unpinned
  Claude Code setup; it does not isolate each clause, test exclusions or length, or prove portability.
  <https://github.com/SeleznovIvan/claude-skills-test>
- **Claude Skills Have Two Reliability Problems, Not One, Marc Bara.** Practitioner account of
  skipped late-stage checks and the observable-output countermeasure. It explicitly reports no
  controlled execution study; use it as a failure hypothesis, not proof.
  <https://medium.com/@marc.bara.iniesta/claude-skills-have-two-reliability-problems-not-one-299401842ca8>
- **Effective context engineering for AI agents, Anthropic.** Treats context as finite and favors
  just-in-time retrieval and compact external state.
  <https://www.anthropic.com/engineering/effective-context-engineering-for-ai-agents>
- **The new rules of context engineering for Claude 5 generation models, Anthropic.** Reports
  major internal prompt reduction without disclosed benchmark detail; supports testing less
  prescriptive control, not universal deletion.
  <https://claude.com/blog/the-new-rules-of-context-engineering-for-claude-5-generation-models>
- **Latest model prompting guidance, OpenAI.** Reports directional internal coding-agent gains from
  leaner prompts, including lower token use and cost; requires validation on representative work.
  <https://developers.openai.com/api/docs/guides/latest-model>
- **What Should Agents Say? Action-state Communication for Efficient Multi-Agent Systems.** Huang,
  Wu, and Zhang, 2026. Reports a stronger performance-cost tradeoff from compact action-state-result
  handoffs across evaluated multi-agent systems and coding harnesses. Recent preprint; results remain
  model- and harness-specific. <https://arxiv.org/abs/2606.05304>
- **Experience-Driven Early Termination for Cost-Efficient Software Engineering Agents.** Guo et al.,
  2026. Reports lower cost with negligible aggregate resolution loss from stopping unproductive
  iterations using retrieved execution experience. Recent benchmark result; transfer is conditional.
  <https://arxiv.org/abs/2601.05777>
- **Same Task, Different Work: Prompt-Induced Waste in Coding Agents.** Weinberger and Hozez, 2026.
  Reports greater reasoning and verification without measured success gains from unbounded certainty
  and multi-approach prompts in 4,644 valid runs. Recent preregistered preprint.
  <https://arxiv.org/abs/2608.01347>
- **Token Reduction Is Not Cost Reduction.** Weinberger and Hozez, 2026. Reports that removing raw
  tool-output tokens could increase billed cost and that lossy compression damaged exact edit
  anchors. Recent provider- and harness-specific preprint. <https://arxiv.org/abs/2607.12161>
- **Advanced tool use, Anthropic.** Shows how tool definitions and intermediate results can dominate
  context; its internal token reductions are workload-specific.
  <https://www.anthropic.com/engineering/advanced-tool-use>
- **Eval-driven development, Airbnb.** Recommends controls derived from real failures, deterministic
  checks first, and human ownership of disputed quality.
  <https://airbnb.tech/ai-ml/eval-driven-development-lessons-from-evaluating-genai-at-scale/>
- **Harness engineering, OpenAI.** Treats human attention and context as scarce; uses repository
  knowledge as a map and mechanical tests for architecture.
  <https://openai.com/index/harness-engineering/>
- **Inside our in-house data agent, OpenAI.** Reports selection failures from overlapping tools and
  lower robustness from highly prescriptive prompts.
  <https://openai.com/index/inside-our-in-house-data-agent/>
- **Architecting an efficient context-aware multi-agent framework, Google.** Separates durable state
  from compiled agent context and loads large objects by handle.
  <https://developers.googleblog.com/architecting-efficient-context-aware-multi-agent-framework-for-production/>
- **Tool-space interference in the MCP era, Microsoft Research.** Survey of 1,470 MCP servers;
  supports distinct tools, concise outputs, dynamic discovery, and model-client testing.
  <https://www.microsoft.com/en-us/research/blog/tool-space-interference-in-the-mcp-era-designing-for-agent-compatibility-at-scale/>
- **Context Rot, Chroma Research.** Controlled tests across 18 models find increasing unreliability
  with longer context and distractors. Inspectable industry study, not peer-reviewed.
  <https://www.trychroma.com/research/context-rot>
- **Towards a Science of Scaling Agent Systems, Google Research.** Cross-model controlled study:
  multi-agent gains depend on parallelizable task structure and can reverse on sequential work.
  Preprint. <https://arxiv.org/abs/2512.08296>
- **An Empirical Study on Prompt Compression for Large Language Models.** Six methods across thirteen
  datasets find task-dependent effects. Preprint; compression is no universal quality score.
  <https://arxiv.org/abs/2505.00019>
- **ConInstruct.** AAAI 2026 conflict benchmark: strong models often detect conflicts but rarely
  notify the user or seek clarification.
  <https://ojs.aaai.org/index.php/AAAI/article/view/40356>
- **Control Illusion.** AAAI 2026: six leading models show persistent failures under conflicting
  instruction hierarchies.
  <https://ojs.aaai.org/index.php/AAAI/article/view/40339>
- **Curse of Instructions: Large Language Models Cannot Follow Multiple Instructions at Once.**
  Harada et al., ICLR 2025. Measures collapsing joint compliance as instruction count grows.
  <https://openreview.net/forum?id=R6q67CDBCH>
- **Lost in the Middle: How Language Models Use Long Contexts.** Liu et al., TACL 2024. Measures
  position-dependent failures in long contexts. <https://aclanthology.org/2024.tacl-1.9/>
- **Let Me Speak Freely?** Tam et al., EMNLP Industry 2024. Finds that forcing structured formats
  during reasoning can degrade reasoning even when structured output remains useful afterward.
  <https://arxiv.org/abs/2408.02442>

## Evidence And Inspection

- **Large Language Models Cannot Self-Correct Reasoning Yet.** Huang et al., ICLR 2024. Finds that
  intrinsic self-correction without external feedback can degrade accuracy.
  <https://arxiv.org/abs/2310.01798>
- **CRITIC: Large Language Models Can Self-Correct with Tool-Interactive Critiquing.** Gou et al.,
  ICLR 2024. Measures gains when critique uses external tool feedback.
  <https://arxiv.org/abs/2305.11738>
- **Correlated Errors in Large Language Models.** Kim et al., ICML 2025. Measures substantial
  agreement among models when they are wrong, undermining agreement as proof.
  <https://arxiv.org/abs/2506.07962>
- **Towards Understanding Sycophancy in Language Models.** Sharma et al., ICLR 2024. Measures model
  preference for a user's stated belief over truth. <https://arxiv.org/abs/2310.13548>
- **Self-Preference Bias in LLM-as-a-Judge.** Wataoka et al., NeurIPS Safe Generative AI Workshop
  2024. Measures judges favoring their own generations. <https://arxiv.org/abs/2410.21819>
- **The Impact of Code Review Coverage and Participation on Software Quality.** McIntosh et al.,
  MSR 2014. Connects both review coverage and participation with post-release quality.
  <https://doi.org/10.1145/2597073.2597076>
- **Evaluating the accuracy of GPT-4o-generated citations in mental-health literature reviews.**
  JMIR Mental Health 2025. Reports fabricated citations and bibliographic errors, supporting direct
  citation verification. <https://mental.jmir.org/2025/1/e80371>

## Technical Decisions And Panels

- **CRITIC: Large Language Models Can Self-Correct with Tool-Interactive Critiquing.** Gou et al.,
  ICLR 2024. External tool feedback improves correction; unsupported self-reflection does not become
  evidence. <https://openreview.net/forum?id=Sx038qxjek>
- **Improving Factuality and Reasoning in Language Models through Multiagent Debate.** Du et al.,
  ICML 2024. Demonstrates gains from bounded debate on evaluated reasoning tasks; it does not prove
  that more participants or rounds always help. <https://proceedings.mlr.press/v235/du24e.html>
- **Voting or Consensus? Decision-Making in Multi-Agent Debate.** Findings of ACL 2025. Decision
  strategy is task-dependent; no universal aggregation rule wins. Agreement remains a synthesis
  input, not proof. <https://aclanthology.org/2025.findings-acl.606/>
- **Stay Focused: Problem Drift in Multi-Agent Debate.** Findings of EACL 2026. Longer interaction
  can move discussion away from the original problem. Supports one fixed packet and bounded
  follow-up. <https://aclanthology.org/2026.findings-eacl.268/>
- **LLM-Blender.** Jiang et al., ACL 2023. Separating candidate comparison from final synthesis can
  outperform direct generation on evaluated tasks. It does not establish a universal panel size.
  <https://aclanthology.org/2023.acl-long.792/>

## Campaign Coordination

- **Follow a goal, OpenAI.** Defines a durable coding goal by one objective, a verifiable stopping
  condition, source pointers, progress proof, checkpoints, and compact status. Warns against loose
  backlogs and accumulated one-off instructions.
  <https://learn.chatgpt.com/use-cases/follow-goals>
- **Effective harnesses for long-running agents, Anthropic.** Reports one-shot implementation,
  undocumented partial work, and premature completion across fresh contexts; uses incremental work
  and structured continuity artifacts. First-party experiment, not a universal file contract.
  <https://www.anthropic.com/engineering/effective-harnesses-for-long-running-agents>
- **Magentic-One, Microsoft Research.** Separates stable task planning from mutable progress
  tracking in a two-ledger orchestrator and replans on stalls.
  <https://www.microsoft.com/en-us/research/articles/magentic-one-a-generalist-multi-agent-system-for-solving-complex-tasks/>
- **Adding sub-issues, GitHub.** Defines project-native hierarchical work relationships and progress
  across repositories. <https://docs.github.com/en/issues/tracking-your-work-with-issues/using-issues/adding-sub-issues>

- **Git worktree documentation.** Defines linked worktrees, concurrent branch checkout, locking,
  cleaning, and branch-in-use safeguards. <https://git-scm.com/docs/git-worktree>
- **Git switch documentation.** Defines branch creation, detached checkout, and dirty-state behavior.
  <https://git-scm.com/docs/git-switch>
- **About pull request reviews, GitHub.** Defines review comments, approvals, change requests,
  conversation resolution, and protected-branch integration.
  <https://docs.github.com/en/pull-requests/collaborating-with-pull-requests/reviewing-changes-in-pull-requests/about-pull-request-reviews>
- **Commenting on a pull request, GitHub.** Defines line comments, replies, suggestions, and
  conversation resolution.
  <https://docs.github.com/en/pull-requests/collaborating-with-pull-requests/reviewing-changes-in-pull-requests/commenting-on-a-pull-request>
- **How to write code review comments, Google Engineering Practices.** Supports clear reasoning,
  actionable guidance, code-focused language, and explicit severity without inflating every comment.
  <https://google.github.io/eng-practices/review/reviewer/comments.html>
- **Small CLs, Google Engineering Practices.** Supports one self-contained change, early splitting,
  reviewable size, and separate refactors while rejecting a universal numeric limit.
  <https://google.github.io/eng-practices/review/developer/small-cls.html>
- **Choice overload meta-analyses.** Scheibehenne, Greifeneder, and Todd, JCR 2010; Chernev,
  Bockenholt, and Goodman, JCP 2015. Option count has no universal effect or measured optimum;
  complexity, difficulty, uncertainty, and goals matter.
  <https://doi.org/10.1086/651235> <https://doi.org/10.1016/j.jcps.2014.08.002>
- **The effects of change decomposition on code review.** di Biase et al., PeerJ Computer Science
  2019. Controlled experiment: coherent decomposition reduced false-positive findings but did not
  increase defects found. <https://doi.org/10.7717/peerj-cs.193>
- **Characteristics of Useful Code Reviews.** Bosu, Greiler, and Bird, MSR 2015. Across 1.5 million
  Microsoft review comments, changes touching more files received a lower proportion of useful
  comments. <https://doi.org/10.1109/MSR.2015.21>
- **Primers or reminders?** Spadini, Calikli, and Bacchelli, ICSE 2020. Controlled experiment with 85
  developers: visible prior comments prompted similar uncommon findings without suppressing other
  bug detection. <https://doi.org/10.1145/3377811.3380385>
- **The Promise and Reality of Continuous Integration Caching.** Ghaleb, da Costa, and Zou,
  arXiv:2601.19146. Preliminary CI evidence: caching can cut build time, but stale artifacts remain
  common. It does not directly measure local worktree dependencies. <https://arxiv.org/abs/2601.19146>
- **About pull requests, GitHub.** Defines draft and ready-for-review states.
  <https://docs.github.com/en/pull-requests/collaborating-with-pull-requests/proposing-changes-to-your-work-with-pull-requests/about-pull-requests>
- **Pull-request review summary update, GitHub.** A request-changes review needs no summary when its
  inline comments already carry the findings.
  <https://github.blog/changelog/2026-02-19-access-all-pull-request-comments-without-leaving-the-new-files-changed-page/>
- **About protected branches, GitHub.** Defines required review, stale-approval dismissal,
  conversation resolution, and merge queues.
  <https://docs.github.com/en/repositories/configuring-branches-and-merges-in-your-repository/managing-protected-branches/about-protected-branches>
- **Approving a pull request with required reviews, GitHub.** Defines approval and change-request
  clearance. <https://docs.github.com/en/pull-requests/collaborating-with-pull-requests/reviewing-changes-in-pull-requests/approving-a-pull-request-with-required-reviews>
- **Pull requests REST API, GitHub.** Defines expected-head validation for merge requests and the
  write permission required to merge; hard separation therefore requires a credential boundary.
  <https://docs.github.com/en/rest/pulls/pulls>
- **GitHub Issues and milestones.** Issues carry work discussion and assignment; milestones group
  issue and pull-request progress.
  <https://docs.github.com/en/issues/tracking-your-work-with-issues/learning-about-issues/about-issues>
  <https://docs.github.com/en/issues/using-labels-and-milestones-to-track-work/about-milestones>
- **How we built our multi-agent research system, Anthropic.** First-party account of the
  orchestrator-worker pattern, explicit delegation, parallel boundaries, coordination failure, and
  the steep token cost of multi-agent work.
  <https://www.anthropic.com/engineering/built-multi-agent-research-system>
- **Superpowers repository and release notes.** First-party practice reports on design alignment,
  project worktrees, compact dispatch, bounded review, scoped re-review, falsifiable tests, and
  removal of recap prose. Useful implementation evidence; not a controlled external study.
  <https://github.com/obra/superpowers>
  <https://github.com/obra/superpowers/blob/main/RELEASE-NOTES.md>
- **Realizing quality improvement through test driven development.** Nagappan et al., Empirical
  Software Engineering 2008. Four industrial teams reported lower defect density with higher initial
  development time; small observational cases do not establish a universal procedure.
  <https://www.microsoft.com/en-us/research/wp-content/uploads/2009/10/Realizing-Quality-Improvement-Through-Test-Driven-Development-Results-and-Experiences-of-Four-Industrial-Teams-nagappan_tdd.pdf>
- **SWT-Bench.** Mündler et al., NeurIPS 2024. Distinguishes fail-before/pass-after bug reproduction
  tests from irrelevant or merely covering generated tests.
  <https://proceedings.neurips.cc/paper_files/paper/2024/hash/94f093b41fc2666376fb1f667fe282f3-Abstract-Conference.html>
- **TDFlow.** Han et al., EACL 2026. Reports 94.3% on SWE-Bench Verified with human-written tests and
  68.0% with generated tests; oracle generation, not test execution, was the bottleneck. The setup
  exposes tests unavailable in ordinary issue resolution.
  <https://aclanthology.org/2026.eacl-long.70/>
- **Rethinking the Value of Agent-Generated Tests.** Chen et al., arXiv:2602.07900. A six-model
  observational study and four-model prompt intervention found more generated tests did not
  significantly change final outcomes. Preliminary.
  <https://arxiv.org/abs/2602.07900>
- **FrugalGPT.** Chen, Zaharia, and Zou. Treats model cascades as a cost-quality routing problem.
  <https://arxiv.org/abs/2305.05176>
- **RouteLLM.** Ong et al. Evaluates learned routing between weaker and stronger models.
  <https://arxiv.org/abs/2406.18665>

## Research Method

- **GRADE handbook.** Defines evidence-certainty levels and explicit downgrade/upgrade factors.
  <https://gdt.gradepro.org/app/handbook/handbook.html>
- **GRADE: an emerging consensus on rating quality of evidence and strength of recommendations.**
  Guyatt et al., BMJ 2008. Foundational account of evidence-quality grading.
  <https://pmc.ncbi.nlm.nih.gov/articles/PMC2335261/>
- **PRISMA 2020 statement.** Page et al., BMJ 2021. Defines transparent reporting for systematic
  evidence searches and synthesis. <https://www.ncbi.nlm.nih.gov/pmc/articles/PMC8005924/>
- **ICC/ESOMAR International Code on Market, Opinion and Social Research and Data Analytics.**
  Professional requirements for legality, transparency, privacy, method disclosure, and human
  oversight. <https://iccwbo.org/news-publications/business-solutions/iccesomar-international-code-market-opinion-social-research-data-analytics/>
- **AAPOR Disclosure Standards.** Requires population, sample, mode, dates, weighting, quality
  checks, precision limits, and limitations for survey evidence.
  <https://aapor.org/standards-and-ethics/disclosure-standards/>
- **Using LLMs for Market Research.** Brand, Israeli, and Ngwe. Tests synthetic consumer responses
  and records failures to generalize across categories and segments.
  <https://papers.ssrn.com/sol3/papers.cfm?abstract_id=4395751>
- **Large Language Models for Market Research: A Data-Augmentation Approach.** Wang, Zhang, and
  Zhang, Marketing Science 2026. Reports benefits from calibrated augmentation and bias from naive
  substitution. <https://doi.org/10.1287/mksc.2025.0009>
- **Using large language models to generate silicon samples in consumer and marketing research.**
  Sarstedt et al., Psychology & Marketing 2024. Reviews domain-dependent strengths and limits of
  synthetic samples. <https://doi.org/10.1002/mar.21982>

## Distribution And Design References

- **Vercel skills CLI.** Documents global and per-agent installation.
  <https://github.com/vercel-labs/skills>
- **agentskills/agentskills.** Hosts the open specification and reference validator.
  <https://github.com/agentskills/agentskills>
- **oil-oil/codex-explore-skill.** Design reference for delegated codebase reconnaissance and
  compact key-file maps. <https://github.com/oil-oil/codex-explore-skill>
- **shannonbay/setup-structure-index.** Design reference for reusable codebase structure maps.
  <https://github.com/shannonbay/setup-structure-index>

## Citation Discipline

- Verify identity, title, date, and locator before citing.
- Label secondary sources and use them only for their analysis or to locate primary evidence.
- Record contradictory evidence and material rejected sources.
- Replace dead links or mark them unavailable; never silently retain an unverifiable claim.
