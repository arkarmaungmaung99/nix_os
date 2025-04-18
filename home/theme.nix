
{ config, pkgs, lib,  ... }:

{
  home.packages = with pkgs; [
      tokyonight-gtk-theme
      adwaita-icon-theme
      bibata-cursors

  ];
  gtk = {
      enable = true;
      gtk3.extraConfig.gtk-decoration-layout = "menu:";
      theme = {
        name = lib.mkForce "Tokyonight-Dark";
        package = lib.mkForce pkgs.tokyo-night-gtk;
      };
      iconTheme = {
        name = lib.mkForce "Tokyonight-Dark";
      };
      cursorTheme = {
        name = "Bibata-Modern-Ice";
        package = pkgs.bibata-cursors;
    };

  };

  home.sessionVariables = {
    GTK_THEME = "Tokyonight-Dark";
  };

}
