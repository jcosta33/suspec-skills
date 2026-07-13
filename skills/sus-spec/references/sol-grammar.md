# SOL Grammar

Use SOL only when rigid clauses earn more than they cost. Plain Markdown remains the default.

## Frontmatter

Set:

```yaml
format: sol
```

## Blocks

Each block starts at column zero:

```text
REQ AC-001:
WHEN the service receives an expired token
THE service MUST reject it
VERIFY BY test:cmdTest:expired-token

CONSTRAINT C-001:
THE public response MUST preserve the documented error code
VERIFY BY contract:cmdContract:error-code

INVARIANT I-001:
Accepted requests MUST retain their request identifier through completion
VERIFY BY property:cmdTest:request-id

INTERFACE IF-001:
`refreshSession` RETURNS `Session | AuthExpired`
ACCEPTS:
  - `refreshToken: string`
ERRORS:
  - invalid-refresh-token
OWNED BY auth-client
VERIFY BY contract:cmdContract:refresh-session

QUESTION Q-001 [blocking]:
Choose whether legacy clients remain supported.
```

Allowed block keywords:

- `REQ`: required observable behavior.
- `CONSTRAINT`: a bound on valid solutions.
- `INVARIANT`: behavior that remains true across states.
- `INTERFACE`: a public or cross-boundary contract.
- `QUESTION`: an unresolved decision; never valid in a ready spec when blocking.

Allowed strength words: `MUST`, `MUST NOT`, `SHOULD`, `SHOULD NOT`, `MAY`.

## Rules

- `REQ` IDs use `AC-NNN`; `CONSTRAINT` IDs use `C-NNN`; `INVARIANT` IDs use `I-NNN`;
  `INTERFACE` IDs use `IF-NNN`; and `QUESTION` IDs use `Q-NNN`. Every ID appears exactly once.
- One block carries one independently verifiable obligation.
- `REQ`, `CONSTRAINT`, and `INVARIANT` contain at least one deliberate strength phrase;
  `INTERFACE` uses declarations instead.
- Every non-question block contains one non-empty `VERIFY BY` line.
- `REQ` conditions use `WHERE`, `WHILE`, `WHEN`, or `IF`; the response begins `THE`.
- A `QUESTION` declares `[blocking]` or `[non-blocking]` in its header.
- Block headers start at column zero. Indent only list values inside declarations.
- A block header contains no requirement text.
- `QUESTION` states options and whether it blocks; it contains no strength word.
- A ready spec contains no blocking `QUESTION`, placeholder, `TBD`, `TODO`, or `???`.
- Lowercase split suffixes such as `AC-004a`, `C-004a`, or `IF-004a` are invalid identifiers.

The notation structures requirements. It does not make vague behavior testable, choose intent, or
replace evidence.
