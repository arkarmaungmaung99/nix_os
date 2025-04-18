#!/bin/bash

# === Settings ===
wall_dir="/etc/nixos/wallpapers"           # Folder with wallpapers
central_path="$wall_dir/wallpaper.jpg"      # Centralized wallpaper file

# === Pick a random wallpaper ===
new_wall=$(find "$wall_dir" -type f \( -iname '*.jpg' -o -iname '*.png' -o -iname '*.jpeg' \) | shuf -n 1)

# Exit if no wallpaper found
[ -z "$new_wall" ] && echo "No wallpaper found!" && exit 1

# === Backup current wallpaper if it exists ===
if [ -f "$central_path" ]; then
    timestamp=$(date '+%Y-%m-%d_%H-%M-%S')
    ext="${central_path##*.}"
    old_name="${central_path%.*}"
    mv "$central_path" "${old_name}_$timestamp.$ext"
fi

# === Copy new wallpaper to central path ===
mv "$new_wall" "$central_path"
# rm -rf "$new_wall"

# === Generate pywal theme ===
wal -i "$central_path"
swww img "$central_path"
