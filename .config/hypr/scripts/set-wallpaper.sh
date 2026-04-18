#!/usr/bin/env bash
# set-wallpaper.sh — set wallpaper with awww and regenerate Matugen colours

WALLPAPER_DIR="$HOME/Pictures/Wallpapers"
CURRENT_LINK="$HOME/.config/hypr/current_wallpaper"
LOG="$HOME/.cache/set-wallpaper.log"

exec > "$LOG" 2>&1
echo "=== $(date) ==="

# ── Resolve wallpaper path ────────────────────────────────────────────────────
if [[ $# -gt 0 && -f "$1" ]]; then
    WALLPAPER="$1"
else
    WALLPAPER=$(~/.config/hypr/scripts/wallpaper-picker.sh)
fi

[[ -z "${WALLPAPER:-}" ]] && { echo "No wallpaper selected"; exit 0; }
[[ ! -f "$WALLPAPER" ]] && { echo "ERROR: file not found: $WALLPAPER"; exit 1; }

echo "Wallpaper: $WALLPAPER"

# ── Ensure awww-daemon is running ─────────────────────────────────────────────
if ! pgrep -x awww-daemon >/dev/null 2>&1; then
    awww-daemon & sleep 1
fi

# ── Apply via awww ────────────────────────────────────────────────────────────
awww img "$WALLPAPER" \
    --transition-type fade \
    --transition-duration 1.5 \
    --transition-fps 60
echo "awww: $?"

# ── Update the symlink used by hyprlock ───────────────────────────────────────
ln -sf "$WALLPAPER" "$CURRENT_LINK"

# ── Extract dominant colour ───────────────────────────────────────────────────
SOURCE_COLOR=$(magick "$WALLPAPER" \
    -resize 150x150! \
    -format "%c" histogram:info:- \
    | sort -rn \
    | head -1 \
    | grep -oE '#[0-9A-Fa-f]{6}' \
    | head -1)

if [[ -z "$SOURCE_COLOR" ]]; then
    HEX=$(magick "$WALLPAPER" -resize 1x1! -format "%[hex:u]" info:)
    SOURCE_COLOR="#${HEX:0:6}"
fi

echo "Source color: $SOURCE_COLOR"

# ── Regenerate colour scheme via Matugen ─────────────────────────────────────
matugen -m dark color hex "$SOURCE_COLOR"
echo "matugen: $?"

# ── Restart waybar to pick up new colours ────────────────────────────────────
echo "Restarting waybar..."
nohup ~/.config/hypr/scripts/restart-waybar.sh >/dev/null 2>&1 &

echo "Done"
