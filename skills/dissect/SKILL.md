---
name: dissect
description: Dissect an unfamiliar or high-risk code path before changing or judging it. ALWAYS apply when architecture, callers, control flow, data flow, state, side effects, failures, configuration, tests, or hidden coupling are not already proven. Trace the target to closure and mark every unknown edge. Return a compact evidence map, never a friendly tour. Skip when one known file or symbol fully contains the task or the user requested a persisted whole-area inventory.
---

# Dissect

Do not explore. Establish reachability.

## Boundary

- Pin one question, symbol, workflow, or subsystem and the exact repository state.
- Stay read-only.
- Do not turn a targeted trace into a whole-system inventory, risk audit, or proposal.
- Do not persist a document. A requested persistent current-state map is inventory-authoring work.

## Trace

1. Find every entry point: API, command, route, event, job, callback, registry, generated binding,
   and configuration key.
2. Trace inbound reachability. Include direct callers, dynamic dispatch, string registration,
   reflection, generated call sites, and external boundaries.
3. Trace outbound control flow to every terminal result. Include branches, retries, fallbacks,
   cleanup, cancellation, error translation, and asynchronous continuation.
4. Trace data and state: origin, validation, normalization, mutation, persistence, caches, shared
   state, and externally visible effects.
5. Trace failure paths: invalid input, partial state, concurrency, time, resource exhaustion,
   dependency failure, and recovery.
6. Inspect tests, types, schemas, configuration, documentation, generated files, and build/runtime
   wiring around the path.
7. Close every edge with `file:line` evidence. Mark anything else `Unknown` and name the missing
   evidence.

A negative claim requires the search command and result. A symbol search never proves complete
reachability. Environment, process state, time, randomness, network state, and shared services remain
unknown unless pinned. Record exact boundary operators; `>` and `>=` are different contracts.

Delegate only independent questions with disjoint scope. Demand compact path-to-role results. Read
every load-bearing source yourself before acting.

## Return

Return the smallest map that closes the question:

```text
Question: <one sentence>
State: <stable snapshot>
Flow: <entry -> decisive branches -> terminal effects>

| Path:line | Proven edge, state, effect, or boundary | Unknown |
| --- | --- | --- |

Evidence: <commands needed to prove tests or negative searches, with exits>
```

Do not repeat the table in prose or turn the map into a file.
