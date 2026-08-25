---
name: review
description: Make collaborative review with the user for the given task. 
disable-model-invocation: true
---

**The plan** file location:

```bash
"${PWD}/.agent/PLAN.md"
```

Review last commit changes.

Read the plan to get the understanding of the full picture. Pick 
the first task in `review` status to understand the current scope.

Make proposals one at a time and resolve with the user through 1 of 3 options:

1. Apply.
2. Decline.
3. Reconsider with the user comments.

If there are not objectively meaningful proposals agent **MUST NOT** imagine 
them, just tell that current solution is solid. 

After resolving all proposals:

- set the status of the task to `done` in the plan file;
- stage the changes and commit them with meaningful message;
