# Self-containment

Skills install independently. Every `SKILL.md` must remain complete when no other skill from this
catalog is present.

## Rules

1. **Restate load-bearing discipline inline.** A rule required for this skill to work cannot live
   only in a sibling skill.
2. **Use conditional sibling pointers only as enrichment.** A pointer may say "if installed" when
   the current body already carries everything required. A plain task-routing mention is also fine
   when removing it would not break the procedure.
3. **Keep bundled links inside the skill folder.** `SKILL.md` may link directly to its own
   `references/`. Product evidence and repository meta-docs do not belong in installed skill text.
4. **Resolve project facts locally.** Commands, paths, stack details, and conventions come from the
   consuming repository's `AGENTS.md` or equivalent project documentation. Missing commands are
   questions, not invitations to guess.
5. **Name artifacts by role and full path.** Once an artifact exists, carry its resolved full path
   through prompts and notes. Do not hardcode a universal storage directory.

## Artifact placement

Methodology skills that create an artifact use this paragraph verbatim:

Place the file next to your own native artifacts — the same place you keep your plans,
notes, and memories for this work, in a folder named after the repo you are working on
(or wherever fits your harness best). You choose the exact spot; keep it out of the repo
unless the project's own governance says otherwise, and carry the file's full path
forward — every later step names artifacts by explicit path.

This is placement guidance, not a new storage system. Project governance can choose an in-repo
location. Native harness artifacts remain valid when no filesystem path is exposed; the agent must
then use the harness's stable identifier wherever a path would otherwise be named.

## Command contract

Skills name abstract command purposes such as test, lint, typecheck, validate, benchmark, or
dependency checks. The consuming repository maps those purposes to concrete commands. A skill must
not assume `npm`, `pytest`, `cargo`, or any other toolchain.

## Review checklist

- Installing only this folder leaves no missing instruction.
- Every linked file ships inside this folder.
- Sibling references are nonessential and marked conditional when they carry enrichment.
- Project commands and paths are resolved from the project.
- Created artifacts use native placement and are carried forward by stable full path or identifier.
