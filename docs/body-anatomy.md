# Body anatomy

A skill body is executable guidance for an agent, not a research essay or product overview. It
must contain enough context to work alone, while keeping lookup material and fillable notes out of
the always-read path.

## Size and structure

Anthropic recommends keeping `SKILL.md` under 500 lines and using progressive disclosure for
supporting material [[2]](./sources.md#2). This catalog treats that as a ceiling, not a target.
Long-context research gives a reason to keep important instructions compact, but it does not
establish a universal ideal line count [[5]](./sources.md#5).

Use the smallest structure that carries the full discipline:

1. **Purpose:** the failure mode and outcome in a few sentences.
2. **Procedure or rules:** ordered actions with short rationales where the reason affects judgment.
3. **Refusals or gotchas:** concrete ways the procedure is commonly defeated.
4. **Completion gate:** inspectable conditions that must be true before handoff.
5. **Bundled resources:** direct links to this skill's own references, when any exist.

Headings may differ when the task needs a different shape. The parts matter more than uniform
ceremony.

## Progressive disclosure

Keep material in `SKILL.md` when the agent needs it on every activation. Move material to
`references/` when it is:

- a fillable run-note frame;
- a language-specific or domain-specific lookup table;
- a detailed evasion catalog; or
- useful only at one named step.

References stay one hop from `SKILL.md`. A bundled reference must not require another catalog
skill or a repository-external file to make sense.

## Rule quality

A rule earns its place when removing it creates a concrete failure. Explain the reason when it
helps the agent handle an unlisted case. Avoid decorative MUST/NEVER language, duplicated summaries,
fixed counts with no behavioral basis, and examples that merely restate the rule.

Negative guidance is most useful when it names the tempting action and its consequence:

```text
Do not widen an assertion until the flake disappears; that hides the nondeterminism instead of
removing it.
```

## Run-note templates

A bundled `references/task-template.md` is a private execution aid, despite the historical
filename. It is warranted when repeated experiments, checkpoints, or evidence would otherwise be
lost across a long run. It is not required for every skill and never replaces a Suspec task packet.
See [Task files](./task-files.md).

## Review checklist

- The body works with this skill installed alone.
- Every section changes agent behavior or preserves needed state.
- Important instructions are not buried in on-demand reading.
- Bundled references are direct, scoped, and named at the step that needs them.
- The body stays below the catalog ceiling without compressing away necessary safety detail.
