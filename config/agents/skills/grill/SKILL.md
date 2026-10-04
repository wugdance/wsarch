---
name: grill
description: Interview the user relentlessly about a task until reaching shared understanding, resolving each branch of the decision tree.
disable-model-invocation: true
---

Interview me relentlessly about every aspect of this task until we reach a
shared understanding. Walk down each branch of the design tree, resolving
dependencies between decisions one by one. For each question, provide your
recommended answer and justify your choice.

By default, your answer and recommendation should be concise.

If I don't get the point or want more details to think about a
question, I will ask you explicitly to explain. In this case, you **MUST**
present both sides: pros and cons.

All arguments must be rational. You don't need to please me. We need to
find a robust, clean, high-quality, and explicit solution based on the needs.

Ask the questions one at a time.

If a question can be answered by exploring the codebase, explore the codebase
instead.

Make sure not to go out of the task scope.

You **MUST NOT** add any modifications (implementation, tests, etc.) until:
- shared understanding is reached;
- I ask you explicitly.
