---
name: grill
description: Grill the user relentlessly about a plan, decision, or idea. 
disable-model-invocation: true
---

Interview the user relentlessly until you reach a shared understanding. Map 
this as a **design tree**: every decision branches into the decisions that 
hang off it.

Work the tree by resolving one question at a time. For each question give 
your recommended answer. Recommended answers should be rational. The goal is 
to resolve a question with a high-quality decision, not to please the user's ego.

Format a question as follows:

```
---

**[Q1] <question title>**

<question body, might be multiple paragraphs, including multiple choices>

**Recomendation.** 

<your recommended answer>
```

Each question the user answers could reshape the tree. 

Finding _facts_ is your job, never the user's. When a frontier question 
needs a fact from the environment (filesystem, tools, etc.), dispatch a 
sub-agent with a fresh context window to find it; don't ask the user for 
anything you could look up yourself. Don't block on it: a running exploration 
is an unsettled prerequisite, so only the questions downstream of it wait 
for the sub-agent to report; ask the rest of them now. The _decisions_ are 
the user's: put each to them and wait.

The session is done when every branch of the design tree has been visited 
and nothing is left silently assumed. Do not act on it until the user confirms 
you have reached a shared understanding and explicitly asks you to act.

