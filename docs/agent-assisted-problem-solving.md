# Agent-Assisted Problem Solving (Skill-Based Workflow)

## Summary

This document captures the core idea behind using an AI agent with structured "skills" to drive outcomes. Instead of open-ended prompting, we use small, named problem-solving protocols that make work more predictable, reduce cognitive load, and keep progress aligned with real-world constraints.

## Audience and Scope

- Audience: engineers and tech leads who want reliable AI-assisted delivery
- Scope: general problem solving (software, docs, troubleshooting, analysis)
- Out of scope: tool setup, repo specifics, deployment mechanics

## Why This Exists

Free-form prompting is flexible but inconsistent. It often misses constraints, over-produces output, and loses the thread of the task. A skill-based workflow solves this by turning problem-solving into a series of small, repeatable protocols with clear inputs and outputs.

## The Shift: From Asking to Directing Outcomes

The core change is responsibility. Instead of asking for an output, you assign an outcome with constraints and let the agent choose the right protocol to reach it.

What changes in practice:

- You define the result; the agent manages the steps.
- You give constraints and evidence up front.
- You accept a smaller, more structured output each step.
- The agent stops when a protocol ends, instead of drifting.

## Minimum Request Format (Works Across Domains)

Use this format when the request matters or the risk is high:

- Objective: what good looks like in one sentence
- Constraints: non-goals, performance, compatibility, or timeline
- Evidence: files, errors, logs, URLs, or references
- Boundary: what is in scope vs out of scope
- Deliverable: code, doc, decision, plan, or investigation

## Core Principles (First Principles)

- Outcome focus: define the expected result before doing work.
- Progressive disclosure: start simple, expand only when needed.
- Small steps, fast feedback: reduce uncertainty with short loops.
- Explicit constraints: clarify scope, risk, and non-goals early.
- Evidence over guesswork: verify with tests, data, or real artifacts.
- Single source of truth: prefer existing docs or code as the anchor.

## Units of Work (How Problems Are Structured)

Think in layers that compose:

- Objective: the high-level outcome (business or technical)
- Task: a concrete deliverable that advances the objective
- Phase: a chunk of work with its own validation
- Step: the smallest action that can be executed and verified

This structure prevents over-scoping and helps the agent stay aligned.

## What a "Skill" Really Is

A skill is a small protocol with:

- a clear intent (what problem it solves)
- a minimal input format (what the agent needs)
- a bounded output (what you will get)
- a stopping rule (when it ends)

Skills are not magic commands. They are contracts that reduce ambiguity and help both humans and agents stay aligned on the next action.

## Skill-Based Workflow (Phases, Not Prompts)

A typical problem-solving arc looks like this:

1. Sense and frame the problem
2. Decide the best approach
3. Plan enough to reduce risk
4. Execute with the right level of rigor
5. Validate outcomes
6. Document and hand off

The skills in this repo are concrete instantiations of those phases.

## Context Management (Why Skills Work)

Good AI work depends on maintaining the right context, not the most context.

Useful context layers:

- Environment: repo, branch, worktree, current changes
- Project: goals, architecture, constraints, conventions
- Task: scope, definition of done, acceptance criteria
- Evidence: code, tests, docs, logs, measurements

Rules of thumb:

- Anchor on existing sources first (code, docs, configs).
- Keep the task boundary explicit; avoid scope creep.
- Ask for missing facts early to prevent rework.
- Use short feedback loops to correct course.
- Prefer an explicit "definition of done" before deep work.

## How to Choose the Right Flow

Pick the smallest protocol that reduces uncertainty enough to proceed.

Signals to go fast:

- isolated change
- clear acceptance criteria
- low risk
- local tests or quick checks available

Signals to go deep:

- cross-module impact
- unclear system behavior
- high risk or compliance requirements
- integration or deployment needed

## Quality Gates (Definition of Done)

A reliable outcome usually includes:

- An artifact (code/doc/decision) that matches the objective
- Evidence of correctness (tests, checks, or validation)
- A clear summary of what changed and why
- Known limitations or follow-ups if any remain

## Reference Skill Taxonomy (as an Example)

These skills are examples of how the workflow is encoded:

- Discovery and framing: explore, clarify, define
- Decision and planning: solutions, plan
- Execution and validation: fast loop, e2e loop
- Support skills: grill-me, tdd, ubiquitous-language, handoff

The point is not the names. The point is that each phase has a bounded protocol with a clear output.

## Example Flows (Simple to Complex)

Use these as mental templates. The skills are shown in parentheses as concrete mappings.

1. Quick fix with low risk (fast loop)
   - Clarify the goal (clarify)
   - Inspect current behavior (fast)
   - Make smallest change (fast)
   - Run local tests (fast)
   - Summarize and close (fast)

2. Ambiguous bug report (frame first)
   - Ask targeted questions (clarify)
   - Define problem and success criteria (define)
   - If multiple approaches, compare tradeoffs (solutions + compare)
   - Choose a plan and validate steps (propose)
   - Execute and verify (fast or e2e)

3. New feature with integration risk (deep loop)
   - Explore current system behavior (explore)
   - Define scope, constraints, success (define)
   - Propose phased plan with tests and risks (propose)
   - Execute phase by phase with tests and deployment (e2e)
   - Validate end-to-end behavior (e2e)

4. Refactor with unknown coupling (investigate first)
   - Explore call flows (explore)
   - Identify risks and boundaries (define)
   - Compare approaches (solutions + compare)
   - Execute carefully with coverage (e2e)

5. Documentation improvement (reduce cognitive load)
   - Identify audience and goal (define)
   - Locate current docs (doc)
   - Update or write with clear structure (doc)
   - Validate for accuracy and actionability (doc)

6. Design decision with multiple stakeholders (decision loop)
   - Frame the decision and requirements (define)
   - Generate options with pros/cons (solutions)
   - Simulate usage scenarios (compare)
   - Document the decision (doc)

7. Onboarding into a new codebase (orientation)
   - Read README and entry points (explore)
   - Map main data flows (explore)
   - Confirm understanding (clarify)

8. Parallel tasks in a big epic (isolation)
   - Split work into tasks (define)
   - Give each task its own branch or worktree
   - Run the implement loop per task, scaled to its risk
   - Clean up branches when finished

9. "What next?" in a long-running effort (routing)
   - Summarize state and status (where)
   - Output a single next step (next)

10. Production incident or urgent fix (tight loop)
   - Clarify impact and constraints (clarify + define)
   - Execute minimal fix (fast)
   - Verify and document the outcome (doc)

11. Multi-phase migration with breaking changes (complex planning)
   - Explore current architecture and dependencies (explore)
   - Define scope, constraints, and risk boundaries (define)
   - Propose phased rollout with checkpoints (propose)
   - Execute phase-by-phase with tests and deploys (e2e)
   - Validate backward compatibility and performance (e2e)

12. Performance regression investigation (measurement loop)
   - Clarify the baseline and regression window (clarify)
   - Gather evidence and reproduce (explore)
   - Form hypotheses and compare fixes (solutions + compare)
   - Implement targeted fix and validate (fast or e2e)

13. Data pipeline failure (diagnose and restore)
   - Define failure symptoms and scope (define)
   - Inspect logs and dependencies (explore)
   - Identify likely root causes (solutions)
   - Execute fix and validate end-to-end (e2e)
   - Document root cause and prevention (doc)

14. Security or compliance change (high rigor)
   - Define requirements and constraints (define)
   - Propose plan with risks and mitigations (propose)
   - Implement with coverage and validation (e2e)
   - Document compliance evidence (doc)

## Communication Patterns That Keep Flow

- Start with the outcome, not the method.
- State constraints and risks up front.
- Use concrete artifacts (files, tests, logs) as anchors.
- Prefer small, reversible changes when uncertain.
- Ask for clarification only when blocked by missing facts.

## Key Takeaway

Skill-based workflows turn AI assistance into a reliable, outcome-focused system. The skills here are just one implementation of a general idea: solve problems with clear phases, bounded protocols, and disciplined context management.
