# Activation

The `description` field is a skill's discovery contract. The Agent Skills specification places
it in frontmatter and limits it to 1024 characters [[1]](./sources.md#1). Harness behavior varies:
some implementations expose only metadata until activation, while current Claude Code plugin
reports show cases where full bodies are loaded eagerly [[17]](./sources.md#17)[[34]](./sources.md#34).
Write the description so it remains useful under either behavior.

## Catalog convention

Descriptions in this catalog carry four pieces of information:

```text
<Action verb> <target and outcome>.
ALWAYS apply when <observable task triggers>.
Do not <the tempting shortcut or unsafe substitution>.
Skip for <adjacent task types outside this skill's scope>.
```

This is a catalog convention, not an Agent Skills schema requirement. Official guidance favors
clear, concise descriptions that state what the skill does and when to use it
[[2]](./sources.md#2)[[9]](./sources.md#9). A practitioner experiment also found better activation
for directive descriptions with explicit exclusions, but its result is specific to the tested
Claude Code setup and is not a universal activation guarantee [[3]](./sources.md#3).

## Writing rules

1. **Lead with the work.** Start with a concrete verb and object. The first sentence must let an
   agent distinguish this skill from neighboring task types.
2. **Name observable triggers.** Use user requests, referenced artifacts, or recognizable failure
   states. Do not rely on an internal label the user must already know.
3. **Block the likely bypass.** State the shortcut that would defeat the skill's purpose, such as
   editing before reproducing a defect or declaring success without rerunning evidence.
4. **Exclude task types, not sibling names.** A selectively installed skill cannot assume another
   catalog skill exists. Describe the work that is out of scope.
5. **Spend the schema budget on distinctions.** The specification's 1024-character cap is the
   limit. There is no evidence-backed minimum or narrower universal sweet spot.
6. **Test ambiguous trigger pairs together.** A new or revised description is not done until a
   contributor compares it with the descriptions most likely to overlap.

## Example

```yaml
description: >-
  Implement a fix task: reproduce the defect, patch the root cause, bind a
  regression test that fails before the patch and passes after. ALWAYS apply
  when asked to fix a deterministic bug or regression. Do not patch a guessed
  cause. Skip for diagnosis-only reports, flaky tests, or behavior-preserving
  refactors.
```

The wording identifies the action, trigger, refusal, and exclusions without promising that a
particular harness will activate it perfectly.

## Review checklist

- The action and target are concrete.
- Triggers are observable from the request or repository state.
- The refused shortcut protects the skill's defining discipline.
- Exclusions describe adjacent work without assuming another skill is installed.
- The description is within the specification limit and contains no duplicate clauses.
