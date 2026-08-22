---
name: implement
description: Implement one feature from a plan.
disable-model-invocation: true
---

Read `./.agent/PLAN.md`. Pick the first feature in `todo` status. 

The feature has `tests` attribute. It is a list of paths to test files. These 
test files have test cases that are marked via comment `IMPLEMENT-ME`. These 
test cases define design of the public objects' interfaces that **MUST** be 
implemented.

Test cases describe **ONLY** public objects' interfaces. Actual implementation 
could have internal objects if it's reasonable. That internal objects 
**MUST NOT** be covered with test cases directly. They are implementation 
details and could be completely changed in the future.

Tests design is the source of truth. Agent **MUST NOT** modify tests.

Work on the implementation until the tests pass.

Then set feature status to `review` in `./.agent/PLAN.md`.
