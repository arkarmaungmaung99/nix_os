{ config, pkgs, inputs,  ... }:

{
  imports = [
    inputs.stylix.homeManagerModules.stylix
  ];

  home.packages = with pkgs; [
      adwaita-icon-theme
      bibata-cursors

  ];

  stylix = {
      enable = true;
      autoEnable = false;
      polarity = "dark";

      opacity = {
	popups = .9;
	terminal = .9;
	desktop = .9;

      };

      # image = ../wallpapers/wallpaper.jpg;
    };

}
