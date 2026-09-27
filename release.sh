#!/bin/bash
# Deploy the skills to Claude Code, Codex, Cursor and Windsurf.
#   ./release.sh --all                          everywhere
#   ./release.sh --target claude                one of: claude | codex | cursor | windsurf
#   ./release.sh --all --extra-skills <dir>     also deploy private skills from another folder (repeatable)
#   ./release.sh --all --dry-run                show what would be deployed
#
# skills/ is the only source. Prompts (Codex, Cursor) and workflows (Windsurf) are generated
# here at deploy time. Only entries an earlier deploy installed are ever removed, so skills from
# other sources (plugins, synced or linked skills) are left alone. global-rules.md goes into
# ~/.claude/CLAUDE.md and ~/.codex/AGENTS.md between markers.
set -e

ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
TARGET=""; DRY=false; EXTRA=()

while [[ $# -gt 0 ]]; do
    case $1 in
        --all)          TARGET=all; shift ;;
        --target)       TARGET=$2; shift 2 ;;
        --dry-run)      DRY=true; shift ;;
        --extra-skills) EXTRA+=("$2"); shift 2 ;;
        -h|--help)      sed -n '2,6p' "$0" | sed 's/^# \{0,1\}//'; exit 0 ;;
        *) echo "Unknown option: $1"; exit 1 ;;
    esac
done
case $TARGET in
    all|claude|codex|cursor|windsurf) ;;
    *) echo "Usage: $0 --all | --target <claude|codex|cursor|windsurf> [--extra-skills <dir>] [--dry-run]"; exit 1 ;;
esac

# --- 1. Stage the deploy set: repo skills, then overlays -------------------------------
STAGE="$(mktemp -d "${TMPDIR:-/tmp}/aps.XXXXXX")"; trap 'rm -rf "$STAGE"' EXIT
mkdir -p "$STAGE/skills" "$STAGE/prompts" "$STAGE/workflows"
cp -R "$ROOT/skills/." "$STAGE/skills/"
for dir in "${EXTRA[@]}"; do
    [ -d "$dir" ] || { echo "Error: --extra-skills folder not found: $dir"; exit 1; }
    for d in "$dir"/*/; do
        [ -f "$d/SKILL.md" ] || continue
        n=$(basename "$d")
        [ -d "$ROOT/skills/$n" ] && echo "  ! $n overrides the repo skill of the same name"
        rm -rf "$STAGE/skills/$n"; cp -R "$d" "$STAGE/skills/$n"
    done
done

# --- 2. Generate prompts and workflows from each SKILL.md ------------------------------
title() {   # s1-explore -> "1 Explore", tdd -> "Tdd"
    local n="$1"; [[ "$n" =~ ^s([0-9]+)-(.+)$ ]] && n="${BASH_REMATCH[1]} ${BASH_REMATCH[2]}"
    echo "$n" | sed 's/-/ /g' | awk '{for(i=1;i<=NF;i++) sub(/./,toupper(substr($i,1,1)),$i)}1'
}
for d in "$STAGE"/skills/*/; do
    n=$(basename "$d"); f="$d/SKILL.md"
    desc=$(sed -n 's/^description: *//p' "$f" | head -1)
    # body = after the frontmatter, minus the skill's own H1 and leading blank lines
    body=$(awk 'f==2{print} /^---$/{f++}' "$f" | awk '!s && /^# /{next} !s && !NF{next} {s=1;print}')
    printf '# %s\n\n> %s\n\n%s\n' "$(title "$n")" "$desc" "$body" > "$STAGE/prompts/$n.md"
    printf -- '---\ndescription: %s\n---\n\n# %s Workflow\n\n%s\n' "$desc" "$n" "$body" > "$STAGE/workflows/$n.md"
done

# --- 3. Deploy ----------------------------------------------------------------------
sync() {    # sync <src> <dst> — installs each entry of <src> into <dst>; removes only entries an earlier deploy installed
    echo "  -> $2"
    [ "$DRY" = true ] && return 0
    [ -L "$2" ] && rm "$2"
    mkdir -p "$2"
    local man="$2/.aps-managed" n e
    if [ -f "$man" ]; then
        while IFS= read -r n; do
            [[ "$n" =~ ^[A-Za-z0-9][A-Za-z0-9._-]*$ ]] || continue
            [ -e "$1/$n" ] || rm -rf "${2:?}/$n"
        done < "$man"
    fi
    for e in "$1"/*; do
        n=$(basename "$e")
        if [ -d "$e" ]; then rsync -a --delete "$e/" "$2/$n/"; else cp "$e" "$2/$n"; fi
    done
    ls -1 "$1" > "$man"
}
rules() {   # rules <file> — puts global-rules.md between markers in <file>, replacing any earlier copy
    echo "  -> $1 (rules)"
    [ "$DRY" = true ] && return 0
    local f="$1" b="<!-- agentic-problem-solving:rules start -->" e="<!-- agentic-problem-solving:rules end -->"
    mkdir -p "$(dirname "$f")"; touch "$f"
    awk -v b="$b" -v e="$e" '$0==b{s=1;next} $0==e{s=0;next} !s{a[++n]=$0}
        END{while(n>0&&a[n]=="")n--; for(i=1;i<=n;i++)print a[i]}' "$f" > "$f.tmp"
    { cat "$f.tmp"; [ -s "$f.tmp" ] && echo; echo "$b"; cat "$ROOT/global-rules.md"; echo "$e"; } > "$f"
    rm "$f.tmp"
}
deploy() {
    case $1 in
        claude)   sync "$STAGE/skills"    "$HOME/.claude/skills"
                  rules "$HOME/.claude/CLAUDE.md" ;;
        codex)    sync "$STAGE/prompts"   "$HOME/.codex/prompts"
                  sync "$STAGE/skills"    "$HOME/.codex/skills"
                  rules "$HOME/.codex/AGENTS.md" ;;
        cursor)   sync "$STAGE/prompts"   "$HOME/.cursor/commands" ;;
        windsurf) sync "$STAGE/workflows" "$HOME/.codeium/windsurf/global_workflows" ;;
    esac
}

[ "$DRY" = true ] && echo "[dry run]"
echo "Skills: $(ls -1 "$STAGE/skills" | tr '\n' ' ')"
if [ "$TARGET" = all ]; then for t in claude codex cursor windsurf; do deploy "$t"; done; else deploy "$TARGET"; fi
echo "Done."
