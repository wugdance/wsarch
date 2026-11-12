---
name: plan
description: Turn the current conversation into a plan and save it locally — no interview, just synthesis of what you've already discussed.
disable-model-invocation: true
---
# Writing Plans

## Overview

Write implementation plans for an engineer who has not seen this codebase or 
this spec. Assume they write idiomatic code in the project's language once 
they know the exact interface and the exact test, and that they will make a 
reasonable choice wherever the plan leaves one open. What they cannot know 
is what you decided: which files, which names and signatures, which values 
from the spec, which tests prove each task. Document those. Give them the 
whole plan as bite-sized tasks. Don't repeat yourself (DRY). You aren't
gonna need it (YAGNI). Test-driven development (TDD). Frequent commits.

**Save plans to:** `./.agents/plans/<increment-number>-<meaningful-name>.md`. 
For example: `./.agents/plans/0063-generic-protobuf-processing.md`

## Scope Check

Break specs that cover multiple independent subsystems into sub-project 
specs during the conversation. If a spec wasn't split this way, suggest 
breaking this into separate plans — one per subsystem. Each plan should 
produce working, testable software on its own.

## File Structure

Before defining tasks, map out which files will be created or modified and 
what each one is responsible for. This is where decomposition decisions get 
locked in.

- Design units with clear boundaries and well-defined interfaces. Each file 
  should have one clear responsibility.
- You reason best about code you can hold in context at once, and your edits 
  are more reliable when files are focused. Prefer smaller, focused files 
  over large ones that do too much.
- Files that change together should live together. Split by responsibility, 
  not by technical layer.
- In existing codebases, follow established patterns. If the codebase uses 
  large files, don't unilaterally restructure — but if a file you're 
  modifying has grown unwieldy, including a split in the plan is reasonable.

This structure informs the task decomposition. Each task should produce 
self-contained changes that make sense independently.

## Task Right-Sizing

A task is the smallest unit that carries its own test cycle and is worth a
review gate. When drawing task boundaries, fold setup,
configuration, scaffolding, and documentation steps into the task whose
deliverable needs them; split only where a reviewer could meaningfully
reject one task while approving its neighbor. Each task ends with an
independently testable deliverable.

## Step Granularity

**Each step is one action with a checkable result:**
- "Write the failing test" - step
- "Run it to make sure it fails" - step
- "Implement the minimal code to make the test pass" - step
- "Run the tests and make sure they pass" - step
- "Commit" - step

## Plan Document Header

**Every plan MUST start with this header:**

```markdown
# [Feature Name] Implementation Plan

**Goal:** [One sentence describing what this builds]

**Architecture:** [2-3 sentences about approach]

**Tech Stack:** [Key technologies/libraries]

**Spec:** [path to the spec/design doc this plan implements — the plan
argues from the spec, so the spec travels with it; implementers read both]

## Global Constraints

[The spec's project-wide requirements — version floors, dependency limits,
naming and copy rules, platform requirements — one line each, with exact
values copied verbatim from the spec. Every task's requirements implicitly
include this section.]

## Review Focus

[The five input classes or failure modes the spec implies but no task's
tests exercise that are most likely to bite a person using this software
— one line each, naming the input or condition and the behavior a
reasonable person would expect, most likely first. The spec is a vision
document: it says what the software must do, not everything the software
will encounter, and its silence on an input is not permission for that
input to break the program. Write the list here, once, with the spec in
front of you. Then, for each line, add the test that pins it to the task
that owns the code, in that task's own step style.]

---
```

## Task Structure

````markdown
### Task N: [Component Name]

**Files:**
- Create: `exact/path/to/file.py`
- Modify: `exact/path/to/existing.py:123-145`
- Test: `tests/exact/path/to/test.py`

**Interfaces:**
- Consumes: [what this task uses from earlier tasks — exact signatures]
- Produces: [what later tasks rely on — exact function names, parameter
  and return types. A task's implementer sees only their own task; this
  block is how they learn the names and types neighboring tasks use.]

- [ ] **Step 1: Write the failing test**

```python
def test_specific_behavior():
    result = function(input)
    assert result == expected
```

- [ ] **Step 2: Run the test to verify it fails**

Run: `uv run pytest tests/exact/path/to/test.py::test_name -v`
Expected: FAIL with "function not defined"

- [ ] **Step 3: Implement `function(input: InputType) -> ResultType` 
  in `exact/path/to/file.py`**

One line on the approach when the signature and the test leave a choice
(which library call, which data structure); a code block only for an
algorithm they do not determine.

- [ ] **Step 4: Run the test to verify it passes**

Run: `uv run pytest tests/exact/path/to/test.py::test_name -v`
Expected: PASS

- [ ] **Step 5: Commit**

```bash
git add tests/exact/path/to/test.py exact/path/to/file.py
git commit -m "[SDMT-12345] Add specific feature."
```

Commit message must contain the current task ID as a prefix, extracted from 
the branch name, for example `SDMT-12345` from `release/SDMT-12345`.
````

## Step Contents

A step is done when the implementer can write exactly one reasonable thing
from it. That is the whole requirement: unambiguous, not complete. Each kind
of step carries what makes it unambiguous and nothing more:

- **A test step:** the test's name and its assertions, as code, with the
  spec's exact values in them.
- **A code step:** the exact signature (name, parameters, return type), the
  file it lives in, and the specific values the spec pins. The implementer
  writes the body. A body appears only for an algorithm the signature and
  tests do not determine, or for an exact copy the spec fixes.
- **A verification step:** the command to run and the output that means it
  passed.
- **A reference to another task:** that task's Interfaces block says what
  to use; the plan does not repeat that task's code.

A plan is the set of decisions the implementer cannot make alone. A plan
longer than the code it describes has written the code instead. Lines that
decide nothing ("TBD", "handle edge cases", "add appropriate validation",
"write tests for the above", a type or function no task defines) are the
opposite failure, and the self-review catches both.

## Self-Review

After writing the complete plan, look at the spec with fresh eyes and check 
the plan against it. This is a checklist you run yourself — not a subagent 
dispatch.

**1. Spec coverage:** Skim each section or requirement in the spec. Can you 
  point to a task that implements it? List any gaps.

**2. Step scan:** Every step must let the implementer write exactly one 
  reasonable thing, and no step may carry more than that: a line that 
  decides nothing is a gap, a function body the signature and tests already 
  determine is a transcript. Fix both.

**3. Type consistency:** Do the types, method signatures, and property names 
  you used in later tasks match what you defined in earlier tasks? A 
  function called `clearLayers()` in Task 3 but `clearFullLayers()` in 
  Task 7 is a bug.

**4. Review Focus:** For each input class or failure mode the spec implies, 
  is there a task whose tests exercise it? The five uncovered ones most 
  likely to bite a person go in the Review Focus section, and each line there
  gets its test added to the owning task. An empty section means you checked 
  and found none, not that you skipped the check.

**5. Proportion:** Compare the plan's length to the spec's. A plan several 
  times longer than the spec it implements is a transcript of the program, 
  not a plan. If code blocks are most of the document, replace bodies with 
  signatures, test names, and assertions, and check that each step is still 
  unambiguous.

If you find issues, fix them inline. No need to re-review — just fix and move 
on. If you find a spec requirement with no task, add the task.

## Execution Handoff

After saving and self-reviewing the plan, link it for your human partner
to read. Implementation is the scope of another session.
