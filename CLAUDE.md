# CLAUDE.md

Guidance for Claude Code when working in this repository.

## What this is

A set of AI-agent skills (markdown with YAML frontmatter) plus a small bash pipeline that deploys them to Claude Code, Codex, Cursor, and Windsurf. No application code, no tests, no CI.

## Source of truth

`skills/<name>/SKILL.md` is the only thing you edit. `prompts/` and `workflows/` are generated from it by `release/generate.sh` on every release — never edit them by hand.

## Commands (run from `release/`)

```bash
./release.sh --all                              # generate + deploy everywhere
./release.sh --target claude                    # one IDE: claude|codex|cursor|windsurf
./release.sh --all --dry-run                    # preview
./release.sh --all --extra-skills <dir>         # overlay private skills from another folder
./skill.sh list | create <name> | disable <name> | enable <name> | delete <name> [--force]
```

## Deploy behavior

Transformers in `release/transformers/` use `rsync --delete`: each deploy is a destructive sync of the target folder (`~/.claude/skills`, `~/.codex/{skills,prompts}`, `~/.cursor/commands`, `~/.codeium/windsurf/global_workflows`). Anything in a target that is not in the deploy set is removed. Codex's `.system/` is excluded.

## Skill anatomy

```yaml
---
name: s3-define
description: One line. Say what it does AND when to use it ("Use when the user asks to ...").
---

# Step 3 — Define

First principle: ...

- steps
```

The `description` must stay on one line; the generator reads it with `sed`. Skill names: lowercase letters, digits, hyphens. Sequential skills are `s1`…`s6`; supporting skills have plain names.

## Publishing rules

This repo is public and MIT-licensed. Never commit employer or client identifiers, internal hostnames, ticket keys, or third-party transcripts. Private skills live in a separate repo and deploy via `--extra-skills`.
