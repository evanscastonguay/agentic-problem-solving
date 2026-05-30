# agentic-problem-solving

A small, composable set of skills that make AI coding agents **reliable** — by giving them structure instead of hope.

> AI doesn't fail because it isn't smart enough. It fails because we don't give it structure.
> You don't prompt better — you **transfer understanding**.

These six skills form a problem-resolution chain. Run a task through them — in order, or jump in where you are — and you transfer the agent everything it was missing: context, precision, a target, a strategy, memory, and accountability.

## The six skills

| # | Skill | Transfers | What it does |
|---|-------|-----------|--------------|
| 1 | `explore`   | situational awareness | read the code/docs and understand the system before changing it |
| 2 | `clarify`   | precision | ask multiple-choice questions to kill ambiguity |
| 3 | `define`    | the target | one-sentence problem + constraints + success criteria |
| 4 | `solutions` | strategy | 3 distinct options with pros/cons; recommend the simplest |
| 5 | `plan`      | memory | a phased, testable plan written to a file you can resume from |
| 6 | `implement` | accountability | TDD + self-review + PR; verify against the criteria |

The magic isn't any single step — it's that together they force you to **transfer understanding**.

## Install (Claude Code)

```bash
git clone https://github.com/evanscastonguay/agentic-problem-solving.git
cp -r agentic-problem-solving/skills/* ~/.claude/skills/
```

Then invoke in Claude Code: `/explore`, `/clarify`, `/define`, `/solutions`, `/plan`, `/implement`.

Works with any tool that supports markdown command/skill files (Cursor, etc.) — drop the `SKILL.md` bodies in as commands.

## A typical flow

```
/explore     -> understand the system
/clarify     -> pin down the request
/define      -> lock the target
/solutions   -> compare 3 approaches
/plan        -> write the phased plan
/implement   -> build it with tests + verification
```

You rarely need all six — start at whichever step matches where you are.

## Philosophy

See [docs/methodology.md](docs/methodology.md): treat AI like a brilliant intern, delegate *outcomes* (not tasks), and trust *evidence* over confidence.

## License

MIT (c) 2026 Evans Castonguay
