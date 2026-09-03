#!/bin/bash
# Release: generate prompts/workflows from skills, then deploy to one or all IDEs.
#
#   ./release.sh --all                         deploy everything, everywhere
#   ./release.sh --target claude               one IDE: claude|codex|cursor|windsurf
#   ./release.sh --all --dry-run               preview
#   ./release.sh --all --extra-skills <dir>    overlay private/work skills from another
#                                              folder (repeatable). They deploy alongside
#                                              this repo's skills but never enter this repo.

set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
REPO_ROOT="$(cd "$SCRIPT_DIR/.." && pwd)"
TRANSFORMER_DIR="$SCRIPT_DIR/transformers"

REPO_SKILLS="$REPO_ROOT/skills"
REPO_PROMPTS="$REPO_ROOT/prompts"
REPO_WORKFLOWS="$REPO_ROOT/workflows"
REPO_AGENTS="$REPO_ROOT/agents"

GREEN='\033[0;32m'; BLUE='\033[0;34m'; YELLOW='\033[1;33m'; NC='\033[0m'

usage() {
    sed -n '2,10p' "$0" | sed 's/^# \{0,1\}//'
}

TARGET=""
DRY_RUN="false"
EXTRA_SKILLS=()

while [[ $# -gt 0 ]]; do
    case $1 in
        --target)        TARGET="$2"; shift 2 ;;
        --all)           TARGET="all"; shift ;;
        --dry-run)       DRY_RUN="true"; shift ;;
        --extra-skills)  EXTRA_SKILLS+=("$2"); shift 2 ;;
        --help|-h)       usage; exit 0 ;;
        *) echo "Unknown option: $1"; usage; exit 1 ;;
    esac
done

if [ -z "$TARGET" ]; then
    echo "Error: no target. Use --target <ide> or --all"; usage; exit 1
fi
case $TARGET in codex|claude|cursor|windsurf|all) ;; *) echo "Error: invalid target '$TARGET'"; usage; exit 1 ;; esac

[ -d "$REPO_SKILLS" ] || { echo -e "${YELLOW}Error: $REPO_SKILLS does not exist${NC}"; exit 1; }
chmod +x "$TRANSFORMER_DIR"/*.sh "$SCRIPT_DIR"/*.sh

# 1. Keep the repo's own committed prompts/ and workflows/ current
echo -e "${BLUE}=== Generating prompts + workflows from skills ===${NC}"
bash "$SCRIPT_DIR/generate.sh" "$REPO_SKILLS" "$REPO_PROMPTS" "$REPO_WORKFLOWS"

# 2. Build the deploy set: repo skills (+ any overlays) in a staging dir
SRC_SKILLS="$REPO_SKILLS"; SRC_PROMPTS="$REPO_PROMPTS"; SRC_WORKFLOWS="$REPO_WORKFLOWS"
if [ ${#EXTRA_SKILLS[@]} -gt 0 ]; then
    STAGE="$(mktemp -d "${TMPDIR:-/tmp}/aps-release.XXXXXX")"
    trap 'rm -rf "$STAGE"' EXIT
    mkdir -p "$STAGE/skills"
    cp -R "$REPO_SKILLS"/. "$STAGE/skills/"
    for extra in "${EXTRA_SKILLS[@]}"; do
        [ -d "$extra" ] || { echo -e "${YELLOW}Error: --extra-skills dir not found: $extra${NC}"; exit 1; }
        echo -e "${BLUE}=== Overlaying skills from $extra ===${NC}"
        for d in "$extra"/*/; do
            [ -f "$d/SKILL.md" ] || continue
            name=$(basename "$d")
            [ -d "$REPO_SKILLS/$name" ] && echo -e "${YELLOW}  ! $name overrides the repo skill of the same name${NC}" || echo "  + $name"
            rm -rf "$STAGE/skills/$name"; cp -R "$d" "$STAGE/skills/$name"
        done
    done
    bash "$SCRIPT_DIR/generate.sh" "$STAGE/skills" "$STAGE/prompts" "$STAGE/workflows"
    SRC_SKILLS="$STAGE/skills"; SRC_PROMPTS="$STAGE/prompts"; SRC_WORKFLOWS="$STAGE/workflows"
fi

# 3. Deploy
echo -e "${BLUE}=== Deploying ($TARGET) ===${NC}"
[ "$DRY_RUN" = "true" ] && echo -e "${YELLOW}[DRY RUN MODE]${NC}"

deploy_codex()    { bash "$TRANSFORMER_DIR/codex.sh"    "$SRC_PROMPTS" "$SRC_SKILLS" "$DRY_RUN"; }
deploy_cursor()   { bash "$TRANSFORMER_DIR/cursor.sh"   "$SRC_PROMPTS" "$DRY_RUN"; }
deploy_windsurf() { bash "$TRANSFORMER_DIR/windsurf.sh" "$SRC_WORKFLOWS" "$DRY_RUN"; }
deploy_claude()   {
    bash "$TRANSFORMER_DIR/claude.sh" "$SRC_SKILLS" "$DRY_RUN"
    [ -d "$REPO_AGENTS" ] && bash "$TRANSFORMER_DIR/claude-agents.sh" "$REPO_AGENTS" "$DRY_RUN"
}

case $TARGET in
    codex)    deploy_codex ;;
    claude)   deploy_claude ;;
    cursor)   deploy_cursor ;;
    windsurf) deploy_windsurf ;;
    all)      deploy_codex; deploy_claude; deploy_cursor; deploy_windsurf ;;
esac

echo ""
echo -e "${GREEN}=== Release complete: $TARGET ===${NC}"
[ "$DRY_RUN" = "false" ] && echo "Skills deployed: $(ls -1 "$SRC_SKILLS" | tr '\n' ' ')"
exit 0
