# Agentic Problem-Solving

**Six ordered skills that make AI coding agents reliable enough for real work.** Drop them into [Claude Code](https://claude.ai/code) or Cursor and run any task through them in order.

> AI doesn't fail because it isn't smart enough. It fails because we don't give it structure.

[![License: MIT](https://img.shields.io/badge/License-MIT-green.svg)](LICENSE)
![Works with Claude Code](https://img.shields.io/badge/Claude%20Code-ready-c0540a)
![Works with Cursor](https://img.shields.io/badge/Cursor-ready-1a2744)

---

## The problem

You've felt it: the model that can ace a math olympiad chokes on a simple refactor in *your* codebase. That's not a failure of intelligence — it's a failure of instruction. The fix isn't a cleverer prompt. It's a repeatable process that **transfers understanding** to the AI.

Treat the AI like a brilliant new intern: vast knowledge, but blind to your context and too eager to please to admit when it's guessing. You'd never tell a new hire "make it better" and walk away. This framework is how you brief it properly — every time.

## The six steps

Run them in order, or jump in where you are. Each step hands the AI one thing it was missing.

| Step | Skill | Hands the AI |
|------|-------|--------------|
| 1 | `/s1-explore` — understand the system before touching it | **Context** |
| 2 | `/s2-clarify` — ask the questions that kill ambiguity | **Precision** |
| 3 | `/s3-define` — lock the problem, constraints, success criteria | **A target** |
| 4 | `/s4-solutions` — compare 3 approaches, pick the simplest | **A strategy** |
| 5 | `/s5-plan` — write a phased plan you can resume from | **Memory** |
| 6 | `/s6-implement` — build it test-first, then verify the result | **Accountability** |

The magic isn't any single step — it's that together they force you to transfer understanding instead of hoping a prompt lands.

## Supporting skills

Standalone skills that complement the six-step chain:

| Skill | What it does |
|-------|--------------|
| `/tdd` | Test-driven development with a red-green-refactor loop — vertical slices, one test at a time, with references on deep modules, mocking, and refactoring |
| `/s2-grill-me` | Flips step 2 around: the AI interviews *you* relentlessly about a plan until you reach shared understanding |
| `/ubiquitous-language` | Extracts a DDD-style glossary from the conversation, flags ambiguous terms, and proposes canonical ones |
| `/handoff` | Compacts the current conversation into a handoff document so a fresh session can pick up where you left off |

## Not just for code

The same chain works for any complex problem you'd hand a sharp collaborator — strategy, planning, writing, analysis, research. Explore the landscape, clarify the ask, define success, weigh options, plan, execute and verify. Code is just where the payoff is easiest to see.

## Install

One command deploys every skill to the AI tools on your machine — Claude Code, Codex, Cursor, and Windsurf:

```bash
git clone https://github.com/evanscastonguay/agentic-problem-solving.git
cd agentic-problem-solving/release
./release.sh --all                 # or: --target claude | codex | cursor | windsurf
```

Prefer to do it by hand? The skills are plain markdown: `cp -r skills/* ~/.claude/skills/`.

They sort `s1`…`s6` in your skill picker, so the order is always in front of you.

### Keep private skills alongside

Work or client-specific skills should never land in a public repo. Keep them in their own folder and overlay them at deploy time:

```bash
./release.sh --all --extra-skills ~/work/private-skills
```

Everything deploys together; nothing private enters this repo.

## Repository layout

```
skills/       the source of truth — one SKILL.md per skill
prompts/      generated from skills/ for Codex and Cursor   (do not edit)
workflows/    generated from skills/ for Windsurf           (do not edit)
release/      release.sh (deploy), skill.sh (create/archive), generate.sh
docs/         guides, training material, and talks — also the GitHub Pages site
```

Add a skill with `release/skill.sh create my-skill`, edit its `SKILL.md`, then `release/release.sh --all`.

## Why it works

- **Treat AI like a brilliant intern** — vast knowledge, but context-blind and eager to please.
- **Delegate outcomes, not tasks.**
- **Trust evidence, not confidence** — make it verify its own work.

## License

MIT © 2026 Evans Castonguay — use it, fork it, ship it.

---

*If you run a real task through this, [open an issue](https://github.com/evanscastonguay/agentic-problem-solving/issues) and tell me what broke and what worked. I improve it in the open.*
