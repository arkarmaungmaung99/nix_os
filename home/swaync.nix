{ config, pkgs, inputs,  ... }:

{
  home.packages = with pkgs; [
    swaynotificationcenter
    inotify-tools
    libnotify

  ];

  services.swaync = {
    enable = true;
    settings = {
      positionX = "right";
      positionY = "bottom";
    };
    
    style = ''
        * {
        font-size: 16px;
      }
      .notification-content {
        padding: 15px;
        border-radius: 5px;
        margin: 5px;
      }

    '';
  };
}
