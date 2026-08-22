---
name: plan
description: Make an implementation plan of the idea.
disable-model-invocation: true
---

Read the current session's conversation to extract the shared understanding 
of the idea, then write an implementation plan. 

The plan is primarily intended for the agent, so include all the details that 
will help to optimize their work.

## Structure

The plan must include:

- goal;
- details;
- features;

### Features

Implementation must be broken down into features. A feature must be a 
complete logical block that could be covered with tests. A feature template:

```md
---
id: <1-2-3-...>
name: <feature-name>
tests: [<path-1>, <path-2>, ...]
status: <open -> todo -> review -> done>
---
```

Each feature has unique `id`.

All features must be in `open` status.

Attribute `tests` must be an empty list.

## Output

Create file `./.agent/PLAN.md` and write the plan into it.

