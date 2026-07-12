# Scope

This repository ships portable Agent Skills in plain Markdown. It contains two kinds of guidance:

- **Suspec methodology skills:** author intent artifacts, split work when needed, implement, review,
  and preserve findings through native memories or project channels.
- **General engineering skills:** debugging, security review, evidence, research, planning, and
  shipping disciplines that work without Suspec.

These are catalog groupings, not rigor levels. A task activates the skills whose triggers match.

## What belongs here

- one self-contained `skills/<name>/SKILL.md` per skill;
- bundled references used directly by that skill;
- catalog and installation documentation;
- evidence documentation for catalog design choices; and
- runner-neutral command slots resolved by the consuming repository.

## What stays elsewhere

- project-specific architecture, commands, and conventions;
- runner-specific agent definitions;
- executable automation, hooks, scanners, and network clients;
- product canon and ADRs;
- benchmark harnesses and experimental output; and
- private work tracking.

The catalog may instruct an agent to use an external tool already provided by the consuming
environment. The catalog itself does not ship or silently execute that tool.

## Boundary tests

Before adding material, ask:

1. Does it apply across repositories, or does it belong in one project's `AGENTS.md`?
2. Can the skill work if installed alone?
3. Is this runnable guidance, a bundled resource used by that guidance, or evidence about the
   catalog? If none, it belongs elsewhere.
4. Does it require code or network behavior? If yes, this Markdown-only repository is not its
   implementation home.
5. Does another existing skill already own the behavior? Reconcile the overlap instead of creating
   competing instructions.

## Product boundary

The deterministic checker is earned scaffold. Skills may describe when to run it and how to
interpret its output, but checker implementation and machine contracts live in their own
repositories. A project without the checker still follows the human procedure.
