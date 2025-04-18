#!/usr/bin/env bash

SAVE_DIR="$HOME/Pictures"
FILENAME="screenshot_$(date +%s).png"

# Run hyprshot and send image to swappy
hyprshot -m region -r - | swappy -f - &

# Watch for file creation in SAVE_DIR
inotifywait -e close_write --format '%f' "$SAVE_DIR" | while read file; do
    notify-send "System" "Screenshot saved: $file"
    break
done

