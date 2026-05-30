---
name: plan
description: Define scope, phased steps, risks, tests, checkpoints, and the first action, then write the plan to a file.
---

# plan

First principle: a written plan is a persistent save point the agent (and you) can resume from across sessions.

- if a spec or plan file already exists at the repo root, read it first — its decisions are the primary input
- read the relevant code to understand what needs to change
- define scope and deliverables (including explicit out-of-scope)
- lay out phased, testable steps (each phase proves something works)
- identify risks and mitigations
- specify tests and validation
- add checkpoints between phases if useful
- state the first concrete action
- write the plan to a markdown file at the repo root (propose a path if none is given)
