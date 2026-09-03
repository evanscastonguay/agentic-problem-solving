#!/bin/bash
# Generate prompts (Codex/Cursor) and workflows (Windsurf) from skills.
# Skills are the single source of truth; never edit prompts/ or workflows/ by hand.
#
# Usage: generate.sh [<skills_dir> <prompts_out> <workflows_out>]
#   Defaults to the repo's own skills/, prompts/, workflows/.

set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
REPO_ROOT="$(cd "$SCRIPT_DIR/.." && pwd)"

SKILLS_DIR="${1:-$REPO_ROOT/skills}"
PROMPTS_DIR="${2:-$REPO_ROOT/prompts}"
WORKFLOWS_DIR="${3:-$REPO_ROOT/workflows}"

# "s1-explore" -> "1 Explore", "tdd" -> "Tdd", "s2-grill-me" -> "2 Grill Me"
title_from_name() {
    local name="$1"
    if [[ "$name" =~ ^s([0-9]+)-(.+)$ ]]; then
        local n="${BASH_REMATCH[1]}" rest="${BASH_REMATCH[2]}"
        echo "$n $(echo "$rest" | sed 's/-/ /g' | awk '{for(i=1;i<=NF;i++)sub(/./,toupper(substr($i,1,1)),$i)}1')"
    else
        echo "$name" | sed 's/-/ /g' | awk '{for(i=1;i<=NF;i++)sub(/./,toupper(substr($i,1,1)),$i)}1'
    fi
}

mkdir -p "$PROMPTS_DIR" "$WORKFLOWS_DIR"
rm -f "$PROMPTS_DIR"/*.md "$WORKFLOWS_DIR"/*.md

count=0
for skill_dir in "$SKILLS_DIR"/*; do
    [ -d "$skill_dir" ] && [ -f "$skill_dir/SKILL.md" ] || continue
    name=$(basename "$skill_dir")
    [ "$name" = ".system" ] && continue

    description=$(sed -n '/^description:/s/^description: *//p' "$skill_dir/SKILL.md" | head -1)
    [ -z "$description" ] && description="Workflow for $name"

    # Body = everything after the closing --- of the frontmatter
    # Body = everything after the frontmatter, minus the skill's own H1 (the wrapper adds one)
    body=$(awk 'f==2{print} /^---$/{f++}' "$skill_dir/SKILL.md" | awk 'NR==1 && /^$/ {next} {print}' | awk 'h==0 && /^# / {h=1; next} h==0 && /^$/ {next} {h=1; print}' | awk 'NF{p=1} p')
    title=$(title_from_name "$name")

    cat > "$PROMPTS_DIR/$name.md" <<PROMPT
# $title

> $description

$body
PROMPT

    cat > "$WORKFLOWS_DIR/$name.md" <<WORKFLOW
---
description: $description
---

# $name Workflow

$body
WORKFLOW

    count=$((count + 1))
done

echo "✓ Generated $count prompts -> $PROMPTS_DIR"
echo "✓ Generated $count workflows -> $WORKFLOWS_DIR"
