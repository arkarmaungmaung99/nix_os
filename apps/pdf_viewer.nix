{ config, pkgs, ... }:

{
   environment.systemPackages = with pkgs; [
      zathura
      kdePackages.okular
    ];
}
