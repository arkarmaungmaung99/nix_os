#!/usr/bin/env bash

keyboard_name="at-translated-set-2-keyboard"

# Extract layout info for that specific keyboard block
layout_name=$(hyprctl devices | awk -v kb="$keyboard_name" '
  $0 ~ kb { in_kb=1 }
  in_kb && /active keymap/ { print $NF; exit }
')

# Clean up quotes/parentheses
layout_name=${layout_name//[\(\)\" ]/}

# Map to layout code
case "$layout_name" in
  Burmese) echo "mm" ;;
  US|English) echo "us" ;;
  *) echo "$layout_name" ;;
esac

