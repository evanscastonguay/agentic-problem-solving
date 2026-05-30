# agentic-problem-solving

A small, composable set of skills that make AI coding agents **reliable** — by giving them structure instead of hope.

> AI doesn't fail because it isn't smart enough. It fails because we don't give it structure.
> You don't prompt better — you **transfer understanding**.

Six skills, one ordered chain. The number in each name **is** the step — run a task through them in sequence (or jump in where you are):

```
s1-explore → s2-clarify → s3-define → s4-solutions → s5-plan → s6-implement
  context  →  precision  →  target   →  strategy    →  memory →  accountability
```

## The six skills

| Step | Skill | Transfers | What it does |
|------|-------|-----------|--------------|
| 1 | `s1-explore`   | situational awareness | read the code/docs and understand the system before changing it |
| 2 | `s2-clarify`   | precision | ask multiple-choice questions to kill ambiguity |
| 3 | `s3-define`    | the target | one-sentence problem + constraints + success criteria |
| 4 | `s4-solutions` | strategy | 3 distinct options with pros/cons; recommend the simplest |
| 5 | `s5-plan`      | memory | a phased, testable plan written to a file you can resume from |
| 6 | `s6-implement` | accountability | TDD + self-review + PR; verify against the criteria |

The magic isn't any single step — it's that, in order, they force you to **transfer understanding**.

## Install (Claude Code)

```bash
git clone https://github.com/evanscastonguay/agentic-problem-solving.git
cp -r agentic-problem-solving/skills/* ~/.claude/skills/
```

The skills sort `s1`…`s6` in your picker, so the sequence is always in front of you. Invoke with `/s1-explore`, `/s2-clarify`, `/s3-define`, `/s4-solutions`, `/s5-plan`, `/s6-implement`.

Works with any tool that supports markdown command/skill files (Cursor, etc.) — drop the `SKILL.md` bodies in as commands.

## A typical flow

```
/s1-explore     -> understand the system
/s2-clarify     -> pin down the request
/s3-define      -> lock the target
/s4-solutions   -> compare 3 approaches
/s5-plan        -> write the phased plan
/s6-implement   -> build it with tests + verification
```

You rarely need all six — start at whichever step matches where you are.

## Philosophy

See [docs/methodology.md](docs/methodology.md): treat AI like a brilliant intern, delegate *outcomes* (not tasks), and trust *evidence* over confidence.

## License

MIT (c) 2026 Evans Castonguay
