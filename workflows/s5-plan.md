---
description: Step 5 of 6 — Define scope, phased steps, risks, tests, checkpoints, and the first action, then write the plan to a file. Use when the user asks for a plan, roadmap, or phased steps, or before implementing anything non-trivial.
---

# s5-plan Workflow

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
