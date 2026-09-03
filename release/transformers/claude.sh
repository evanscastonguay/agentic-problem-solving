#!/bin/bash
# Claude transformer - deploys skills to Claude IDE

set -e

SOURCE_SKILLS="$1"
DRY_RUN="${2:-false}"

TARGET_SKILLS="$HOME/.claude/skills"

echo "=== Claude Transformer ==="

if [ "$DRY_RUN" = "true" ]; then
    echo "[DRY RUN] Would deploy:"
    echo "  Skills: $SOURCE_SKILLS -> $TARGET_SKILLS"
    exit 0
fi

# Remove existing symlink if present
if [ -L "$TARGET_SKILLS" ]; then
    echo "Removing symlink: $TARGET_SKILLS"
    rm "$TARGET_SKILLS"
fi

# Create target directory
mkdir -p "$TARGET_SKILLS"

# Deploy skills
echo "Deploying skills to $TARGET_SKILLS"
rsync -av --delete "$SOURCE_SKILLS/" "$TARGET_SKILLS/"

echo "✓ Claude deployment complete"
