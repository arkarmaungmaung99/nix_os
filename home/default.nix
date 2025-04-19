{ config, pkgs, ... }:

{

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  # Global configurations for Home Manager
  home.username = "arkar";
  home.homeDirectory = "/home/arkar";

  # Import other configurations
  imports = [

    # ./stylix.nix
    ./pywal.nix
    ./terminal.nix
    ./theme.nix

    ./swaync.nix

    # Hyprland stuffs
    ./hyprland.nix
    ./hyprlock.nix
    ./hypridle.nix

    ./git.nix
    ./nixvim.nix

    ./waybar.nix
    ./tofi.nix
    ./rofi.nix
    ./swappy.nix

    ./services.nix
  ];

  services.gpg-agent = {
    enable = true;
    pinentryPackage = pkgs.pinentry-gnome3;
  };

  # The state version is required and should stay at the version you
  # originally installed.

  home.stateVersion = "24.11";

}
