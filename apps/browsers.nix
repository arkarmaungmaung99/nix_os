{ pkgs , ...}:

{
 environment.systemPackages = with pkgs; [
  firefox
  # vivaldi
  google-chrome
 ];
}
