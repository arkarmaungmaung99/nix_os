
{ config, pkgs, lib, ...}:

{
  home.packages = with pkgs; [
      hyprshot
      swappy  ## Image editor / viewer
    ];


   home.file.".config/swappy/config".text = ''
      [Default]
      save_dir=$HOME/Pictures
      save_filename_format=swappy-%Y-%m-%d-%H-%M-%S.png
      show_panel=true
      early_exit=true
  '';

  home.sessionVariables = {
    HYPRSHOT_DIR = "$HOME/Pictures";
  };

}
