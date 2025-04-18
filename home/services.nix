{config, pkgs, ...}:

{
  systemd.user.services.swww = {
    Unit.Description = "Run wallpaper daemon";
    Install.WantedBy = [ "default.target" ];
    Service = {
      Type = "oneshot";
      Environment = "PATH=/run/current-system/sw/bin:/etc/profiles/per-user/arkar/bin";
      ExecStart ="swww-daemon && sleep .4 && /run/current-system/sw/bin/sh /etc/nixos/scripts/wallpaper_change.sh";
    };
  };

  systemd.user.services.wallpaper-random = {
    Unit.Description = "Set a random wallpaper";
    Service = {
      Type = "oneshot";
      Environment = "PATH=/run/current-system/sw/bin:/etc/profiles/per-user/arkar/bin";
      ExecStart ="/run/current-system/sw/bin/sh /etc/nixos/scripts/wallpaper_change.sh";
    };
  };

  systemd.user.timers.wallpaper-random = {
    Unit.Description = "Run wallpaper randomizer every 3 minutes";
    Timer = {
      OnBootSec = "5sec";
      OnUnitActiveSec = "7sec";
      Persistent = true;
    };
    Install.WantedBy = [ "timers.target" ];  # This enables the timer at boot
  };
}
