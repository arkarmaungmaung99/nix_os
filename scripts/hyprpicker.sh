#!/usr/bin/env bash

ICON_DIR="/tmp/color_previews"
mkdir -p "$ICON_DIR"

# Get current animation setting
current_anim=$(hyprctl getoption animations:enabled | grep -Po "(?<=int: )\d")

# Disable animations
hyprctl --batch "keyword animations:enabled false"
sleep 0.05

# Run hyprpicker
color=$(hyprpicker -a -f hex)

# Restore animations
[[ "$current_anim" == "1" ]] && hyprctl --batch "keyword animations:enabled true"

# No color picked
if [[ -z "$color" ]]; then
    notify-send "Color Picker" "No color selected"
    exit 0
fi

# Generate icon
icon_path="$ICON_DIR/${color//\#/}.png"
magick -size 100x100 xc:none -fill "$color" -draw "circle 50,50 50,1" "$icon_path"

# Send notification
notify-send -i "$icon_path" "Color Copied" "$color"

