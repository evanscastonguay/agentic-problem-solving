# agentic-problem-solving

Six ordered skills that make AI coding agents **reliable**. Drop them into Claude Code (or Cursor) and run a task through them in order.

> AI doesn't fail because it isn't smart enough. It fails because we don't give it structure.

## The six steps

The number is the step. Run them in order — or jump in where you are.

```
1. /s1-explore     understand the system before touching it
2. /s2-clarify     ask the questions that kill ambiguity
3. /s3-define      lock the problem, constraints, and success criteria
4. /s4-solutions   compare 3 approaches, pick the simplest
5. /s5-plan        write a phased plan you can resume from
6. /s6-implement   build it test-first, then verify the result
```

Each step hands the AI something it was missing — context, precision, a target, a strategy, memory, accountability. Together they make you **transfer understanding** instead of hoping a prompt lands.

## Install

```bash
git clone https://github.com/evanscastonguay/agentic-problem-solving.git
cp -r agentic-problem-solving/skills/* ~/.claude/skills/
```

They sort `s1`…`s6` in your skill picker, so the order is always in front of you. (Any tool that reads markdown command files works — Cursor, etc.)

## Why it works

- **Treat AI like a brilliant intern** — vast knowledge, but context-blind and eager to please. You wouldn't tell a new hire "make it better" and walk away.
- **Delegate outcomes, not tasks.**
- **Trust evidence, not confidence** — make it verify its own work.

## License

MIT © 2026 Evans Castonguay
