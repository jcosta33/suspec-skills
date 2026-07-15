---
name: dissect
description: Trace one unfamiliar or dangerous code path to closure. ALWAYS apply when its callers, flow, state, effects, failures, configuration, tests, or coupling remain unproven. Skip contained work and whole-area inventory.
---

# Dissect

Trace it to bedrock.

1. Freeze one question, symbol, workflow, or subsystem and repository state.
2. Find every entry: API, command, route, event, job, callback, registry, generated binding,
   and configuration key.
3. Trace inbound callers, including dynamic dispatch, string registration, reflection, and generated
   call sites.
4. Trace every branch to terminal effects, including retries, fallbacks, cleanup, cancellation,
   error translation, and asynchronous continuation.
5. Trace data, mutation, persistence, caches, shared state, and external effects.
6. Trace invalid input, partial state, concurrency, time, exhaustion, dependency failure, and
   recovery.
7. Inspect tests, types, schemas, configuration, documentation, generated files, and runtime wiring.
8. Close every edge with `file:line` evidence. Mark every gap `Unknown` and name missing proof.

Negative claims require the search command and result. Symbol search does not prove reachability.
Record exact boundary operators.

Return only:

```text
Question: <one sentence>
State: <stable snapshot>
Flow: <entry -> decisive branches -> terminal effects>

| Path:line | Proven edge, state, effect, or boundary | Unknown |
| --- | --- | --- |

Evidence: <command; working directory; state identifier; numeric exit; untouched decisive output>
```
