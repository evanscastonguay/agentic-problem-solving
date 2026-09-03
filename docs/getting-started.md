# Getting Started

Install per the [README](../README.md), then run one real task through the chain.

## Invoke a skill

Slash command (Claude Code, Cursor, Windsurf):

```
/s3-define
```

Plain request (any tool):

```
Use s3-define to define the problem for <your task>.
```

Each skill's description says when it applies, so once you describe the work the agent will usually pick the right one itself.

## The chain

```
s1-explore → s2-clarify → s3-define → s4-solutions → s5-plan → s6-implement
```

Skip steps already done. For a small change, jump straight to `s6-implement`. Not sure where you are? Start at `s3-define`.

## Ten-minute first run

Task: add dark mode.

1. `/s3-define` — one-sentence problem, constraints, measurable success criteria.
2. `/s4-solutions` — three approaches, pros and cons, one decisive recommendation.
3. `/s5-plan` — phased plan with risks and tests, saved to a file you can resume from.
4. `/s6-implement` — run the plan phase by phase: change, test, self-review, PR.

You end with a problem statement, a recorded decision, a plan file, and a verified implementation.

## When it goes wrong

- **Output is vague.** Rerun `s3-define` with explicit constraints and success metrics.
- **The AI is guessing.** Run `s2-clarify`; make it ask before it acts.
- **Lost the thread across sessions.** Re-read the plan file, or run `handoff` before you stop.
- **Skill not recognized.** Re-run `./release.sh --all` and restart the tool.

Next: the [training guides](training/) for steps 3 to 5, and the [talks](talks/) if you are teaching this to others.
