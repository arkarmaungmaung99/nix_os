#!/usr/bin/env bash

# Change to US keyboard layout before locking
# Cuz in log screen, u can't change it :)
hyprctl switchxkblayout at-translated-set-2-keyboard 0

# UPdate for waybar
pkill -RTMIN+8 waybar

# Finally lock it
hyprlock


