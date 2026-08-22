---
name: design
description: Make implementation design through writing tests.
disable-model-invocation: true
---

This skill produces the feature's **interface design** by writing tests. The 
tests ARE the design: they pin the public API and the behavior contract of 
*crucial* and *public* objects. Implementation is a **side detail** handled by 
the `implement` skill. Agnet **MUST NOT** design internal architecture here.

Read `./.agent/PLAN.md`. Pick first feature in `open` status. 

Write tests that will determine *crucial* and *public* objects' interfaces 
at the given scope. Leave a comment with the text `IMPLEMENT-ME` beside each 
test definition.

These tests will become definition of done for the feature.

Then review and refactor these interfaces with the user until you reach an 
agreement. You can argue if the user's decision is objectively bad.

After reaching agreement modify feature attributes in `./.agent/PLAN.md`:

- set the status to `todo`;
- write relative paths of the created/modified test files into `tests`;
