{config, pkgs, ...}:

{

  home.packages = with pkgs; [
    brightnessctl
  ];


 wayland.windowManager.hyprland = {
  enable = true;
  systemd.variables = ["--all"];

  settings = {
    source = "/home/arkar/var/cache/wal/colors-hyprland.conf";

    "$terminal" = "kitty";
    "$mod" = "SUPER";

    monitor = [
      # "eDP-1, 1920x1080, 0x0, 1"
      ", 1920x1080, 0x0, 1"
      "eDP-1, 1920x1080@60, 0x0, 1, mirror, HDMI-A-1"
    ];


    general = {
      gaps_in = 5;
      gaps_out = 15;
      border_size = 2;
      "col.active_border" = "$color1";
      layout = "dwindle";
      allow_tearing = true;
    };

    input = {
      kb_layout = "us,mm";
      follow_mouse = true;
      touchpad = {
        natural_scroll = true;
      };
      accel_profile = "flat";
      sensitivity = 0;
      # kb_options =  "grp:win_space_toggle";

    };

    decoration = {
      rounding = 15;
      active_opacity = .9;
      inactive_opacity = .9;
      fullscreen_opacity = .93;

      blur = {
        enabled = true;
        xray = true;
        special = false;
        new_optimizations = true;
        size = 20;
        passes = 4;
        brightness = 1;
        noise = 0.01;
        contrast = 1;
        popups = true;
        popups_ignorealpha = 0.6;
        ignore_opacity = false;
      };

    };

    animations = {
      enabled = true;
      bezier = [
        "linear, 0, 0, 1, 1"
        "md3_standard, 0.2, 0, 0, 1"
        "md3_decel, 0.05, 0.7, 0.1, 1"
        "md3_accel, 0.3, 0, 0.8, 0.15"
        "overshot, 0.05, 0.9, 0.1, 1.1"
        "crazyshot, 0.1, 1.5, 0.76, 0.92"
        "hyprnostretch, 0.05, 0.9, 0.1, 1.0"
        "menu_decel, 0.1, 1, 0, 1"
        "menu_accel, 0.38, 0.04, 1, 0.07"
        "easeInOutCirc, 0.85, 0, 0.15, 1"
        "easeOutCirc, 0, 0.55, 0.45, 1"
        "easeOutExpo, 0.16, 1, 0.3, 1"
        "softAcDecel, 0.26, 0.26, 0.15, 1"
        "md2, 0.4, 0, 0.2, 1"
      ];
      animation = [
        "windows, 1, 3, md3_decel, popin 60%"
        "windowsIn, 1, 3, md3_decel, popin 60%"
        "windowsOut, 1, 3, md3_accel, popin 60%"
        "border, 1, 10, default"
        "fade, 1, 3, md3_decel"
        "layersIn, 1, 3, menu_decel, slidevert"
        "layersOut, 1, 1.3, menu_accel"
        "fadeLayersIn, 1, 2, menu_decel"
        "fadeLayersOut, 1, 2.5, menu_accel"
        "workspaces, 1, 7, menu_decel, slidevert"
        "specialWorkspace, 1, 3, md3_decel, slidevert"
      ];
    };

    # cursor = {
    #   enable_hyprcursor = true;
    # };

    dwindle = {
      pseudotile = true;
      preserve_split = true;
      smart_split = false;
      smart_resizing = false;
    };

    misc = {
      disable_hyprland_logo = true;
      disable_splash_rendering = true;
    };
    #
    bindl = [
      # audio 
      ",XF86AudioRaiseVolume, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%+"
      ",XF86AudioLowerVolume, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"
      ",XF86AudioMute,        exec, wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"

      ",XF86MonBrightnessUp, exec, brightnessctl set 10%+"
      ",XF86MonBrightnessDown, exec, brightnessctl set 10%-"

    ];

    bind = [
      # General
      "$mod, return, exec, $terminal"
      "$mod, Tab, exec, tofi-run | xargs -r hyprctl dispatch exec "
      "$mod, q, killactive"

      "$mod, l, exec, /etc/nixos/scripts/hyprlock.sh"
      "$mod SHIFT, s, exec, /etc/nixos/scripts/screenshot.sh"
      "$mod SHIFT, r, exec, /etc/nixos/scripts/recorder.sh start"
      "$mod, ESCAPE, exec, /etc/nixos/scripts/power-menu.sh"
      "$mod, SPACE, exec, hyprctl switchxkblayout at-translated-set-2-keyboard next && pkill -RTMIN+8 waybar"
      "$mod SHIFT, b, exec, rofi -modi clipboard:/etc/nixos/scripts/clipboard.sh -show clipboard -show-icons -theme /etc/nixos/configs/launchpad.rasi"
      "$mod SHIFT, c, exec, /etc/nixos/scripts/hyprpicker.sh"
      "$mod SHIFT, o, exec, firefox --private-window"
      "$mod SHIFT, k, exec, google-chrome-stable --incognito"
      "$mod SHIFT, p, exec, rofi-pass"

      # Screen focus
      "$mod, f, fullscreen"

      # Screen resize
      # "$mod CTRL, h, resizeactive, -20 0"
      # "$mod CTRL, l, resizeactive, 20 0"
      # "$mod CTRL, k, resizeactive, 0 -20"
      # "$mod CTRL, j, resizeactive, 0 20"

      # Workspaces
      "$mod, 1, workspace, 1"
      "$mod, 2, workspace, 2"
      "$mod, 3, workspace, 3"
      "$mod, 4, workspace, 4"
      "$mod, 5, workspace, 5"
      "$mod, 6, workspace, 6"
      "$mod, 7, workspace, 7"
      "$mod, 8, workspace, 8"
      "$mod, 9, workspace, 9"
      "$mod, 0, workspace, 10"

      # Move to workspaces
      "$mod SHIFT, 1, movetoworkspace,1"
      "$mod SHIFT, 2, movetoworkspace,2"
      "$mod SHIFT, 3, movetoworkspace,3"
      "$mod SHIFT, 4, movetoworkspace,4"
      "$mod SHIFT, 5, movetoworkspace,5"
      "$mod SHIFT, 6, movetoworkspace,6"
      "$mod SHIFT, 7, movetoworkspace,7"
      "$mod SHIFT, 8, movetoworkspace,8"
      "$mod SHIFT, 9, movetoworkspace,9"
      "$mod SHIFT, 0, movetoworkspace,10"

      # Navigation
      "$mod, LEFT , movefocus, l"
      "$mod, RIGHT, movefocus, r"
      "$mod, UP, movefocus, u"
      "$mod, DOWN, movefocus, d"
    ];

    bindm = [
      # "$mod, mouse:272, movewindow"
      # "$mod, mouse:273, resizewindow"
    ];

    env = [
      "NIXOS_OZONE_WL,1"
      "_JAVA_AWT_WM_NONREPARENTING,1"
      "QT_WAYLAND_DISABLE_WINDOWDECORATION,1"
      "QT_QPA_PLATFORM,wayland"
      "SDL_VIDEODRIVER,wayland"
      "GDK_BACKEND,wayland"
      "XDG_SESSION_TYPE,wayland"
      "XDG_SESSION_DESKTOP,Hyprland"
      "XDG_CURRENT_DESKTOP,Hyprland"
      "XCURSOR_THEME,Bibata-Modern-Ice"
      "XCURSOR_SIZE,24"
    ];

    exec-once = [
      "dbus-update-activation-environment --systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP &"
      "waybar &"
      "hypridle &"
      "wl-paste --watch cliphist store &"
      "swww init"
    ];
  };
   };
 
}
