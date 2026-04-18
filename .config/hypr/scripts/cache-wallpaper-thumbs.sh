#!/usr/bin/env bash
# cache-wallpaper-thumbs.sh — pre-generate wallpaper thumbnails at login
# Run via exec-once in hyprland.conf so picker opens instantly

WALLPAPER_DIR="$HOME/Pictures/Wallpapers"
CACHE_DIR="$HOME/.cache/wallpaper-thumbnails"
mkdir -p "$CACHE_DIR"

while IFS= read -r -d '' file; do
    filename=$(basename "$file")
    thumb="$CACHE_DIR/$filename.thumb.png"
    if [[ ! -f "$thumb" || "$file" -nt "$thumb" ]]; then
        magick "$file" -resize 150x90^ -gravity center -extent 150x90 \
            -quality 60 "$thumb" 2>/dev/null
    fi
done < <(find "$WALLPAPER_DIR" -type f \( -iname "*.jpg" -o -iname "*.jpeg" \
    -o -iname "*.png" -o -iname "*.webp" \) -print0)
