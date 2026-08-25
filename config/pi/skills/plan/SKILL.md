---
name: plan
description: Make an implementation plan of the idea.
disable-model-invocation: true
---

Read the current session's conversation to extract the shared understanding 
of the idea, then write an implementation plan into the file:

```bash
"${PWD}/.agent/PLAN.md"
```


The plan is primarily intended for the agent, so include all the details that 
will help to optimize their work.

## Structure

The plan must include:

- goal;
- details;
- tasks;

### Tasks

Implementation must be broken down into tasks. A task must be a 
complete logical block that could be covered with tests. 

A task template:

```md
---
id: <1-2-3-...>
name: <task-name>
desc: <what-is-the-task-scope>
tests: [<path-1>, <path-2>, ...]
status: <open -> todo -> review -> done>
---
```

Each task has unique `id`.

All tasks must be in `open` status.

Attribute `tests` must be an empty list.
