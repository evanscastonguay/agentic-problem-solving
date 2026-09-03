#!/bin/bash
# Claude agents transformer - deploys subagent files to Claude Code

set -e

SOURCE_AGENTS="$1"
DRY_RUN="${2:-false}"

TARGET_AGENTS="$HOME/.claude/agents"

echo "=== Claude Agents Transformer ==="

if [ "$DRY_RUN" = "true" ]; then
    echo "[DRY RUN] Would deploy:"
    echo "  Agents: $SOURCE_AGENTS -> $TARGET_AGENTS"
    exit 0
fi

mkdir -p "$TARGET_AGENTS"

echo "Deploying agents to $TARGET_AGENTS"
rsync -av --delete "$SOURCE_AGENTS/" "$TARGET_AGENTS/"

echo "✓ Claude agents deployment complete"
