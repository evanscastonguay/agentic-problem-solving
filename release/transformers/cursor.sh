#!/bin/bash
# Cursor transformer - deploys prompts as commands to Cursor IDE

set -e

SOURCE_PROMPTS="$1"
DRY_RUN="${2:-false}"

TARGET_COMMANDS="$HOME/.cursor/commands"

echo "=== Cursor Transformer ==="

if [ "$DRY_RUN" = "true" ]; then
    echo "[DRY RUN] Would deploy:"
    echo "  Commands: $SOURCE_PROMPTS -> $TARGET_COMMANDS"
    exit 0
fi

# Create target directory
mkdir -p "$TARGET_COMMANDS"

# Deploy prompts as commands
echo "Deploying prompts as commands to $TARGET_COMMANDS"
rsync -av --delete "$SOURCE_PROMPTS/" "$TARGET_COMMANDS/"

echo "✓ Cursor deployment complete"
