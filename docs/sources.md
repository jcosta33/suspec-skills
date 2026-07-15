# Sources

Primary and official sources outrank summaries. A source supports only claims inside its competence.

## Skill Format And Context Economy

- **OpenAI Codex skill documentation.** Official discovery model, shared metadata budget,
  description truncation behavior, invocation policy, and authoring guidance.
  <https://developers.openai.com/codex/skills>
- **Open Agent Skills specification.** Defines `SKILL.md`, frontmatter, description limits, layout,
  and progressive disclosure. <https://agentskills.io/specification>
- **Agent Skills authoring best practices, Anthropic.** Official guidance on concise bodies,
  progressive disclosure, calibrated instruction freedom, and evaluation.
  <https://platform.claude.com/docs/en/agents-and-tools/agent-skills/best-practices>
- **Using Agent Skills with the API, Anthropic.** Official confirmation that multiple skills
  explicitly supplied in one API request compose for complex workflows. It does not establish
  implicit cross-skill chaining in local harnesses.
  <https://platform.claude.com/docs/en/build-with-claude/skills-guide>
- **Optimizing skill descriptions, Agent Skills.** Guidance on imperative, intent-based discovery
  metadata. <https://agentskills.io/skill-creation/optimizing-descriptions>
- **Anthropic skill-creator.** Official reference workflow for concise bodies, progressive
  disclosure, description evaluation, and iterative testing.
  <https://github.com/anthropics/skills/tree/main/skills/skill-creator>
- **Frontify skills authoring notes.** Practitioner synthesis on activation, body structure, and
  execution. Useful design hypotheses; its small activation experiment does not establish universal
  wording or length rules. <https://github.com/Frontify/skills/tree/main/docs>
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

## Campaign Coordination

- **Git worktree documentation.** Defines linked worktrees, concurrent branch checkout, locking,
  cleaning, and branch-in-use safeguards. <https://git-scm.com/docs/git-worktree>
- **Git switch documentation.** Defines branch creation, detached checkout, and dirty-state behavior.
  <https://git-scm.com/docs/git-switch>
- **About pull request reviews, GitHub.** Defines review comments, approvals, change requests,
  conversation resolution, and protected-branch integration.
  <https://docs.github.com/en/pull-requests/collaborating-with-pull-requests/reviewing-changes-in-pull-requests/about-pull-request-reviews>
- **About pull requests, GitHub.** Defines draft and ready-for-review states.
  <https://docs.github.com/en/pull-requests/collaborating-with-pull-requests/proposing-changes-to-your-work-with-pull-requests/about-pull-requests>
- **About protected branches, GitHub.** Defines required review, stale-approval dismissal,
  conversation resolution, and merge queues.
  <https://docs.github.com/en/repositories/configuring-branches-and-merges-in-your-repository/managing-protected-branches/about-protected-branches>
- **Approving a pull request with required reviews, GitHub.** Defines approval and change-request
  clearance. <https://docs.github.com/en/pull-requests/collaborating-with-pull-requests/reviewing-changes-in-pull-requests/approving-a-pull-request-with-required-reviews>
- **Pull requests REST API, GitHub.** Defines expected-head validation for merge requests.
  <https://docs.github.com/en/rest/pulls/pulls>
- **How we built our multi-agent research system, Anthropic.** First-party account of the
  orchestrator-worker pattern, explicit delegation, parallel boundaries, coordination failure, and
  the steep token cost of multi-agent work.
  <https://www.anthropic.com/engineering/built-multi-agent-research-system>
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
