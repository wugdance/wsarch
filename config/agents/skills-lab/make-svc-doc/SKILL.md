---
name: make-svc-doc
description: Create highly understandable, visually polished documentation for the given service in a QA context.
disable-model-invocation: true
---

Inspect the provided local repository by provided path.

Inspect the codebase and create visual documentation of
this service. Put the result into the file `./docs/index.html`. 

## Important details

### Why do we need it at all?

The main goal of this documentation is to understand the system deeply. It
should be friendly to a new person who doesn't know this system at all,
sees it for the first time, and tries to understand it from scratch. At the
same time, it should be helpful to someone who knows it and wants to recap
or refresh their knowledge.

### Why visual

Visualization is a crucial attribute of this documentation. Therefore, the
documentation should be fully powered by `HTML` and `CSS`. Make sure to unlock
the full potential of these tools to create visual elements that look perfect
and greatly improve understanding.

Visualizing is a much better way to understand the system logic, so feel 
free to include tables, graphs, charts, diagrams, maps, dashboards, etc. 

Ensure that all elements are big enough, easy to visually scan, and the text is 
easy to read.

### Should we have interactivity

The interactive part of the documentation can also be helpful. Use `CSS` and
embedded `JavaScript` wisely for this purpose. Make sure not to overload the
documentation with interactivity. Remember that, first of all, interactivity
must help with gaining understanding.

### Who are the users

The users of this documentation are QA engineers. They want to use this
understanding to design high-quality E2E tests for this system and automate
them. So, the documentation must focus on the aspects of the system that are
most valuable to know for QA engineers. QA engineers look at the system as a
black box: it takes some input -> it has some expected behaviour -> QA must
ensure that the expected behaviour for a given input is produced. At the same
time, there are some implementation details that are worth knowing, so do not
be afraid of including them.

### Domain field

There are two sides to understanding the system: business (domain field) and
technical. The documentation must cover both of them. Understanding both of
these sides is critically important for designing proper tests for the system.

The documentation must be clearly separated into 2 parts: one for describing 
business logic and one for describing implementation details. QA engineers 
must be able to understand the domain field and then to analyze technical 
implementation.

### Language

The end users are Russians, so the main documentation language must be Russian. 

## It is not about

### Not about test cases

This documentation should help with understanding how the system works. It should 
not provide suggestions about test design and should not describe exact test 
cases to check. Test design is a responsibility of QA engineers, and they will 
**use** this documentation as one of the foundations for it.

### Not about platform capabilities

We assume that QA engineers are familiar with the capabilities of the company's 
platform. They know the tools and how to use them. We do not need to describe them 
in the documentation.

### Not about tools

QA engineers must know their stack: what technologies can be used to interact 
with the described system. The documentation should not contain it. 
