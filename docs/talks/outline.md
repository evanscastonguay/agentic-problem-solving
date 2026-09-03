# AI-Assisted Development Presentation Outline

## One-Sentence Gift
AI-assisted development helps teams move from chat-level help to outcome-level
delegation by navigating a simple map: pick a goal, clear unknowns, choose a
route, and reach the result with agent teammates.

## Principles (Low Cognitive Load + TED Style)
- One idea per slide; keep a single map visual and add only one new element per
  slide.
- Start with why (curiosity gap), then how (the map process), then what
  (the tools and skills).
- Explain through flow (input -> transformation -> output), not static
  architecture.
- Use audience language, not tool jargon; define terms on first use.
- Be honest about what is abstracted; build trust by naming limits.

## Recommended Format (Simplest Effective)
- Use the Simple Map Story (7 slides) with one concrete quest example.
- Keep visuals universal: a map, a destination, and a few route choices.
- Avoid niche game terms; describe it as "a map for reaching a goal."

## Slide Outline (10-12 Slides)

### Slide 1: Title - Navigate the Map
- Title: AI-assisted development as a game map
- Audience: company-wide talk, 100 people
- Promise: a simple model for using AI tools well
Notes: Open with why we need a shared mental model before tools.

### Slide 2: Why This Matters Now
- The shift is from autocomplete to delegation
- Capability jumps come from model + tool interface
- Leverage is now available to any team
Notes: Set the curiosity gap: what changed and why it feels different.

### Slide 3: The Game Map Analogy
- Think World of Warcraft, a dungeon run, or a daily plan
- You have a map, goals, resources, and fog of war
- You move from input -> transformation -> output
Notes: Anchor on a familiar story before any technical detail.

### Slide 4: Choose the Main Quest
- One main objective with smaller quests beneath it
- Clarify the request and define success criteria
- Constraints are the map boundaries
Notes: The first move is always define the win.

### Slide 5: Reveal the Map (Explore)
- Read and learn to clear the fog of war
- Identify resources, tools, and constraints
- Build shared context before acting
Notes: Exploration reduces mistakes and rework.

### Slide 6: Map the Skills to the Game
- Goal and success criteria -> s3-define
- Fog of war and learning -> s1-explore
- Paths and tradeoffs -> s4-solutions
- Route plan and checkpoints -> s5-plan
- Execution and save points -> s6-implement + the plan file from s5-plan
Notes: Show the mapping as a quick reference slide.

### Slide 7: Choose a Path (Compare)
- Consider multiple routes, not just one
- Value speed vs safety vs risk
- Pick the best path for now, then adapt
Notes: This is the point where most teams skip too fast.

### Slide 8: Plan the Run
- Break work into phases with checkpoints
- Identify risks and mitigations early
- Define tests and validation
Notes: Planning is not bureaucracy, it is a map of the run.

### Slide 9: Execute and Save
- Fast loop for small changes
- E2E loop for high risk or integration
- Save points: the plan file and a git branch
Notes: Move fast, but keep a rollback.

### Slide 10: Manage the Party (Agents)
- Agents are teammates (Claude, Codex, Gemini CLI)
- Give goals, context, and tasks, not micromanagement
- Review outputs and guide, not every keystroke
Notes: Delegation is the new developer experience.

### Slide 11: Re-Orient and Adapt
- Recap where you are (where)
- Keep notes and decisions (doc)
- Pick the next objective (next)
Notes: When lost, pause and re-check the map.

### Slide 12: Trust, Verify, and Act
- Agents can be wrong; verify the work
- Be honest about what you skip or abstract
- Call to action: start one real quest using the loop
Notes: End with a clear next step and a realistic expectation.

## Simple Map Story (7 Slides, Low Cognitive Load)
Use a single, clean map graphic throughout. Each slide reveals one new element:
goal, unknowns, tools, routes, checkpoints, and outcome. Keep language neutral
and relatable (road trip, daily plan), not niche gaming.

### Slide 1: The Map and the Mission
- Visual: blank map with a single destination marker.
- Script: "We all work from goals. The question is how we reach them. Today I
  want to give you a simple map for AI-assisted development."

### Slide 2: The Old Way vs The New Way
- Visual: same map; left path is manual, right path has an agent icon.
- Script: "Most of us use AI like chat or autocomplete. The shift is to
  delegation: give the agent the mission, not just a step."

### Slide 3: Clear the Unknowns
- Visual: fog overlay; one area revealed.
- Script: "Before we move, we clear the fog. We explore the codebase, the
  constraints, and the context. This is how we avoid wrong turns."

### Slide 4: Choose the Route
- Visual: multiple routes with different symbols (fast, safe, risky).
- Script: "There are always multiple routes. We compare options, decide what we
  value, and commit to a path that fits the objective."

### Slide 5: The Tools and Teammates
- Visual: icons for agents and tools along the path.
- Script: "Agents are teammates. They can work in parallel, but they need clear
  goals and context. We manage them like a team, not a chat box."

### Slide 6: Checkpoints and Save Points
- Visual: checkpoints and a save flag.
- Script: "We plan checkpoints, validate progress, and save our place. Fast
  loop for small changes, deeper loop for risky ones."

### Slide 7: The Outcome and the Gift
- Visual: destination reached, map complete.
- Script: "The result is not just code. It is a reliable outcome delivered
  faster, with fewer surprises. That is the gift of AI-assisted development."

## Example Quest (Use in Narration)
- Goal: ship a customer-facing feature before a Friday demo.
- Unknowns: where the logic lives, edge cases, data dependencies.
- Routes: quick patch vs refactor vs staged rollout.
- Tools: Claude, Codex, Gemini CLI as agent teammates.
- Checkpoints: tests, code review, demo rehearsal.

## Full Skill Coverage Map (All Skills)
- s1-explore: clear the fog; read the terrain and current code.
- s2-clarify: confirm the quest and the request.
- s3-define: set the destination, constraints, and success criteria.
- s4-solutions: evaluate routes and tradeoffs.
- s5-plan: plan the route with phases and checkpoints.
- s6-implement: the change-test-review loop; a short sprint for a small, safe
  change, a full expedition with integration checks when risk is high.
- tdd: test-first loop for new behavior.
- s2-grill-me: let the AI interrogate your plan before you commit.
- ubiquitous-language: agree on the words before you agree on the design.
- handoff: save the run so a fresh session can reload it.
- A git branch: create a save point before a risky move.
