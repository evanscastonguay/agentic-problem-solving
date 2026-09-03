#!/bin/bash
# Windsurf transformer - deploys workflows only (skills loaded from Claude)
# Note: Windsurf loads skills from ~/.claude/skills/ to avoid duplicates

set -e

SOURCE_WORKFLOWS="$1"
DRY_RUN="${2:-false}"

TARGET_WORKFLOWS="$HOME/.codeium/windsurf/global_workflows"

echo "=== Windsurf Transformer ==="

if [ "$DRY_RUN" = "true" ]; then
    echo "[DRY RUN] Would deploy:"
    echo "  Workflows: $SOURCE_WORKFLOWS -> $TARGET_WORKFLOWS"
    echo "  Skills: Using Claude skills from ~/.claude/skills/ (no deployment needed)"
    exit 0
fi

# Backup existing workflows if directory exists
if [ -d "$TARGET_WORKFLOWS" ]; then
    echo "Backing up existing workflows"
    BACKUP_DIR="$HOME/.codeium/windsurf/backup_$(date +%Y%m%d_%H%M%S)"
    mkdir -p "$BACKUP_DIR"
    cp -r "$TARGET_WORKFLOWS" "$BACKUP_DIR/global_workflows_old"
fi

# Create target directory
mkdir -p "$TARGET_WORKFLOWS"

# Deploy workflows only
echo "Deploying workflows to $TARGET_WORKFLOWS"
rsync -av --delete "$SOURCE_WORKFLOWS/" "$TARGET_WORKFLOWS/"

echo "✓ Windsurf deployment complete (workflows only)"
echo "  Skills are loaded from ~/.claude/skills/"
