---
name: implement
description: Implement one task from a plan.
disable-model-invocation: true
---

Read `./.agent/PLAN.md`. Pick the first task in `todo` status. 

The task has `tests` attribute. It is a list of paths to test files. These 
test files have test cases that are marked via comment `IMPLEMENT-ME`. The 
tests ARE the design: they pin the public API and the behavior contract of 
*crucial* and *public* objects. Agent **MUST** implement them. The 
implementation could have internal objects if it's reasonable. That internal 
objects **MUST NOT** be covered with test cases directly. They are 
implementation details and could be completely changed in the future.

Tests design is the source of truth. Agent **MUST NOT** modify tests.

Work on the implementation until the tests pass.

Then set task status to `review` in `./.agent/PLAN.md`.
