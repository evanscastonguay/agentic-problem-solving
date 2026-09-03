# Training: s3-define Skill

## Learning Objectives

By the end of this training, you will be able to:

1. **Write a one-sentence problem statement** that captures the core issue
2. **Quantify success criteria** with measurable outcomes
3. **Identify constraints** that bound the solution space
4. **Avoid common mistakes** like including solutions in problem statements
5. **Hand off effectively** to s4-solutions

## Prerequisites

- Completed [Getting Started](../getting-started.md) guide
- Understanding of basic workflow sequence
- A real or practice problem to define

**Time to complete**: 20-30 minutes

---

## Overview

`s3-define` is the foundational skill in the AI assistant's planning workflow. It transforms vague requests into clear, actionable problem statements that guide all subsequent decision-making.

## Purpose

- **Input**: Ambiguous problem descriptions or user requests
- **Output**: Structured problem definition with constraints and success criteria
- **Position**: First step after discovery (s1-explore, s2-clarify)

## When to Use

Use `s3-define` when you have:

- A new task or feature request
- An unclear problem statement
- Multiple stakeholders with different interpretations
- A complex decision requiring structured analysis

**Do NOT use** when the problem is already clearly defined.

## How It Works

### Step-by-Step Process

1. **State the problem in one sentence**
   - Capture the core issue concisely
   - Focus on what needs to be solved, not how

2. **Explain why it matters (impact)**
   - Business value or user benefit
   - Technical implications
   - Risk of not solving it

3. **List constraints and context**
   - Technical limitations
   - Time/budget constraints
   - Existing system constraints
   - Stakeholder requirements

4. **Define success criteria**
   - Measurable outcomes
   - Acceptance conditions
   - What "done" looks like

5. **List assumptions or unknowns**
   - What you assume to be true
   - What you don't know yet
   - Risks that could invalidate assumptions

## Examples

### Example 1: Feature Request

**User Request**: "Add dark mode to the app"

**s3-define Output**:

- **Problem**: Users need dark mode support to reduce eye strain and battery usage on mobile devices
- **Impact**: Improves user experience for night-time usage, aligns with modern UI standards, could increase user satisfaction by 20%
- **Constraints**: Must work on iOS/Android/Web, cannot increase bundle size by >5%, deadline in 2 sprints
- **Success Criteria**: Dark mode toggle works on all platforms, passes accessibility tests, no performance regression
- **Assumptions**: Dark mode designs exist in design system, backend doesn't need changes

### Example 2: Bug Report

**User Request**: "The login button doesn't work sometimes"

**s3-define Output**:

- **Problem**: Login functionality has intermittent failures causing user authentication issues
- **Impact**: Blocks user access to the application, could lead to user abandonment and support tickets
- **Constraints**: Affects production environment, logs available, cannot break existing user sessions
- **Success Criteria**: Login succeeds 100% of the time, error rate <0.1%, root cause identified and fixed
- **Assumptions**: Issue is reproducible, not network-related, affects all user types

### Example 3: Architecture Decision

**User Request**: "Should we migrate to microservices?"

**s3-define Output**:

- **Problem**: Current monolithic architecture is slowing development velocity and increasing deployment risk
- **Impact**: Could reduce time-to-market by 30%, improve fault isolation, enable team scaling
- **Constraints**: 6-month migration window, must maintain 99.9% uptime, team has microservices experience
- **Success Criteria**: Migration complete with zero downtime, performance >= current levels, team velocity increased
- **Assumptions**: Microservices will solve scaling issues, organizational buy-in exists

## Common Mistakes

### Mistake 1: Including Solutions

❌ **Bad**: "We need to add a cache layer to fix slow API responses"
✅ **Good**: "API response times exceed 2 seconds, impacting user experience"

### Mistake 2: Vague Success Criteria

❌ **Bad**: "Make it fast and reliable"
✅ **Good**: "API response time <500ms for 95% of requests, error rate <1%"

### Mistake 3: Missing Constraints

❌ **Bad**: Ignoring budget/time limitations
✅ **Good**: "Budget: $50K, Timeline: 3 months, Cannot break existing contracts"

### Mistake 4: Not Listing Assumptions

❌ **Bad**: Assuming everything is known
✅ **Good**: "Assuming third-party API remains stable, current team size stays constant"

## Integration with Other Skills

### Workflow Sequence

```
s1-explore → s2-clarify → s3-define → s4-solutions → s5-plan → s6-implement
```

### Handing Off to Next Skills

- **To s4-solutions**: Provides clear problem for generating options
- **To s5-plan**: Enables scope definition and planning
- **To s06/s07**: Guides implementation toward success criteria

### Context Preservation

The output serves as a reference document for the entire project lifecycle. Revisit it when:

- Scope creep occurs
- Requirements change
- Success validation happens

## Best Practices

### Keep It Concise

- Problem statement: 1 sentence
- Impact: 2-3 bullet points
- Constraints: 3-5 items
- Success criteria: 3-5 measurable outcomes
- Assumptions: 3-5 key items

### Use Quantifiable Metrics

- Instead of "fast", say "<500ms response time"
- Instead of "reliable", say "99.9% uptime"
- Instead of "user-friendly", say "NPS score >8/10"

### Validate with Stakeholders

- Share the definition before proceeding
- Get agreement on success criteria
- Document any disagreements for future reference

### Iterate as Needed

- If new information emerges, update the definition
- Don't treat it as immutable, but track changes

## Training Exercises

### Exercise 1

**Scenario**: "The website loads slowly on mobile"

Practice writing a complete s3-define output.

<details>
<summary>Click to reveal solution</summary>

**Problem**: Mobile users experience page load times exceeding 5 seconds, causing abandonment and poor user experience.

**Impact**:

- 40% mobile bounce rate (vs 15% desktop)
- Affects SEO ranking (Core Web Vitals)
- Lost conversions estimated at $10K/month

**Constraints**:

- Must support devices 3+ years old
- Cannot change backend architecture
- Budget: 2 developer-weeks
- No third-party performance tools approved yet

**Success Criteria**:

- Largest Contentful Paint < 2.5s on 4G
- First Input Delay < 100ms
- Mobile bounce rate < 25%

**Assumptions**:

- Issue is frontend, not API latency
- Current hosting can handle optimized assets
- Team has performance profiling experience

</details>

### Exercise 2

**Scenario**: "We need better analytics"

Identify what's missing from this vague request and how s3-define would clarify it.

<details>
<summary>Click to reveal solution</summary>

**What's missing**:

- What "better" means (more data? easier access? different metrics?)
- Who needs the analytics (product, marketing, engineering?)
- What decisions the analytics should inform
- Current pain points with existing analytics

**s3-define output**:

**Problem**: Product team cannot track user journey through onboarding, preventing data-driven optimization of conversion funnel.

**Impact**:

- No visibility into where users drop off
- Cannot measure feature adoption
- Product decisions based on intuition, not data

**Constraints**:

- GDPR compliance required
- Must integrate with existing data warehouse
- Cannot impact page performance (< 50ms tracking overhead)

**Success Criteria**:

- Track 100% of onboarding funnel events
- Dashboard shows conversion rates by step
- Product team can self-serve queries

**Assumptions**:

- Legal has approved proposed tracking
- Data warehouse has capacity for new events

</details>

### Exercise 3

**Scenario**: "Migrate to React 18"

Write success criteria and constraints for this technical migration.

<details>
<summary>Click to reveal solution</summary>

**Problem**: Application runs on React 16, missing performance improvements and modern features available in React 18.

**Impact**:

- Cannot use Concurrent Features for better UX
- Falling behind ecosystem (libraries dropping React 16 support)
- Developer experience degraded

**Constraints**:

- Must maintain feature parity (no regressions)
- Timeline: complete before Q3 feature work
- Cannot break existing test suite
- Class components must still work (gradual migration)

**Success Criteria**:

- All existing tests pass on React 18
- No Strict Mode warnings in console
- Bundle size within 5% of current
- Lighthouse performance score maintained or improved
- All pages render correctly (visual regression tests pass)

**Assumptions**:

- Third-party libraries are React 18 compatible
- No breaking changes in React Router version bump
- Team has capacity for migration work

</details>

---

## Self-Check: Validate Your Understanding

Answer these questions to confirm mastery:

| Question                                | Check Your Answer                               |
| --------------------------------------- | ----------------------------------------------- |
| 1. What makes a good problem statement? | One sentence, no solutions, captures core issue |
| 2. What's wrong with "Make it faster"?  | Not measurable - use specific metrics           |
| 3. When should you list assumptions?    | Always - they reveal risks and unknowns         |
| 4. What comes after s3-define?         | s4-solutions (generate options)                |
| 5. Can you update a definition later?   | Yes - iterate as you learn more                 |

**Scoring**:

- 5/5: Ready to use s3-define in real work
- 3-4/5: Review the sections you missed
- <3/5: Re-read the guide and try exercises again

---

## Troubleshooting

### "My problem statement keeps including solutions"

**Symptom**: "We need to add caching to speed up the API"

**Fix**: Ask "Why do we need caching?" The answer reveals the real problem: "API is slow" → "Users experience delays" → Problem: "API response times exceed user tolerance thresholds"

**Technique**: Remove all technical nouns (cache, database, server) and describe the user impact.

### "I can't quantify success criteria"

**Symptom**: "Make it reliable" or "Improve performance"

**Fix**: Ask:

- "How would we know if we succeeded?"
- "What number would prove we're done?"
- "What's the current baseline?"

**Examples**:

- "Reliable" → "99.9% uptime, <1 unplanned outage per quarter"
- "Fast" → "<200ms p95 response time"
- "User-friendly" → "Task completion rate >90%, NPS >8"

### "I don't know the constraints"

**Symptom**: Blank constraints section

**Checklist** - ask about each:

- [ ] Timeline / deadline?
- [ ] Budget / resources?
- [ ] Technical limitations?
- [ ] Compliance / legal requirements?
- [ ] Dependencies on other teams?
- [ ] What can NOT change?

### "Stakeholders disagree on the problem"

**Symptom**: Different people describe different problems

**Fix**:

1. Document each interpretation separately
2. Identify the common thread (often there is one)
3. If no agreement, escalate for prioritization
4. Record disagreement as an assumption/risk

---

## Key Takeaways

1. **s3-define is about clarity, not solutions** - It sets up the problem for others to solve
2. **Quality matters** - A poor definition leads to poor solutions
3. **It's iterative** - Refine as you learn more
4. **It's collaborative** - Involve stakeholders in validation
5. **It's foundational** - Everything else builds on this clarity

## Related Skills

- **s2-clarify**: If the problem is too vague to define
- **s4-solutions**: Uses this definition to generate options
- **s5-plan**: Uses this to scope implementation
- **handoff**: Carry this definition into a fresh session without losing it
