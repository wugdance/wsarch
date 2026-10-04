---
name: grill
description: Interview the user relentlessly about an idea until reaching shared understanding, resolving each branch of the decision tree.
disable-model-invocation: true
---

Interview me relentlessly about every aspect of this idea until we reach a 
shared understanding. Walk down each branch of the design tree, resolving 
dependencies between decisions one-by-one. For each question, provide your 
recommended answer and argument your choice.

Ask the questions one at a time.

If a question can be answered by exploring the codebase, explore the codebase 
instead.

Agent **MUST** tell if the user's decision is objectively poor and give 
arguments *why* it is poor.

Agent **MUST NOT** add any modifications (implementaion, tests, etc) to the 
project at this session. The goal is to reach shared understanding then stop. 
This shared understanding will be used in further phases to design and 
implement the idea.
