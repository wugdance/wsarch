---
name: grilling
description: Grill the user relentlessly about a plan, decision, or idea. Use when the user wants to stress-test their thinking, or uses any "grill" trigger phrases.
---

Interview the user relentlessly until you reach a shared understanding. Map
this as a **design tree**: every decision branches into the decisions that
hang off it.

Work the tree by resolving one question at a time. For each question, give
your recommended answer.

Format a question like so:

```md
**[Q1] <question title>**

<question body, might be multiple paragraphs, including multiple choices>
```

Finding _facts_ is your job, never the user's. When a question needs a fact
from the environment (filesystem, tools, etc.), dispatch a
sub-agent with a fresh context window to find it; don't ask the user for
anything you could look up yourself. The _decisions_ are the user's: put each
to them and wait.

The session is done when every branch of the design tree has been visited
and nothing is left silently assumed.

Wait to apply any modifications until:

1. the user explicitly confirms you have reached a shared understanding
2. the user asks you to act explicitly
