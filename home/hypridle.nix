{ config, pkgs, lib, ...}:

{
   home.file.".config/hypr/hypridle.conf".text = ''
	general {
	  lock_cmd = pidof hyprlock || hyprlock       # avoid starting multiple hyprlock instances.
	  before_sleep_cmd = loginctl lock-session    # lock before suspend.
	  after_sleep_cmd = hyprctl dispatch dpms on  # to avoid having to press a key twice to turn on the display.
      }

      listener {
	  timeout = 30                               
	  on-timeout = brightnessctl -s set 10         # set monitor backlight to minimum, avoid 0 on OLED monitor.
	  on-resume = brightnessctl -r                 # monitor backlight restore.
      }

      # turn off keyboard backlight, comment out this section if you dont have a keyboard backlight.
      listener { 
	  timeout = 45                                         
	  on-timeout = /etc/nixos/scripts/hyprlock.sh
      }

      listener {
	  timeout = 60
	  on-timeout = hyprctl dispatch dpms off
	  on-resume = hyprctl dispatch dpms on  && brightnessctl -r 
      }


      listener {
	  timeout = 80                               
	  on-timeout = systemctl suspend                # suspend pc
      }
  '';
}
