#!/usr/bin/env bash

## Author : Aditya Shakya (adi1090x)
## Github : @adi1090x
#
## Rofi   : Power Menu
#
## Available Styles
#
## style-1   style-2   style-3   style-4   style-5
## style-6   style-7   style-8   style-9   style-10

# Current Theme
dir="$HOME/.config/rofi/powermenu/type-2"
theme='style-1'

# CMDs
uptime="`uptime  | sed -e 's/up //g'`"
host=`hostname`

# Options
shutdown='⏻'
reboot=''
suspend='⏼'
yes=''
no=''

# Rofi CMD
rofi_cmd() {
	rofi -dmenu \
		-p "Uptime: $uptime" \
		-mesg "Uptime: $uptime" \
		-theme /etc/nixos/configs/launchpad-power-menu.rasi
}

# Confirmation CMD
confirm_cmd() {
	rofi -theme-str 'window {location: center; anchor: center; fullscreen: false; width: 350px;}' \
		-theme-str 'mainbox {children: [ "message", "listview" ];}' \
		-theme-str 'listview {columns: 2; lines: 1;}' \
		-theme-str 'element-text {horizontal-align: 0.5;}' \
		-theme-str 'textbox {horizontal-align: 0.5;}' \
		-dmenu \
		-p 'Confirmation' \
		-mesg 'Are you Sure?' \
		-theme /etc/nixos/configs/launchpad-power-menu.rasi
}

# Ask for confirmation
confirm_exit() {
	echo -e "$yes\n$no" | confirm_cmd
}

# Pass variables to rofi dmenu
run_rofi() {
	echo -e "$reboot\n$shutdown\n$suspend" | rofi_cmd
}

# Execute Command
run_cmd() {
    case "$1" in
        --suspend)
            mpc -q pause 2>/dev/null
            amixer set Master mute
            systemctl suspend
            ;;
        *)
            selected="$(confirm_exit)"
            if [[ "$selected" == "$yes" ]]; then
                case "$1" in
                    --shutdown)
                        systemctl poweroff
                        ;;
                    --reboot)
                        systemctl reboot
                        ;;
                    --logout)
                        hyprctl dispatch exit
                        ;;
                esac
            else
                exit 0
            fi
            ;;
    esac
}
# Actions
chosen="$(run_rofi)"
case ${chosen} in
    $shutdown)
		run_cmd --shutdown
        ;;
    $reboot)
		run_cmd --reboot
        ;;
    $suspend)
		run_cmd --suspend
        ;;
esac
