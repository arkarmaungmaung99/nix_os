{ config, pkgs, ... }:

{
   environment.systemPackages = with pkgs; [
     # xfce.thunar
     nautilus

      # Terminal File Managers
     superfile
   ];
}
