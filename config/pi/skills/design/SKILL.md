---
name: design
description: Make an implementation design through writing tests.
disable-model-invocation: true
---

This skill produces the **interface design** by writing tests. The 
tests ARE the design: they pin the public API and the behavior contract of 
*crucial* and *public* objects. Implementation is a **side detail** handled by 
the `implement` skill. Agent **MUST NOT** design internal architecture here.

Read `./.agent/PLAN.md`. Pick first task in `open` status. 

Write tests and leave a comment with the text `IMPLEMENT-ME` beside each 
test definition.

These tests will become definition of done for the task.

Then review and refactor these interfaces define by tests with the user until 
you reach an agreement. You can argue if the user's decision is objectively 
poor.

After reaching agreement modify the task attributes in `./.agent/PLAN.md`:

- set the status to `todo`;
- write relative paths of the created/modified test files into `tests`;
