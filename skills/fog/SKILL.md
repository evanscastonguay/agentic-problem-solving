---
name: fog
description: Remove the fog of war in a long session — rebuild a plain-language "you are here" page (goal, done / doing / remaining, what is waiting on the user, decoded references) from the conversation and plan files, and save it as fog.html. Use when the user asks where we are, what is done or remaining, says they are lost, asks to recap the plan or status, or says "fog" or "remove the fog of war".
---

# Fog — you are here

First principle: after hours of autonomous work, the person has lost the map, not the plot. Give them the map in plain words, in layers, and let them stop reading as soon as they know where they are.

The page is also the memory: `fog.html` stores its state in a JSON block. Each run reads the previous state, updates it, and rewrites the page. There is no other file.

## 1. Gather

- **Previous state:** from the working directory, `python3 <this skill folder>/fog.py extract fog.html` (the folder is usually `~/.claude/skills/fog/`; prints `{}` the first time). Keep `artifact_url`. Compare with what you find next to fill `changes_since_last`.
- **The conversation:** including any compaction summary. It is the only record of what the user asked and what is pending.
- **Plan files:** `ls -t *PLAN*.md *SHIP*.md *TODO*.md docs/*PLAN*.md 2>/dev/null` and any plan the conversation names. Decide which one is **active** (the one the recent work follows) and mark the others **stale** or **reference**. When a plan file and the conversation disagree, say so in the page.
- **Recent activity:** `git log --oneline -15` and `git status -sb` if it is a repo; the task list if one exists.
- **Another session:** if the argument is a `.jsonl` transcript path, analyze that transcript instead of this conversation. Transcripts are large: extract the human messages, AskUserQuestion calls, compaction summaries, and plan-file writes with a script (or a subagent), never read the whole file.

## 2. Distill

Write the state JSON (schema below). Rules:

- **Plain words.** Write for someone smart who was not in the room. No jargon without a meaning next to it.
- **Decode every reference.** Every code, number or nickname the conversation used (`P4`, `#74`, `N1`, "option B", "the ghost bug", a branch name) goes into `decoder` with one plain sentence of meaning and why it matters. Inside the page, never use a bare code: write "P4 (live test + speed tuning)".
- **Outcomes, not activity.** "Login works on the phone", not "edited auth.ts".
- **Short.** `goal` one sentence (≤ 25 words). Each item ≤ 12 words; put more in `detail`. `glance` ≤ 20 words.
- **Main thread first.** The thread the user is working on now gets `"main": true` and the done / doing / remaining board. Every side thread (another feature, a printer detour, an email to send) gets one entry with a status and a one-line summary.
- **Waiting on you** holds every open question or blocked decision, rewritten so it can be answered cold: `where` (phase and step), `context` (what it refers to, in plain words), `options` with what each changes for the user, a `recommended` flag, and `why`. If nothing is waiting, leave it empty.
- **Decisions** keep a one-line `why`; open ones are `"status": "open"`.
- **Ideas:** at most 5, only concepts the user needs to follow the current or next decision. Three layers: `glance` (one sentence), `understand` (a short paragraph with an everyday comparison), `deeper` (the exact details).
- Never invent progress. Mark something done only with evidence (a passing test, a commit, a user confirmation).
- Write in the conversation's language; an argument like `fr` or `en` overrides it.
- Redact secrets, tokens and personal data.

Schema:

```json
{
  "version": 1,
  "project": "Omac",
  "updated": "YYYY-MM-DD HH:MM",
  "language": "en",
  "artifact_url": "",
  "goal": "",
  "changes_since_last": [""],
  "now": { "thread": "", "phase": "Phase 2 of 6: ...", "doing": "What the AI is doing right now, in plain words" },
  "waiting_on_you": [{ "question": "", "where": "", "context": "", "options": [{ "label": "", "effect": "", "recommended": true }], "why": "" }],
  "threads": [{ "name": "", "main": true, "status": "doing|done|blocked|parked", "summary": "",
                "done": [{ "text": "", "detail": "" }], "doing": [], "left": [] }],
  "decisions": [{ "text": "", "why": "", "status": "locked|open" }],
  "decoder": [{ "code": "", "means": "", "why": "" }],
  "ideas": [{ "name": "", "glance": "", "understand": "", "deeper": "" }],
  "plan_files": [{ "path": "", "role": "active|stale|reference", "note": "" }],
  "sources": ["this conversation", "PLAN-x.md", "git log"]
}
```

## 3. Render and publish

- Save the JSON to a temp file, then `python3 <this skill folder>/fog.py render <state.json> fog.html` (writes `fog.html` in the working directory; never edits plan files).
- If an Artifact tool is available, publish `fog.html`: with `url` set to `artifact_url` when it exists, so the link stays the same. On the first publish, store the new link in `artifact_url` and render once more locally (no second publish). Otherwise tell the user to open the file.

## 4. Reply in chat

Five lines at most, then the link:

```
📍 <thread> · <phase> — <done> done, <doing> in progress, <left> left
⏳ Right now: <what is happening>
❓ Waiting on you: <the question in one line, or "nothing">
🔁 Since last time: <biggest change>
🗺  <link or path to fog.html>
```

Do not repeat the page in chat.
