# Getting Started

Six ordered skills, four supporting ones. This guide gets you to a first success in ten minutes and points you to deeper training.

## 1. Install

```bash
git clone https://github.com/evanscastonguay/agentic-problem-solving.git
cd agentic-problem-solving/release
./release.sh --all          # Claude Code, Codex, Cursor, Windsurf
```

Use `--target claude` (or `codex`, `cursor`, `windsurf`) for a single tool. Re-run after pulling updates; the deploy replaces the target folder with the current skill set.

## 2. Invoke a skill

Slash command (Claude Code, Cursor, Windsurf):

```
/s3-define
```

Plain request (any tool):

```
Use s3-define to define the problem for <your task>.
```

Each skill's description says when it applies, so the agent will often pick the right one on its own once you describe the work.

## 3. The default workflow

```
s1-explore → s2-clarify → s3-define → s4-solutions → s5-plan → s6-implement
```

Skip steps that are already done. For a small change, jump straight to `s6-implement`. When you are not sure where you are, start at `s3-define`.

### 60-second example

Task: add dark mode.
Run `/s3-define`, `/s4-solutions`, `/s5-plan`, then `/s6-implement`.
Result: a written problem statement, a chosen approach with the alternatives on record, a phased plan saved to a file, and an implementation that ran the plan phase by phase.

## Choose the right skill fast

| You need to... | Skill |
|---|---|
| understand a codebase before touching it | `s1-explore` |
| kill ambiguity in the request | `s2-clarify` |
| get the AI to interrogate *your* plan | `s2-grill-me` |
| a crisp problem statement and success criteria | `s3-define` |
| options and a recommendation | `s4-solutions` |
| a written, resumable plan | `s5-plan` |
| build it, test it, ship it | `s6-implement` |
| test-first development | `tdd` |
| a shared glossary for the domain | `ubiquitous-language` |
| continue in a fresh session without losing context | `handoff` |

## Troubleshooting

- **Output is vague.** Rerun `s3-define` with explicit constraints and success metrics.
- **The AI is guessing.** Run `s2-clarify`; make it ask before it acts.
- **Lost the thread across sessions.** Re-read the plan file from `s5-plan`, or run `handoff` before you stop.
- **Skill not recognized.** Re-run `release/release.sh --all` and restart the tool.

## Next steps

- Training: [s3-define](training/s3-define-training.md) · [s4-solutions](training/s4-solutions-training.md) · [s5-plan](training/s5-plan-training.md)
- The idea behind the method: [Agent-assisted problem solving](agent-assisted-problem-solving.md)
- Teaching it to others: [talks/](talks/)
