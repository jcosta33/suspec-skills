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
5. **Name artifacts by role and absolute path.** Ordinary Suspec artifacts use
   `~/.agents/artifacts/<workspace>/`. Resolve `~` and carry the resulting absolute path
   through prompts and notes.

## Artifact placement

Methodology skills that create an artifact use this paragraph verbatim:

Place the file under `~/.agents/artifacts/<workspace>/`, resolving `~` to the absolute
home path and deriving `<workspace>` from the repository or working-directory basename. Keep it
out of the repository and carry its absolute path forward. If the workspace name or target path
conflicts with unrelated work, stop for a structured human choice; never overwrite. If the root is
unwritable, offer grant access and retry, another agent-neutral user directory, or cancel. Never
fall back to vendor storage, the repository, or a temporary directory.

This is a passive workspace convention, not a managed storage system. It creates no registry,
resolver, configuration, lifecycle state, or cleanup mechanism. Plan Mode, vendor-native plans,
native memory, source code, build output, and harness-managed state remain native.

## Command contract

Skills name abstract command purposes such as test, lint, typecheck, validate, benchmark, or
dependency checks. The consuming repository maps those purposes to concrete commands. A skill must
not assume `npm`, `pytest`, `cargo`, or any other toolchain.

## Review checklist

- Installing only this folder leaves no missing instruction.
- Every linked file ships inside this folder.
- Sibling references are nonessential and marked conditional when they carry enrichment.
- Project commands and paths are resolved from the project.
- Ordinary Suspec artifacts use agent-neutral placement and are carried forward by absolute path.
