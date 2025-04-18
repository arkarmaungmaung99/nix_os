{ config, pkgs, ... }:

{
  imports = [
	./fonts.nix
	./vpn.nix
  ];

  environment.systemPackages = with pkgs; [
      swww   # For Background Wallpaper

      wf-recorder

      wl-clipboard
      cliphist

      gnumake
      gcc
      clang

      hyprpicker
      zenity  ## For GTK input popup box

      gnupg
      gcr

      imagemagick

  ];


  # Prevent powerkey closing OS when click
  services.logind = {
    powerKey = "suspend";
  };

  #  execute a script without needing enter SUDO password

}
