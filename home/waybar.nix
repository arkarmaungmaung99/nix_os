{ config, pkgs, inputs, lib,  ... }:

{
  home.packages = with pkgs; [
    waybar
  ];

  programs.waybar = {
    enable = true;
    style = lib.mkAfter ''
      @import "/home/arkar/var/cache/wal/colors-waybar.css";

      window#waybar {
        border-radius: 15px;
        box-shadow: 0 0 5px 2px rgba(255, 255, 255, 0.3); /* soft white glow */
        box-shadow: 2px 2px 10px rgba(0, 0, 0, 0.6);       /* subtle black shadow */
	background-color: @background;

      }

      * {
        border-radius: 10px;
      }

      #workspaces {
        margin: 7px 2px;
        border-radius: 0px;
      }

      #custom-keyboard , #workspaces button, #battery , #network, #clock, #privacy, #wireplumber, #custom-current_date {
        background-color: rgba(255, 255, 255, .05);
	color: @foreground;
      }

      #clock {
            background-color: rgba(255, 255, 255, .07);
      }

      #custom-keyboard, #battery , #network, #clock , #tray, #privacy, #wireplumber, #custom-current_date{
        margin: 4px 6px;
        padding: 6px 3px;
	color: @foreground;

      }

      #custom-current_date {
	padding: 10px 3px;
        background-color: transparent;
	color: @color5;
      }
  
      #network.ethernet , #network.wifi {
	color: @color4;
      }
       #workspaces button {
        margin: 0px 5px;
        padding: 5px;
        background-color: transparent;
       }

      #workspaces button.active , #workspaces button.focused {
	   border-bottom: 0px solid transparent;
       }
      
      #wireplumber.muted , #battery.critical ,  #workspaces button.urgent, #pulseaudio.muted #pulseaudio.source-muted, #network.disconnected, #network.disabled, #custom-recorder    {
        color: red;
      }
      #battery.warning {
        color: yellow;
      }
      #workspaces button.visible {
        background-color: rgba(255, 255, 255, .1);
        color: @color1;
      }
    '';
    settings = [{
      # height = 100;
      reload_style_on_change = true;
      width= 60;
      layer = "bottom";
      position = "right";
      margin = "10 10 10 10";
      # spacing = 15;
      tray = { spacing = 10; };
      modules-left = ["hyprland/workspaces"];
      modules-center = [  ];
      modules-right = [
        "tray"
        "custom/recorder"
        "privacy"
        "custom/keyboard"
        "network"
        "wireplumber"
        "battery"
        "clock"
	"custom/current_date"
      ];
    "hyprland/workspaces" = {
      # "persistent-workspaces" = {
      #         "*" = 5;
      #   };
  };

"wireplumber" = {
    "format" = "<span size = '10000' weight = 'bold'>{volume}</span> \n {icon}";
    "format-muted" = "";
    "format-icons" = ["󰕿"  "󰖀"  "󱄡"];
    "max-volume" = "0.5";
};
  "custom/recorder" = {
    "exec" = "/etc/nixos/scripts/recorder.sh status";
    "interval" = 1;
    "format" = "{}";
  };
  "privacy" = {
	  "icon-spacing" = 4;
	  "icon-size" = 18;
	  "transition-duration" = 250;
	  "modules" = [
		  {
			  "type" = "screenshare";
			  "tooltip" = true;
			  "tooltip-icon-size" = 24;
		  }
		  {
			  "type" = "audio-out";
			  "tooltip" = true;
			  "tooltip-icon-size" = 24;
		  }
		  {
			  "type" = "audio-in";
			  "tooltip" = true;
			  "tooltip-icon-size" = 24;
		  }
	  ];
  };
  "custom/keyboard" = {
    "exec" = "/etc/nixos/scripts/kb_layout.sh";
    "format" = "{}";
    "signal" = 8;
    "return-type" = "plain";
  };
  "custom/current_date" = {
    "exec" = "sh /etc/nixos/scripts/current_date.sh";
    "format" = "<span size = '13000' weight = 'bold'>{}</span>";
    interval = 360;
    rotate = 90;
  };
      battery = {
        format = "<span size = '10000' weight = 'bold'>{capacity}</span> \n ";
        format-alt = "{time}";
        format-charging = "<span size = '10000' weight = 'bold'>{capacity}</span> \n ";
        format-plugged = "<span size = '10000' weight = 'bold'>{capacity}</span> \n ";
        format-full = "<span size = '10000' weight = 'bold'>Full</span> \n ";
        states = {
          critical = 15;
          warning = 30;
        };
        interval = 1;
      };
      clock = {
        format = "<span weight = 'bold' size = '13000'>{:%H\n%M}</span>";
      };
      network = {
        interval = 1;
        # format-alt = "{ifname}";
        format-disconnected = "";
        format-ethernet = "󰈁";
        format-linked = "󱛆";
        format-wifi = "";
        tooltip-format = "{essid}";
      };
    }];
  };

}
