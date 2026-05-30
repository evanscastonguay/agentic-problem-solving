---
name: s6-implement
description: Step 6 of 6 — Local change to test to self-review to PR loop. Reduce uncertainty with small changes and fast feedback.
---

# Step 6 — Implement

Use when: a small, isolated change where speed matters. First principle: reduce uncertainty with small changes and fast feedback. Review effort should scale with change risk.

## Process

- if a spec or plan file exists at the repo root, read it for scope before starting
- clarify the goal and constraints
- inspect current behavior (read the code before changing it)
- create a feature branch from the default branch
- TDD: write a failing test, make the smallest change, test passes
- run the full test suite to catch regressions
- do the inline self-review (below)
- commit and push
- open a pull request; summarize the change and the test results

## Inline self-review (mandatory, ~30 seconds)

- re-read the diff: does it touch only the files you meant? Any debug prints, commented-out code, or stray edits?
- confirm the test run actually happened and was green — never commit on a red/yellow suite
- if a spec/plan exists, confirm the change matches its scope and decisions; if it diverges, update the doc or stop and ask
- if success criteria were defined, verify each one with evidence before claiming done
- branch/staging sanity: correct feature branch, no accidental staging of config or secrets

## Optional deeper review

For a load-bearing change, before opening the PR, spawn one adversarial reviewer covering:
- correctness and edge cases (try to break it; cite file:line)
- test-coverage gaps (behaviors the diff introduces but tests do not exercise)
- spec alignment (flag scope creep or missing items)

On requested changes: apply, re-push, stop — do not auto-loop.

## Key rules

- TDD: tests fail before implementation, pass after
- full test suite green before pushing
- never amend after push — new fix commits only
- feature branch from the latest default branch
- if success criteria exist: verify each with evidence before claiming done
