# The Map: AI-Assisted Development (45-minute talk)

## Slide 1: Title - The Map
I want to start with a simple image: a map. Every team has goals, but most of us
move across the map without a shared path. Today I want to give you a map for
AI-assisted development. Not a new tool. A way of moving from chat-level help
to outcome-level delegation.

If you remember learning any strategy game, you probably did the same thing I
did: wander, click around, and hope. You had tools, but no direction. The map
felt big. This talk is about moving with intent.

Visual: a blank map with a single destination marker. No labels, no clutter.

## Slide 2: The Problem We Have Today
Most engineers still use AI like a search bar or autocomplete. Ask for a
snippet. Fix this line. Summarize that file. It is useful, but it keeps us at
the step level, not the objective level.

That creates a mismatch. We have powerful agents, but we are using them like
type-ahead. So the big question is: how do we move from "help me type" to "help
me achieve"?

Visual: same map, but the marker is not connected by any path.

## Slide 3: The Shift That Matters
The shift is delegation. Instead of asking for a small output, we give the agent
a goal, context, constraints, and a definition of done. The agent becomes a
teammate, not a chat box.

Before: "Write me a function to parse this file."
After: "Take this folder, find the bug, propose a fix, and tell me how to
verify it."

That is outcome-level delegation. That is the shift.

Visual: a path appears from the marker toward the destination.

## Slide 4: The Map Legend (One Idea, One Visual)
Here is the legend. Every mission has:
- A destination (goal)
- Fog (unknowns)
- Resources (tools)
- Routes (options)
- Checkpoints (validation)
- Save points (rollback)

We are going to walk this map once, slowly, with a real example. That is how
you will remember it.

Visual: a simple legend panel, six icons max.

## Slide 5: The Quest (Define the Win)
Our example quest: ship a customer-facing feature before a Friday demo.

This is where we use s3-define. We state the objective in one sentence. We set
constraints. We decide how we will know we succeeded.

If we do not define the win, we do not have a map. We just have movement.

Visual: destination labeled "Friday demo shipped."

## Slide 6: Clear the Fog (Explore and Clarify)
Good players do not sprint into the fog. They scout. They read the terrain.
That is s1-explore and s2-clarify.

We read the code, identify dependencies, and confirm the request. We separate
what we know from what we do not. This is how we avoid wrong turns and avoid
hallucinated context.

Visual: fog overlay with one area revealed.

## Slide 7: Resources and Access (Context)
Now we identify resources. What tools do we have? What systems can we touch?
What credentials exist? Make that explicit up front; an agent that has to guess
its environment will guess wrong.

The point is not the brand. Claude, Codex, Gemini CLI. The point is knowing the
capabilities and access you actually have. That is the difference between a
good plan and a plan that fails at runtime.

Visual: a small tool belt icon and a "keys" icon.

## Slide 8: Routes and Tradeoffs (Solutions)
There are always multiple routes. Fast, safe, risky. That is s4-solutions: three
genuinely different options, honest pros and cons, one decisive recommendation.

For our quest, we could:
1) Apply a quick patch to meet the demo.
2) Refactor the flow for long-term safety.
3) Stage a rollout to reduce risk.

We weigh them against the success criteria from s3-define and decide what we
value. This step keeps us honest, and it is the step most teams skip.

Visual: three routes with small labels: fast, safe, risky.

## Slide 9: The Plan
Now we commit to a route. This is s5-plan. We break the mission into phases.
We name the risks. We define tests and checkpoints.

Planning is not bureaucracy. It is the route line on the map. Without it, we
cannot coordinate the team or the agent.

Visual: route line with two checkpoints.

## Slide 10: Execution Loops (Fast vs E2E)
Execution depends on risk.
- s6-implement is the change-test-review loop.
- For small, safe changes it is a short sprint; for higher risk it is a full
  expedition with integration checks.

Both are valid. The difference is the terrain. If the map is flat, sprint. If
the map is mountain, prepare.

Visual: split path icons: sprint vs expedition.

## Slide 11: Save Points (Plan File, Branch, Handoff)
In any game, you save before a risky fight. Here the save slot is the plan file
from s5-plan plus a git branch: you can reload either one while you explore, and
handoff carries the state into a fresh session.

When the mission ends, the plan file records what was done and why. The next
person, or the next session, starts from there instead of from zero.

Visual: a save flag next to a small document icon.

## Slide 12: Re-Orient (The Plan File)
Even good plans drift. So we re-orient, and the plan file is how.
- Re-read it: it says where we are and what is left.
- Update it: decisions and outcomes go in as they happen, so it stays the log.
- Its "first action" line is the next waypoint, so we never stall on "what now?"

This is how a team stays aligned when the mission gets messy.

Visual: "You are here" marker and a small notebook icon.

## Slide 13: Levels of Abstraction
Here is the most important idea for engineers: problem solving has layers.

- Objective: the destination
- Task: a deliverable that moves us toward it
- Phase: a chunk with its own validation
- Step: the smallest action

Agents can help at any level, but only if we make the level explicit. This is
why we must move from chat-level to objective-level thinking.

Visual: the map with four labels stacked vertically.

## Slide 14: The Gift and the Guardrails
The gift is not just code. It is a reliable outcome delivered faster with fewer
surprises.

But we are honest about limits. Agents can be wrong. They can miss edge cases.
We verify the work. We treat the map as a guide, not a guarantee.

That is the systematic approach: define the win, clear the fog, choose the
route, plan the checkpoints, execute with the right loop, and re-orient as you
go.

Visual: destination reached, map complete.

## Slide 15: Call to Action
If you only remember one thing, remember this: stop asking for steps and start
delegating outcomes. Use the map.

Start small this week:
1) Pick a real objective.
2) Clear the fog with exploration.
3) Compare routes.
4) Plan checkpoints.
5) Delegate the outcome to your agent teammate.

That is how AI-assisted development becomes a real advantage, not just a clever
tool.
