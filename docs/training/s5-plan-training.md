# Training: s5-plan Skill

## Learning Objectives

By the end of this training, you will be able to:

1. **Read code before planning** to understand current system
2. **Define clear scope** with explicit "out of scope"
3. **Create testable phases** that prove progress incrementally
4. **Identify risks** with specific mitigations
5. **Write executable first actions** that unblock work immediately

## Prerequisites

- Completed [s4-solutions training](s4-solutions-training.md)
- A recommended solution to plan
- Access to the codebase you'll modify

**Time to complete**: 30-40 minutes

---

## Overview

`s5-plan` is the implementation planning skill. It transforms a recommended solution into a concrete, actionable plan with phases, risks, tests, and checkpoints—written to a markdown file for reference throughout execution.

## Purpose

- **Input**: Recommended solution (from s4-solutions)
- **Output**: Written implementation plan (md file)
- **Position**: Bridge between planning and implementation

## When to Use

Use `s5-plan` when you have:

- A chosen solution ready for implementation
- A non-trivial task requiring multiple steps
- Work that needs documented plan for reference
- Multi-phase implementation with checkpoints

**Do NOT use** when:

- Task is trivial (use s6-implement directly)
- Solution isn't chosen yet (use s4-solutions first)
- Just exploring options (use s3-define or s4-solutions)

## How It Works

### Step-by-Step Process

1. **Read the code first**
   - Understand current system before planning changes
   - Identify integration points
   - Note existing patterns to follow

2. **Define scope and deliverables**
   - What will be built/changed
   - What is explicitly out of scope
   - Clear definition of "done"

3. **Lay out phased, testable steps**
   - Break work into logical phases
   - Each phase should be independently testable
   - Order phases by dependency and risk

4. **Identify risks and mitigations**
   - What could go wrong
   - How to prevent or handle failures
   - Rollback strategies

5. **Specify tests and validation**
   - Unit tests for new code
   - Integration tests for connections
   - End-to-end validation criteria

6. **Add checkpoints if useful**
   - Decision points to evaluate progress
   - Review gates before major changes
   - Points to get stakeholder sign-off

7. **State the first concrete action**
   - Specific, actionable next step
   - Removes ambiguity about where to start
   - Can be executed immediately

8. **Write to md file**
   - Persistent reference for the work
   - Ask for path if not provided
   - Standard location: `proposals/` directory

## Examples

### Example 1: API Feature Implementation

**Context**: Add rate limiting to REST API

**Proposal Output**:

```markdown
# Proposal: API Rate Limiting

## Scope

- Implement token bucket rate limiting on all public endpoints
- Add rate limit headers to responses
- Create admin endpoint to adjust limits

**Out of scope**: Per-user custom limits, UI for management

## Deliverables

- Rate limiting middleware
- Redis integration for distributed counting
- Rate limit configuration system
- Monitoring dashboard updates

## Phases

### Phase 1: Infrastructure (2 days)

- Add Redis connection pool
- Create rate limit configuration schema
- Unit tests for config loading

**Testable**: Config loads correctly, Redis connects

### Phase 2: Middleware (3 days)

- Implement token bucket algorithm
- Add middleware to Express pipeline
- Return proper 429 responses with headers

**Testable**: Rate limits enforced, headers correct

### Phase 3: Admin API (1 day)

- Add endpoints to view/update limits
- Secure with admin authentication

**Testable**: Admin can adjust limits via API

### Phase 4: Monitoring (1 day)

- Add rate limit metrics to Prometheus
- Create Grafana dashboard

**Testable**: Metrics visible in dashboard

## Risks and Mitigations

| Risk                              | Mitigation                             |
| --------------------------------- | -------------------------------------- |
| Redis failure blocks all requests | Fail-open mode with local fallback     |
| Limits too aggressive             | Start conservative, monitor and adjust |
| Performance impact                | Benchmark before/after, cache lookups  |

## Tests and Validation

- Unit: Token bucket algorithm, config parsing
- Integration: Redis communication, middleware chain
- E2E: Hit rate limit, verify 429, check headers
- Load: Verify performance under load

## Checkpoints

- After Phase 1: Review Redis setup with infra team
- After Phase 2: Load test before proceeding
- After Phase 4: Stakeholder sign-off on dashboard

## First Action

Create `src/middleware/rate-limit.ts` with token bucket class skeleton and unit test file.
```

### Example 2: Database Migration

**Context**: Migrate from PostgreSQL to Aurora

**Proposal Output**:

```markdown
# Proposal: PostgreSQL to Aurora Migration

## Scope

- Migrate production database to Aurora PostgreSQL
- Zero-downtime migration using logical replication
- Update connection strings across services

**Out of scope**: Schema changes, application code changes

## Deliverables

- Aurora cluster provisioned
- Data synchronized via logical replication
- All services pointing to Aurora
- Rollback procedure documented

## Phases

### Phase 1: Setup (1 week)

- Provision Aurora cluster in same VPC
- Configure security groups and IAM
- Set up logical replication from source

**Testable**: Replication lag < 1 second

### Phase 2: Validation (3 days)

- Run read queries against Aurora
- Compare results with source
- Load test Aurora cluster

**Testable**: Query results match, performance acceptable

### Phase 3: Cutover (1 day)

- Stop writes to source
- Wait for replication to catch up
- Switch connection strings
- Resume writes to Aurora

**Testable**: All services connected to Aurora, no errors

### Phase 4: Cleanup (2 days)

- Monitor for issues
- Decommission old cluster
- Update documentation

**Testable**: Old cluster offline, no references remain

## Risks and Mitigations

| Risk                     | Mitigation                                    |
| ------------------------ | --------------------------------------------- |
| Data loss during cutover | Write-ahead logging, verify row counts        |
| Replication falls behind | Monitor lag, pause non-critical writes        |
| Performance differs      | Load test before cutover, have rollback ready |
| Connection string missed | Audit all services, use config discovery      |

## Tests and Validation

- Replication: Verify row counts match hourly
- Performance: Run production-like load test
- Connectivity: Test from every service
- Rollback: Practice rollback in staging

## Checkpoints

- After Phase 1: Confirm replication stable for 48 hours
- Before Phase 3: Sign-off from engineering lead
- After Phase 3: 4-hour monitoring window before cleanup

## First Action

Create Aurora cluster via Terraform in `infra/aurora-migration` directory.
```

### Example 3: Frontend Feature

**Context**: Implement dark mode toggle

**Proposal Output**:

```markdown
# Proposal: Dark Mode Implementation

## Scope

- Add dark mode toggle to settings
- Create dark color palette
- Persist user preference
- Respect system preference as default

**Out of scope**: Per-component custom themes, scheduled switching

## Deliverables

- Dark mode CSS variables
- ThemeProvider context
- Settings UI toggle
- Preference persistence (localStorage + account)

## Phases

### Phase 1: Foundation (1 day)

- Define CSS variables for colors
- Create light and dark value sets
- Add ThemeProvider to app root

**Testable**: Theme switches via dev tools

### Phase 2: Toggle UI (1 day)

- Add toggle to settings page
- Wire to ThemeProvider
- Persist to localStorage

**Testable**: Toggle works, persists on refresh

### Phase 3: System Integration (0.5 days)

- Detect `prefers-color-scheme`
- Use as default if no user preference
- Listen for system changes

**Testable**: Follows system preference correctly

### Phase 4: Account Sync (0.5 days)

- Store preference in user profile API
- Sync on login
- Handle conflicts (account wins)

**Testable**: Preference syncs across devices

## Risks and Mitigations

| Risk                         | Mitigation                               |
| ---------------------------- | ---------------------------------------- |
| Flash of wrong theme on load | Inline script to set theme before render |
| Missed components            | Visual regression testing                |
| Accessibility issues         | Test contrast ratios in both themes      |

## Tests and Validation

- Unit: ThemeProvider logic, preference detection
- Visual: Screenshot comparison for all pages
- Accessibility: WCAG contrast check
- E2E: Toggle, refresh, verify persistence

## Checkpoints

- After Phase 1: Design review of dark palette
- After Phase 2: QA pass on core flows
- After Phase 4: Accessibility audit

## First Action

Create `src/theme/variables.css` with CSS custom properties for color system.
```

## Common Mistakes

### Mistake 1: Skipping Code Review

❌ **Bad**: Planning without understanding current system
✅ **Good**: "Read existing auth module to understand patterns"

### Mistake 2: Phases Too Large

❌ **Bad**: "Phase 1: Build the feature"
✅ **Good**: Break into testable increments of 1-3 days

### Mistake 3: Vague First Action

❌ **Bad**: "Start implementing"
✅ **Good**: "Create `src/rate-limit/bucket.ts` with TokenBucket class"

### Mistake 4: Missing Risks

❌ **Bad**: "No risks identified"
✅ **Good**: Every plan has risks—identify at least 3

### Mistake 5: Not Writing to File

❌ **Bad**: Only outputting to chat
✅ **Good**: Always write to md file for reference

### Mistake 6: No Testability Per Phase

❌ **Bad**: "Phase 1: Set up infrastructure"
✅ **Good**: "Phase 1: Set up Redis. **Testable**: Connection succeeds, keys can be set/get"

## Integration with Other Skills

### Workflow Sequence

```
s3-define → s4-solutions → s5-plan → s6-implement
```

### Inputs From s4-solutions

- Recommended solution
- Known trade-offs
- Core problem understanding

### Outputs To Implementation

- Phased work breakdown
- Test criteria per phase
- Risk awareness
- Clear first action

### Scaling the Implementation Loop

`s6-implement` is one loop (change → test → self-review → PR); scale it to the risk:

| Situation                    | How to run s6-implement                          |
| ---------------------------- | ------------------------------------------------ |
| Small task, quick feedback   | One pass, local tests only                       |
| Multi-phase, full validation | One pass per plan phase, integration tests each  |
| New behavior                 | Pair it with `tdd` for a test-first loop         |

## Best Practices

### Read Before Planning

- Understand existing code structure
- Identify patterns to follow
- Note integration points

### Make Phases Testable

- Each phase should prove something works
- "Testable" criteria are not optional
- Enable early feedback loops

### Be Specific About Scope

- Explicit "out of scope" prevents creep
- Deliverables are concrete artifacts
- "Done" is unambiguous

### Risks Are Always Present

- Every project has risks
- Name them explicitly
- Provide mitigations, not just identification

### First Action Unblocks Work

- Should be executable immediately
- Specific file/function to create
- No more decisions needed to start

### Always Write to File

- Plans are reference documents
- Enable resumption after breaks
- Support handoff to other developers

## Training Exercises

### Exercise 1

**Task**: "Add email notifications when orders ship"

Create a proposal with 3-4 phases, each with testable criteria.

<details>
<summary>Click to reveal solution</summary>

**Phase 1: Email Service Setup (1 day)**

- Integrate SendGrid SDK
- Create email template for shipping notification
- **Testable**: Send test email to dev inbox, verify delivery and formatting

**Phase 2: Event Trigger (1 day)**

- Add "order_shipped" event to order state machine
- Wire event to email service
- **Testable**: Ship test order, verify event fires, email queued

**Phase 3: Template & Content (0.5 days)**

- Add tracking number and carrier to email
- Include order summary
- **Testable**: Email contains correct order data, links work

**Phase 4: Error Handling (0.5 days)**

- Add retry logic for failed sends
- Create alert for repeated failures
- **Testable**: Force failure, verify retry, alert fires after 3 attempts

</details>

### Exercise 2

**Task**: "Migrate from REST to GraphQL"

Identify at least 5 risks with specific mitigations.

<details>
<summary>Click to reveal solution</summary>

| Risk                                   | Mitigation                                                        |
| -------------------------------------- | ----------------------------------------------------------------- |
| **1. Breaking existing clients**       | Run GraphQL in parallel with REST; deprecate REST gradually       |
| **2. N+1 query performance**           | Implement DataLoader pattern from day 1; monitor query complexity |
| **3. Over-fetching of sensitive data** | Field-level authorization; query depth limiting                   |
| **4. Team unfamiliar with GraphQL**    | Training session before kickoff; pair programming first week      |
| **5. Schema design mistakes**          | Start with single entity; get feedback before expanding           |
| **6. Caching complexity**              | Use Apollo Client with normalized cache; document cache policies  |
| **7. Error handling differences**      | Create error code mapping; standardize error response format      |

</details>

### Exercise 3

**Task**: "Implement search functionality"

Write a first action that is immediately executable.

<details>
<summary>Click to reveal solution</summary>

**Bad first actions** (too vague):

- "Start working on search"
- "Set up Elasticsearch"
- "Research search options"

**Good first action**:

> Create `src/search/SearchService.ts` with:
>
> - `SearchService` class skeleton
> - `search(query: string): Promise<SearchResult[]>` method stub returning empty array
> - Unit test file `SearchService.test.ts` with test: "returns empty array for empty query"
> - Run tests to verify setup works

**Why it's good**:

- Specific file path
- Defined interface
- Includes test
- Immediately executable
- Proves build/test pipeline works

</details>

---

## Self-Check: Validate Your Understanding

| Question                                     | Check Your Answer                          |
| -------------------------------------------- | ------------------------------------------ |
| 1. What do you do BEFORE writing a proposal? | Read the existing code                     |
| 2. What makes a phase "testable"?            | Clear criteria to prove it works           |
| 3. What should scope include?                | Deliverables AND explicit "out of scope"   |
| 4. How specific should first action be?      | File path + what to create + how to verify |
| 5. Where does the proposal go?               | Written to an md file (ask for path)       |

**Scoring**:

- 5/5: Ready to create proposals in real work
- 3-4/5: Review the sections you missed
- <3/5: Re-read examples and try exercises again

---

## Troubleshooting

### "My phases are too big"

**Symptom**: "Phase 1: Build the feature" (days or weeks of work)

**Fix**: Apply the **1-3 day rule**:

- No phase should take more than 3 days
- If longer, break into sub-phases
- Each phase should have a demo-able outcome

**Technique**: Ask "What could I show someone after this phase?"

### "I can't identify risks"

**Symptom**: "No risks identified" or only obvious risks

**Checklist** - ask about each:

- [ ] What if a dependency isn't ready?
- [ ] What if performance is worse than expected?
- [ ] What if the API/library doesn't work as documented?
- [ ] What if we need to rollback?
- [ ] What if a team member is unavailable?
- [ ] What if requirements change mid-implementation?

### "My first action is too vague"

**Symptom**: "Set up the project" or "Start implementing"

**Template**:

```
Create [file path] with:
- [Specific class/function]
- [Initial behavior]
- [Test to verify]
Run [command] to confirm it works.
```

### "The plan doesn't survive contact with code"

**Symptom**: Plan becomes obsolete after phase 1

**Fix**:

1. Plans are living documents - update them
2. Re-read the plan file at the start of every session to check progress
3. Re-scope if discoveries change the approach
4. Note: Some deviation is normal; total replanning suggests skipped code reading

### "Stakeholders keep adding scope"

**Symptom**: Scope creep during implementation

**Fix**:

1. Point to "Out of scope" in proposal
2. Create separate proposal for new items
3. Discuss priority trade-offs explicitly
4. Document scope changes with rationale

---

## Key Takeaways

1. **Read code first** - Understand before planning
2. **Phases must be testable** - Each proves something works
3. **Scope is explicit** - Include what's out of scope
4. **Risks are named** - With specific mitigations
5. **First action is specific** - Immediately executable
6. **Always write to file** - Plans persist beyond the conversation

## Related Skills

- **s4-solutions**: Provides the recommended solution
- **s6-implement**: Executes the plan phase by phase
- **tdd**: Test-first loop for phases that add behavior
- **handoff**: Hands the plan and its progress to a fresh session
