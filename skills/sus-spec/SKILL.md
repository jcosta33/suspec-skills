---
name: sus-spec
description: Forge decided intent into a verifiable Suspec spec. ALWAYS apply when asked to write, revise, or structurally check a spec, requirements, or acceptance criteria, and when unresolved intent must govern non-trivial work. Survey reality, stop on ambiguity, and write observable obligations with proof. Skip small clear work, factual verification, and implementation design.
---

# Sus Spec

A spec is decided intent under test. Nothing else belongs.

## Gate

Enter on explicit request or when undecided intent must govern non-trivial work. Small clear work
does not earn a spec.

Before writing:

1. Read project rules, current code, durable decisions, related artifacts, and open issues.
2. Lock goal, audience, success, boundary, and sources.
3. Burn down facts. Expose human-owned choices.
4. Resolve reversible conventions. Freeze on material behavior, public contracts, security,
   costly tradeoffs, conflicting authority, and irreversible actions.

Every unresolved choice keeps `status: draft` and blocks dependent work.

## Place

Resolve `~/.agents/artifacts/<workspace>/` to an absolute path. Derive `<workspace>` from the
repository or working-directory basename. Write there. A collision, ambiguous workspace, or blocked
write requires human selection. Repository, vendor, and OS temporary paths are invalid.

## Shape

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

## Check

Check structure. Revise only when requested. Factual verification is separate.

1. Run the deterministic artifact checker when available.
2. Demand valid frontmatter, unique IDs, non-empty Intent, and one obligation per requirement.
   For plain Markdown, require `### AC-NNN`, one deliberate strength word, and one real
   `Verify with:` line per requirement. For `format: sol`, require the bundled flush-left block
   forms and one non-empty `VERIFY BY` line per non-question block.
3. Reject placeholders, blocking questions at `status: ready`, broken sources, and vague
   requirements with no same-line observable criterion.
4. Cut any section that improves neither clarity, scope, execution, verification, review, nor
   durable memory.
5. In check-only mode, report exact errors without editing. In write/revise mode, fix them and rerun.

Write each fact once. Hand off the absolute path. After the artifact is fully actioned and no
downstream step needs it, require one human disposition for it and its sidecars: Delete, Leave, or
Promote.
