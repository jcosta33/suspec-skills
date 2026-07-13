---
name: sus-spec
description: Author, revise, or check the structural requirements conformance of a Suspec spec. ALWAYS apply when asked to write or revise a spec, requirements, or acceptance criteria, or when unresolved intent must become a durable contract before non-trivial work can proceed. Survey the project, halt on material ambiguity, write observable requirements with verification, and check required structure. Never prescribe implementation, guess intent, fact-check factual or load-bearing claims, or create ceremony for small clear work.
---

# Sus Spec

A spec converts decided intent into a contract. Nothing more.

## Gate

Do not create a spec for ordinary conversation, a lookup, a one-line cleanup, a defect with an
obvious existing contract, or work already precise enough to execute safely. Create one when the
user requests it or unresolved intent must govern non-trivial work.

Before writing:

1. Read project instructions, current code, durable decisions, related artifacts, and open issues.
2. State the goal, audience, success condition, boundary, and source material.
3. Separate discoverable facts from human-owned choices. Investigate facts first.
4. Decide reversible, convention-bound details. Stop on material behavior, public contracts,
   security tradeoffs, costly choices, conflicting authority, or irreversible actions.

Use the native picker for every blocking choice: three genuine options by default, two when binary,
recommendation first, one-sentence tradeoff each, automatic `Other`. Without a picker, render the
same numbered options plus `Other`. Never ask a bare question. Batch only independent decisions;
ask dependent ones sequentially. A deferred decision leaves the spec `draft` and blocks dependent
work.

## Place

Resolve `~/.agents/artifacts/<workspace>/` to an absolute path, deriving `<workspace>` from the
repository or working-directory basename. Write under that resolved directory. Never write into the
repository, vendor storage, or an OS temporary directory. Never overwrite unrelated work. On a
workspace or filename collision, present distinct human-readable choices. If the root is
unwritable, offer: grant access and retry; choose another agent-neutral user directory; cancel.

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

`sources` is always a list. File-shaped entries are absolute or relative to the spec file; bare
tracker and decision IDs remain valid. The `SPEC-`-prefixed `id` is unique.

`## Intent` and `## Requirements` are mandatory and non-empty. Add `Non-goals`, `Open questions`,
`Affected areas`, or `Dropped from sources` only when each carries unique information.

In plain Markdown, each requirement:

- uses a `### AC-NNN` heading with one stable identifier;
- states one independently verifiable obligation;
- uses `MUST`, `MUST NOT`, `SHOULD`, `SHOULD NOT`, or `MAY` deliberately;
- describes observable behavior, not a preferred mechanism; and
- ends with a concrete `Verify with:` line.

Split obligations that can pass or fail independently. Order the highest-consequence requirements
first. A mechanism belongs only when compatibility or a public contract makes the mechanism itself
observable; state the reason.

Plain Markdown requirements are the default. When rigid machine-readable clauses earn their cost,
set `format: sol`; use the bundled flush-left `REQ`, `CONSTRAINT`, `INVARIANT`, or `INTERFACE`
forms and `VERIFY BY` syntax in [`references/sol-grammar.md`](./references/sol-grammar.md). In either
format, keep one independently verifiable obligation per requirement or block.

## Check

Checking here means structural requirements conformance and is read-only unless revision was
explicitly requested. Factual or load-bearing claim verification is a separate read-only task and
does not activate this skill.

1. Run the project's deterministic artifact checker when available.
2. Confirm frontmatter, unique IDs, non-empty Intent, and one obligation per requirement or block.
   For plain Markdown, require `### AC-NNN`, one deliberate strength word, and one real
   `Verify with:` line per requirement. For `format: sol`, require the bundled flush-left block
   forms and one non-empty `VERIFY BY` line per non-question block.
3. Reject placeholders, unresolved blocking questions at `status: ready`, broken sources, and vague
   requirements with no same-line observable criterion.
4. Run the leverage test: every section must improve clarity, scope, execution context,
   verification, reviewability, or durable memory. Cut empty ceremony.
5. In check-only mode, report exact errors without editing. In write/revise mode, fix them and rerun.

Write each fact once. Do not restate source material or repeat the spec in chat. Return only the
clickable artifact path unless blocked or verification failed.

The spec remains live while implementation, task dispatch, or review needs it. If this skill is the
final consumer, a non-empty transient artifact set exists, no earlier disposition prompt occurred,
and no downstream step needs any transient artifact or sidecar created or consumed by the active
work, ask once about the complete transient set: Delete, Leave, or Promote. Repository-native and
other durable inputs never enter disposition. Recommend from state, give one-sentence tradeoffs,
include every transient path, and include `Other`. Never choose for the human.
