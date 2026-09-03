# Training: s4-solutions Skill

Practice for step 4. Read `skills/s4-solutions/SKILL.md` first (12 lines), then work through the examples and exercises here. Time: 20 to 30 minutes.


## Examples

### Example 1: Performance Problem

**Problem**: API response times exceed 2 seconds

**First Principles**: Users need fast feedback. Data must travel from database to user. Bottleneck is somewhere in this path.

**Solutions**:

| Solution                          | Description                             |
| --------------------------------- | --------------------------------------- |
| A: Add caching layer              | Cache frequently accessed data in Redis |
| B: Optimize database queries      | Rewrite N+1 queries, add indexes        |
| C: Implement CDN + edge computing | Move computation closer to users        |

**Solution A: Add caching layer**
| Pros | Cons |
|------|------|
| Fast implementation (1-2 days) | Cache invalidation complexity |
| Reduces database load by 80% | Requires Redis infrastructure |
| Proven pattern, low risk | Stale data possible |

**Solution B: Optimize database queries**
| Pros | Cons |
|------|------|
| Addresses root cause | Takes longer to implement (1-2 weeks) |
| No new infrastructure needed | May not be enough alone |
| Improves all operations | Requires database expertise |

**Solution C: CDN + edge computing**
| Pros | Cons |
|------|------|
| Best long-term scalability | Most complex to implement |
| Lowest latency for global users | Highest cost |
| Modern architecture | Over-engineering for current scale |

**Recommendation**: Solution B (Optimize database queries)

_Rationale_: First principles show the core issue is inefficient data retrieval. Caching masks the problem; edge computing is premature. Fixing queries addresses root cause with existing infrastructure.

### Example 2: Team Velocity Problem

**Problem**: Development velocity decreased 30% over 6 months

**First Principles**: Velocity = work completed / time. Either work is harder, or time is less productive. Core need: ship value to users efficiently.

**Solutions**:

| Solution                   | Description                                    |
| -------------------------- | ---------------------------------------------- |
| A: Reduce meeting overhead | Cut 50% of meetings, async by default          |
| B: Pay down technical debt | Dedicate 20% sprint to refactoring             |
| C: Restructure teams       | Smaller, autonomous teams with clear ownership |

**Solution A: Reduce meeting overhead**
| Pros | Cons |
|------|------|
| Immediate time recovery | May reduce coordination quality |
| Easy to implement | Cultural resistance possible |
| Measurable outcome | Doesn't address code complexity |

**Solution B: Pay down technical debt**
| Pros | Cons |
|------|------|
| Addresses velocity root cause | Short-term velocity decrease |
| Improves developer experience | Hard to prioritize what to fix |
| Compounds over time | May not show results for months |

**Solution C: Restructure teams**
| Pros | Cons |
|------|------|
| Reduces coordination overhead | Disruptive to current work |
| Clear ownership increases accountability | Takes 3-6 months to stabilize |
| Modern org design | Requires management buy-in |

**Recommendation**: Solution B (Pay down technical debt)

_Rationale_: First principles reveal that complexity slows work. Meetings are a symptom, not cause. Technical debt compounds - investing now yields returns over time.

### Example 3: Security Requirement

**Problem**: Need to implement authentication for new API

**First Principles**: Authentication = verifying identity. Need to know who is making requests. Must balance security with usability.

**Solutions**:

| Solution               | Description                        |
| ---------------------- | ---------------------------------- |
| A: API key-based auth  | Simple static tokens per client    |
| B: OAuth 2.0 + JWT     | Industry-standard token-based auth |
| C: Custom token system | Build proprietary auth mechanism   |

**Solution A: API key-based auth**
| Pros | Cons |
|------|------|
| Simplest to implement | No token expiration by default |
| Easy client integration | No user-level permissions |
| Low maintenance overhead | Limited security features |

**Solution B: OAuth 2.0 + JWT**
| Pros | Cons |
|------|------|
| Industry standard, well documented | More complex implementation |
| Token expiration and refresh built-in | Requires understanding OAuth flows |
| Supports future extensibility | Heavier infrastructure (auth server) |

**Solution C: Custom token system**
| Pros | Cons |
|------|------|
| Fully tailored to needs | Reinventing the wheel |
| No external dependencies | Security risks from DIY approach |
| Complete control | Maintenance burden long-term |

**Recommendation**: Solution B (OAuth 2.0 + JWT)

_Rationale_: First principles show we need secure, extensible identity verification. API keys are too simple for user-level auth. Custom solutions introduce security risk. OAuth is battle-tested and supports growth.

## Common Mistakes

### Mistake 1: Not Enough Diversity in Solutions

❌ **Bad**: Three variations of the same approach
✅ **Good**: Conservative, moderate, and innovative options

### Mistake 2: Vague Pros/Cons

❌ **Bad**: "It's faster" / "It's harder"
✅ **Good**: "Reduces response time by 50%" / "Requires 2 weeks of refactoring"

### Mistake 3: Skipping First Principles

❌ **Bad**: Jumping to solutions without understanding core problem
✅ **Good**: "The core need is X, therefore solutions should address X"

### Mistake 4: Recommending Without Justification

❌ **Bad**: "Go with option B"
✅ **Good**: "Option B addresses root cause with least complexity because..."

### Mistake 5: Ignoring Simplicity

❌ **Bad**: Recommending the most comprehensive solution
✅ **Good**: Recommending the simplest solution that solves the core problem

## Training Exercises

### Exercise 1

**Problem**: "We need to reduce AWS costs by 30%"

Generate 3 solutions with pros/cons and recommend one using first principles.

<details>
<summary>Click to reveal solution</summary>

**First Principles**: We pay for compute, storage, and transfer. Cost = usage × rate. Reduce either usage or rate.

**Solution A: Right-size instances**
| Pros | Cons |
|------|------|
| Quick wins (1-2 weeks) | Limited savings ceiling (~15%) |
| No architecture changes | Requires usage analysis |
| Low risk, reversible | May need to upsize later |

**Solution B: Reserved instances + Savings Plans**
| Pros | Cons |
|------|------|
| 30-60% discount on committed usage | Upfront payment required |
| Predictable costs | Locked in for 1-3 years |
| No technical changes | Doesn't address waste |

**Solution C: Serverless migration**
| Pros | Cons |
|------|------|
| Pay only for actual usage | Significant refactoring |
| Auto-scaling built-in | Cold start latency |
| Long-term cost optimization | Learning curve for team |

**Recommendation**: Solution A + B combined

_Rationale_: First principles show we're likely over-provisioned AND paying on-demand rates. Right-size first to understand true needs, then commit to savings plans. Serverless is overkill for 30% target.

</details>

### Exercise 2

**Problem**: "Team communication is poor across time zones"

Apply first principles to identify core need, then generate solutions.

<details>
<summary>Click to reveal solution</summary>

**First Principles**: Communication serves coordination. Coordination requires shared context. Time zones limit synchronous overlap. Core need: maintain shared context without requiring simultaneous presence.

**Solution A: Async-first culture**
| Pros | Cons |
|------|------|
| Works for all time zones | Slower decision-making |
| Better documentation | Requires discipline |
| Respects work-life balance | Less spontaneous collaboration |

**Solution B: Overlap hours policy**
| Pros | Cons |
|------|------|
| Guaranteed sync time | Someone always compromises |
| Enables real-time decisions | May cause burnout |
| Clear expectations | Limited flexibility |

**Solution C: Regional pods with liaisons**
| Pros | Cons |
|------|------|
| Teams work normal hours | Coordination overhead |
| Clear ownership | Potential silos |
| Scalable model | Requires reorg |

**Recommendation**: Solution A (Async-first culture)

_Rationale_: First principles reveal the core issue is context-sharing, not talking more. Async-first addresses this sustainably without forcing schedule compromises.

</details>

### Exercise 3

**Problem**: "Database is running out of storage"

Avoid symptom treatment - find root cause and propose solutions.

<details>
<summary>Click to reveal solution</summary>

**First Principles**: Storage = data accumulated over time. Data grows from: new records, logs, or bloat. Question: Do we need all this data accessible? Core need: maintain performance and availability.

**Solution A: Add more storage**
| Pros | Cons |
|------|------|
| Immediate fix | Treats symptom, not cause |
| No data changes | Recurring cost increase |
| Low risk | Delays inevitable reckoning |

**Solution B: Archive old data**
| Pros | Cons |
|------|------|
| Addresses root cause | Requires retention policy |
| Reduces operational data size | May need archive access system |
| Improves query performance | One-time migration effort |

**Solution C: Data lifecycle automation**
| Pros | Cons |
|------|------|
| Permanent solution | Most complex to implement |
| Prevents future crises | Requires governance decisions |
| Industry best practice | Takes 2-4 weeks to set up |

**Recommendation**: Solution B now, Solution C next quarter

_Rationale_: First principles show we're storing data we don't need hot. Archive immediately for relief, then implement automation to prevent recurrence.

</details>

---

## Self-Check: Validate Your Understanding

| Question                                   | Check Your Answer                                |
| ------------------------------------------ | ------------------------------------------------ |
| 1. What are first principles?              | Fundamental truths after removing assumptions    |
| 2. How many solutions should you generate? | 3 (conservative, moderate, innovative)           |
| 3. What makes a bad pro/con?               | Vague statements like "it's better"              |
| 4. When should you score options in a matrix? | Complex decisions with many criteria or proposals |
| 5. Should you hedge your recommendation?   | No - recommend decisively, acknowledge tradeoffs |

**Scoring**:

- 5/5: Ready to generate solutions in real work
- 3-4/5: Review the sections you missed
- <3/5: Re-read first principles section

---

## Troubleshooting

### "My solutions are too similar"

**Symptom**: All three options are variations of the same approach

**Fix**: Force diversity by asking:

- What's the **cheapest** way to solve this?
- What's the **fastest** way?
- What's the **most thorough** way?
- What would a **different team** do?
- What if we had **no constraints**?

### "I can't apply first principles"

**Symptom**: Jumping straight to solutions

**Technique**: Ask "Why?" five times:

1. Why is the database slow? → Too many queries
2. Why too many queries? → N+1 problem in ORM
3. Why N+1? → Lazy loading without optimization
4. Why not optimized? → No performance review process
5. Why no process? → Team unaware of impact

**Core truth**: Team needs performance awareness, not just a fix.

### "My pros/cons are vague"

**Symptom**: "Faster", "Cheaper", "Better"

**Fix template**: `[Metric] [direction] by [amount] [timeframe]`

- "Faster" → "Response time reduced by 40% within 1 week"
- "Cheaper" → "Monthly cost decreased by $2K after migration"
- "Better" → "Error rate drops from 5% to <1%"

### "I can't decide on a recommendation"

**Symptom**: "It depends" or no clear winner

**Decision framework**:

1. Which addresses the **root cause**?
2. Which is **simplest** while still effective?
3. Which is **reversible** if wrong?
4. Which fits **constraints** from s3-define?

If still tied, recommend the simpler option.

---
