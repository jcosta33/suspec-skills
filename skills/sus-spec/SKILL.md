---
name: sus-spec
description: Write, revise, or structurally check a verifiable Suspec spec. Use when intent must become requirements or acceptance criteria, or unresolved behavior blocks implementation. Do not use for direct implementation, small clear work, factual verification, or implementation design.
---

# Sus Spec

A spec is decided intent under test. Nothing else belongs.

## Method

Enter on explicit request or after the human selects a Suspec spec workflow for unresolved intent.
Direct implementation does not earn a spec.

Before writing:

1. Read project rules, current code, durable decisions, related artifacts, and open issues.
2. Lock goal, audience, success, boundary, and sources.
3. Burn down facts. When a decision lacks evidence, research it until evidence can carry it.
4. Force material ambiguity into explicit human selection.
5. Resolve reversible conventions. Freeze on material behavior, public contracts, security,
   costly tradeoffs, conflicting authority, and irreversible actions.

Every unresolved choice keeps `status: draft` and blocks dependent work.

## Artifact

Resolve `~/.agents/artifacts/<workspace>/` to an absolute path. Derive `<workspace>` from the
repository or working-directory basename. Write there; keep linked sidecars beside it. A collision
or ambiguous workspace requires human-readable name choices. A blocked write requires: grant access
and retry, choose another agent-neutral user directory, or cancel. Never overwrite or fall back to a
repository, vendor directory, or temporary path.

### Shape

Use this minimal frontmatter shape:

```yaml
---
type: spec
id: SPEC-{{slug}}
title: {{title}}
status: draft
owner: {{owner}}
sources:
  - ISSUE-123
  - /absolute/path/to/source.md
---
```

Keep `sources` a list. Use absolute paths or paths relative to the spec; tracker and decision IDs
remain bare. Make the `SPEC-` ID unique.

Require non-empty `## Intent` and `## Requirements`. Add optional sections only for unique payload.

In plain Markdown, each requirement:

- one stable `### AC-NNN` ID;
- one independently verifiable obligation;
- one deliberate `MUST`, `MUST NOT`, `SHOULD`, `SHOULD NOT`, or `MAY`;
- observable behavior; and
- one concrete `Verify with:` line.

Split independently failing obligations. Put consequence first. Name a mechanism only when
compatibility or public contract makes it observable; state why.

Plain Markdown requirements are the default. When rigid machine-readable clauses earn their cost,
set `format: sol`; use the bundled flush-left `REQ`, `CONSTRAINT`, `INVARIANT`, or `INTERFACE`
forms and `VERIFY BY` syntax in [`references/sol-grammar.md`](./references/sol-grammar.md). In either
format, keep one independently verifiable obligation per requirement or block.

## Verify

Check structure. Revise only when requested. Factual verification is separate.

1. If the `suspec` executable is available, run `suspec check <absolute-spec-path>`.
2. Demand valid frontmatter, unique IDs, non-empty Intent, and one obligation per requirement.
   For plain Markdown, require `### AC-NNN`, one deliberate strength word, and one real
   `Verify with:` line per requirement. For `format: sol`, require the bundled flush-left block
   forms and one non-empty `VERIFY BY` line per non-question block.
3. Reject placeholders, blocking questions at `status: ready`, broken sources, and vague
   requirements with no same-line observable criterion.
4. Cut any section that improves neither clarity, scope, execution, verification, review, nor
   durable memory.
5. In check-only mode, report exact errors without editing. In write/revise mode, fix them and rerun.

## Output

Before handoff, compress and harden the document without changing its contract, identifiers,
verbatim source text, evidence, or behavior. Remove repetition, softness, ceremony, and structural
bloat; write each fact once. Rerun applicable checks. Hand off absolute paths for the spec and every
sidecar.

## Close

After the artifact is fully actioned and no downstream step needs it, require one human disposition
for it and its sidecars: Delete, Leave, or Promote. If Promote is selected, move the transient
working material into project-owned permanence.
Delete selection confirms removal. Verify every selected path is absent; failure blocks close and
reports survivors.
