# Why Skills Work

Free-form prompting is flexible but inconsistent: it misses constraints, over-produces, and loses the thread. A skill is a small, named protocol with a clear intent, a minimal input, a bounded output, and a stopping rule. Run a problem through a few of them in order and the agent stops drifting. The six skills here are one implementation of that idea.

## The shift: from asking to directing outcomes

Instead of asking for an output, you assign an outcome with constraints and let the agent choose the protocol to reach it.

- You define the result; the agent manages the steps.
- You give constraints and evidence up front.
- You accept a smaller, more structured output at each step.
- The agent stops when a protocol ends, instead of drifting.

## The smallest prompt that changes everything

Chat level:

> Write a function to parse this file.

Outcome level:

> Goal: find the bug in this folder and propose a fix.
> Context: the error appears in file upload; stack trace attached.
> Constraints: do not change public APIs; keep changes minimal.
> Output: three bullets — root cause, fix, verification.
> Verify: include the exact test or command to validate.

Same request. The second gives the agent a target, a boundary, and a way to prove it is done. Use this shape whenever the request matters: objective, constraints, evidence, boundary, deliverable.

## Principles

- **Outcome first.** Define the expected result before doing work.
- **Small steps, fast feedback.** Reduce uncertainty with short loops.
- **Explicit constraints.** Scope, risk, and non-goals early.
- **Evidence over guesswork.** Verify with tests, data, or real artifacts.
- **Anchor on what exists.** Existing code and docs are the source of truth.
- **Right context, not most context.** Environment, project, task, evidence, each kept explicit and bounded.

## Units of work

Problems compose in layers: an **objective** (the outcome), **tasks** (deliverables that advance it), **phases** (chunks with their own validation), **steps** (the smallest verifiable action). Make the level explicit and the agent stays aligned; leave it implicit and it over-scopes.

## The phases and the skills

| Phase | Skill |
|---|---|
| Sense and frame | `s1-explore`, `s2-clarify`, `s3-define` |
| Decide | `s4-solutions` |
| Plan enough to reduce risk | `s5-plan` |
| Execute and validate | `s6-implement`, with `tdd` for new behavior |
| Hand off | `handoff` |

`s2-grill-me` and `ubiquitous-language` support any phase: the first lets the agent interrogate your plan, the second pins down the words before the design.

## How much process

Pick the smallest protocol that reduces uncertainty enough to proceed.

| Go fast when | Go deep when |
|---|---|
| isolated change | cross-module impact |
| clear acceptance criteria | unclear system behavior |
| low risk | high risk or compliance |
| local tests available | integration or deployment needed |

**Quick fix, low risk.** `s2-clarify` the goal, then `s6-implement`: smallest change, local tests, summarize. Skip everything else.

**Ambiguous bug report.** `s2-clarify` until the report is concrete. `s3-define` the problem and what fixed looks like. If more than one fix is plausible, `s4-solutions`. `s5-plan` if it spans more than one phase. Then `s6-implement`.

**New feature with integration risk.** `s1-explore` the current behavior. `s3-define` scope, constraints, success. `s4-solutions` to choose an approach. `s5-plan` in phases with tests per phase. `s6-implement` phase by phase, pairing with `tdd` where behavior is new. `handoff` at the end of every session.

## Definition of done

- An artifact that matches the objective.
- Evidence of correctness: tests, checks, or validation.
- A clear summary of what changed and why.
- Known limitations or follow-ups, if any.

Solve problems in clear phases, with bounded protocols and disciplined context. The skills are just the phases written down so you never have to remember them.
