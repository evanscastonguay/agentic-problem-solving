---
name: fog
description: Remove the fog of war in a long session — rebuild a plain-language "you are here" page (goal, done / doing / remaining, what is waiting on the user, decoded references) from the conversation and plan files, and save it as fog.html. Use when the user asks where we are, what is done or remaining, says they are lost, asks to recap the plan or status, or says "fog" or "remove the fog of war".
---

# Fog — you are here

First principle: after hours of autonomous work, the person has lost the map, not the plot. Give them the map in plain words, in layers, and let them stop reading as soon as they know where they are.

Two layers, both required: a **short summary** on top (where we are, next step, what needs the user), and a **complete itemized list** below (every plan item with its status). The summary may group; the list may not drop anything.

The page is also the memory: `fog.html` stores its state in a JSON block. Each run reads the previous state, updates it, and rewrites the page. There is no other file.

## 1. Gather

- **Previous state:** from the working directory, `python3 <this skill folder>/fog.py extract fog.html` (the folder is usually `~/.claude/skills/fog/`; prints `{}` the first time). Keep `artifact_url`. Compare with what you find next to fill `changes_since_last`.
- **The conversation:** including any compaction summary and the answers to earlier AskUserQuestion prompts. It is the only record of what the user asked and what is pending. Note the last thing the AI asked or was doing: it becomes `now.doing` or an entry in `waiting_on_you`.
- **Plan files:** `find . -maxdepth 4 \( -name '*PLAN*.md' -o -name '*SHIP*.md' -o -name '*TODO*.md' \) -not -path '*/node_modules/*' -exec ls -lt {} +` (this also finds plans in nested repos) and any plan the conversation names. Decide which one is **active** (the one the recent work follows) and mark the others **stale** or **reference**. When a plan file and the conversation disagree, say so in the page.
- **Recent activity:** `git log --oneline -15` and `git status -sb` in each repo that holds an active plan; the session's task list (TaskList) if one exists.
- **Another session:** if the argument is a `.jsonl` transcript path, analyze that transcript instead of this conversation. Transcripts are large: extract the human messages, AskUserQuestion calls, compaction summaries, and plan-file writes with a script (or a subagent), never read the whole file. Work from the latest day and the last compaction summary; older history only explains codes and decisions. Read that session's project folder, but write `fog.html` in the current working directory.

## 2. Distill

Write the state JSON (schema below). Rules:

- **Plain words.** Write for someone smart who was not in the room. No jargon without a meaning next to it.
- **Decode every reference.** Every code, number or nickname the recent conversation used (`P4`, `#74`, `N1`, "option B", "the ghost bug", a branch name) goes into `decoder` with one plain sentence of meaning and why it matters. Group related codes into one entry ("F5, F6: the two CI checks") and keep it under about 40 entries, recent ones first. Inside the page, never use a bare code: write "P4 (live test + speed tuning)".
- **Outcomes, not activity.** "Login works on the phone", not "edited auth.ts".
- **Short.** `goal` one sentence (≤ 25 words). Each item ≤ 12 words; put more in `detail`. `glance` ≤ 20 words.
- **Complete list.** For the main thread, fill `phases` with **every item** of the active plan file, in the plan's order and grouping, each with `status`: `done`, `doing`, `left`, or `you` (needs the user). Extract the items with a script (checkbox lines, table rows with an ID, numbered steps), never from memory. Keep the plan's ID in `id` and write `text` in plain words. Add items the conversation created that the plan lacks, with `"source": "chat"`. Mark the phase being worked on `"current": true`. Side threads get `phases` too when they have their own plan or list.
- **Coverage.** Set `coverage` from that script's count: `plan_items` (items in the plan), `listed` (plan items in `phases`), `from_chat`. `listed` must equal `plan_items`; if it cannot, the page flags the gap in red, so say why in the chat reply.
- **Next step.** `next.ai` is the AI's next concrete action; `next.you` is the single most useful thing the user can do now (or "Nothing, the AI can continue"). Both are one sentence.
- **Main thread first.** The thread the user is working on now gets `"main": true` and the done / doing / remaining board (the grouped summary, at most about 8 items per column); the counts in the chat reply come from it. `now.phase` is free text for where the plan stands, e.g. "Phase 1 almost done, Phase 2 at 21%". Every side thread (another feature, a printer detour, an email to send) gets one entry with a status and a one-line summary.
- **Waiting on you** holds every open question or blocked decision, rewritten so it can be answered cold: `where` (phase and step), `context` (what it refers to, in plain words), `options` with what each changes for the user, a `recommended` flag, and `why`. Decisions come first. Chores only the user can do (create an account, back up a key, review a document) come after, one entry each, with `where` and `context` but no `options`. If nothing is waiting, leave it empty.
- **Decisions** keep a one-line `why`; open ones are `"status": "open"`.
- **Ideas:** at most 5, only concepts the user needs to follow the current or next decision. Three layers: `glance` (one sentence), `understand` (a short paragraph with an everyday comparison), `deeper` (the exact details).
- Never invent progress. Mark something done only with evidence (a passing test, a commit, a user confirmation).
- Write in the conversation's language; an argument like `fr` or `en` overrides it.
- Redact secrets and tokens. Never name people, the user included: refer to them by role ("the Mac tester"), and leave out usernames, emails and paths that contain a name.
- `updated` is local time with its zone ("2026-09-27 12:11 EDT"); transcripts store UTC. In `sources`, name another session as "transcript <first 8 chars of its id>".

Schema:

```json
{
  "version": 1,
  "project": "Omac",
  "updated": "YYYY-MM-DD HH:MM TZ",
  "language": "en",
  "artifact_url": "",
  "goal": "",
  "changes_since_last": [""],
  "now": { "thread": "", "phase": "Phase 2 of 6: ...", "doing": "What the AI is doing right now, in plain words" },
  "next": { "ai": "The AI's next concrete action", "you": "The most useful thing the user can do now" },
  "coverage": { "plan_file": "PLAN-x.md", "plan_items": 0, "listed": 0, "from_chat": 0 },
  "waiting_on_you": [{ "question": "", "where": "", "context": "", "options": [{ "label": "", "effect": "", "recommended": true }], "why": "" }],
  "threads": [{ "name": "", "main": true, "status": "doing|done|blocked|parked", "summary": "",
                "done": [{ "text": "", "detail": "" }], "doing": [], "left": [],
                "phases": [{ "name": "Phase 1: ...", "current": false,
                             "items": [{ "id": "B3", "text": "", "status": "done|doing|left|you", "detail": "", "source": "plan|chat" }] }] }],
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

Six lines, the last one the link:

```
📍 <thread> · <phase> — <done> done, <doing> in progress, <left> left
⏳ Right now: <what is happening>
➡️ Next: AI <next.ai> · You <next.you>
❓ Waiting on you: <the question in one line, or "nothing">
🔁 Since last time: <biggest change> · <listed>/<plan_items> plan items listed
🗺  <link or path to fog.html>
```

Do not repeat the page in chat.
