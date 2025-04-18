{ config, pkgs, ... }:

{
  home.packages = with pkgs; [
    git
    lazygit
  ];
 
  programs.git = {
    enable = true;
    userEmail = "arkarmaungmaung.asiamatrix@gmail.com";
    userName = "ArkarMaungMaung";
  };


}

