#!/usr/bin/env bash
# wallpaper-picker.sh — rofi wallpaper picker with cached image previews

WALLPAPER_DIR="$HOME/Pictures/Wallpapers"
CACHE_DIR="$HOME/.cache/wallpaper-thumbnails"
mkdir -p "$CACHE_DIR"

# ── Pre-generate any missing thumbnails quickly ───────────────────────────────
# Uses smaller size and lower quality for speed
while IFS= read -r -d '' file; do
    filename=$(basename "$file")
    thumb="$CACHE_DIR/$filename.thumb.png"
    if [[ ! -f "$thumb" || "$file" -nt "$thumb" ]]; then
        magick "$file" -resize 150x90^ -gravity center -extent 150x90 \
            -quality 60 "$thumb" 2>/dev/null &
    fi
done < <(find "$WALLPAPER_DIR" -type f \( -iname "*.jpg" -o -iname "*.jpeg" \
    -o -iname "*.png" -o -iname "*.webp" \) -print0)

# Wait for thumbnail generation (only new ones, cached ones skip)
wait

# ── Build rofi entries ────────────────────────────────────────────────────────
entries=""
while IFS= read -r -d '' file; do
    filename=$(basename "$file")
    thumb="$CACHE_DIR/$filename.thumb.png"
    if [[ -f "$thumb" ]]; then
        entries+="$filename\0icon\x1f$thumb\n"
    else
        entries+="$filename\n"
    fi
done < <(find "$WALLPAPER_DIR" -type f \( -iname "*.jpg" -o -iname "*.jpeg" \
    -o -iname "*.png" -o -iname "*.webp" \) -print0 | sort -z)

# ── Show rofi ─────────────────────────────────────────────────────────────────
SELECTED=$(printf "%b" "$entries" | rofi \
    -dmenu \
    -p " Wallpaper" \
    -theme ~/.config/rofi/themes/wallpaper.rasi \
    -show-icons \
    -i)

[[ -z "$SELECTED" ]] && exit 0

echo "$WALLPAPER_DIR/$SELECTED"
