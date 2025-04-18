{ config, pkgs, lib, ...}:

{
  home.packages = with pkgs; [
    hyprlock
  ];

  programs.hyprlock = {
    enable = true;
    settings = {
	    # general = {
	    #   grace = 5;
	    #   no_fade_in = false;
	    # };

	    background = lib.mkForce [
	      {
		monitor = "";
		path = "/etc/nixos/wallpapers/wallpaper.jpg";
		blur_size = 5;
		blur_passes = 2;
	      }
	    ];

	      
	# LAYOUT
	# label = {
	#   monitor = "";
	#   # text = Layout: $LAYOUT;
	#   # color = $text;
	#   font_size = 25;
	#   # font_family = $font;
	#   position = "30, -30";
	#   halign = "left";
	#   valign = "top";
	# };
	#
	# TIME
	label = {
	  monitor = "";
	  text = "$TIME";
	  # color = $text;
	  font_size = 90;
	  # font_family = $font
	  position = "-30, 0";
	  halign = "right";
	  valign = "top";
	};
	#
	# DATE
	# label = {
	#   monitor = "";
	#   text = cmd[update:43200000] date +"%A, %d %B %Y";
	#   # color = $text;
	#   font_size = 25;
	#   # font_family = $font
	#   position = "-30, -150";
	#   halign = "right";
	#   valign = "top";
	# };
	# USER AVATAR
      image = {
	monitor = "";
	path = "/etc/nixos/profile.png";
	size = 150;
	# border_color = $accent
	position = "0, 75";
	halign = "center";
	valign = "center";
      };

      # INPUT FIELD
      input-field = {
	monitor = "";
	size = "300, 60";
	# outline_thickness = 4;
	dots_size = 0.2;
	dots_spacing = 0.2;
	dots_center = true;
	# outer_color = $accent
	# inner_color = $surface0
	# font_color = $text
	fade_on_empty = false;
	placeholder_text = "<span>hello, $USER</span>";
	hide_input = false;
	# check_color = $accent
	# fail_color = $red
	fail_text = "<i>$FAIL <b>($ATTEMPTS)</b></i>";
	# capslock_color = $yellow;
	position = "0, -47";
	halign = "center";
	valign = "center";
      };


    };
  };

}
