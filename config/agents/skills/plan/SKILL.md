---
name: plan
description: Make an implementation plan from the session context.
disable-model-invocation: true
---

Analyze the current session context and create an implementation plan.

This implementation plan will be used in a future session by an agent. Make
sure to include all details that will improve the quality of the agent's
result. Be wise and precise about which tokens are chosen. Better tokens —
better result.

The plan **MUST** have a structure so it is easy for an agent to understand
and implement.

The implementation plan **MUST** be divided into chunks (sub-tasks) so that
an agent can pick and implement one small, digestible step at a time and
make precise, high-quality iterations over the plan.

Put a plan file into the `~/tmp/agents/plans/` directory. Template for the file
name: `{increment}-{plan name}.md`. For example, `0001-integrate-threads.md`
or `0236-simplifying-public-api.md`.
