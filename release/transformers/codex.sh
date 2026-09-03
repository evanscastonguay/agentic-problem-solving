#!/bin/bash
# Codex transformer - deploys prompts and skills to Codex IDE

set -e

SOURCE_PROMPTS="$1"
SOURCE_SKILLS="$2"
DRY_RUN="${3:-false}"

TARGET_PROMPTS="$HOME/.codex/prompts"
TARGET_SKILLS="$HOME/.codex/skills"

echo "=== Codex Transformer ==="

if [ "$DRY_RUN" = "true" ]; then
    echo "[DRY RUN] Would deploy:"
    echo "  Prompts: $SOURCE_PROMPTS -> $TARGET_PROMPTS"
    echo "  Skills: $SOURCE_SKILLS -> $TARGET_SKILLS"
    exit 0
fi

# Remove existing symlinks if present
if [ -L "$TARGET_PROMPTS" ]; then
    echo "Removing symlink: $TARGET_PROMPTS"
    rm "$TARGET_PROMPTS"
fi

if [ -L "$TARGET_SKILLS" ]; then
    echo "Removing symlink: $TARGET_SKILLS"
    rm "$TARGET_SKILLS"
fi

# Create target directories
mkdir -p "$TARGET_PROMPTS"
mkdir -p "$TARGET_SKILLS"

# Deploy prompts
echo "Deploying prompts to $TARGET_PROMPTS"
rsync -av --delete "$SOURCE_PROMPTS/" "$TARGET_PROMPTS/"

# Deploy skills (exclude .system/ which is managed by Codex itself)
echo "Deploying skills to $TARGET_SKILLS"
rsync -av --delete --exclude '.system' "$SOURCE_SKILLS/" "$TARGET_SKILLS/"

echo "✓ Codex deployment complete"
