---
name: design
description: Make an implementation design through writing tests.
disable-model-invocation: true
---

The plan file location:

```bash
"${PWD}/.agent/PLAN.md"
```

This skill produces the **interface design** by writing tests. The 
tests ARE the design: they pin the public API and the behavior contract of 
*crucial* and *public* objects. Implementation is a **side detail** handled by 
others. Agent **MUST NOT** design internal architecture here.

Read the plan file. Pick first task in `open` status. 

Anaylyze existed tests in the project. Consider whether any of them should be 
modified and what new tests should be written. Apply modifications to
the tests. 

Every test that pins the public API / behavior contract — whether newly 
written or modified — must be preceded by a line comment `IMPLEMENT-ME` 
directly above its definition. 

The concrete example on python code (codebase could have different language):

```python
# IMPLEMENT-ME
def test_1():
    """The new test agent created."""
    ...

# IMPLEMENT-ME
def test_2():
    """Existed and agent modifed it."""
    ...

def test_3():
    """Existed and agent did not modify it."""
    ...
```

These tests will become definition of done for the task.

Then let the user review and refactor these interfaces defined by tests.
Agent **MUST** reach an agreement about the design with the user explicitly. 
Agent **MUST** tell if the user's decision is objectively poor and give 
arguments *why* it is poor.

The design resulting from the review may conflict with the plan. That design 
has precedence over the plan. Agent **MUST** keep the design consistent with 
the plan, so update the plan file if needed.

After reaching agreement modify the task attributes in the plan file:

- set the status to `todo`;
- write relative paths of the created/modified test files into `tests`;
- stage the changes and commit them with meaningful message;
