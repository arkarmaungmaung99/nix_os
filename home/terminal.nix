{ config, pkgs , lib, ...}:

{

  programs.kitty = {
    enable = true;
    settings = {
      # confirm_os_window_close = 0;
      dynamic_background_opacity = true;
      window_padding_width = "10 15";
      background_opacity = lib.mkForce "0.9";
      background_blur = 15;
      font_size = 12.6;
      adjust_line_height = 7;
      adjust_column_width = 0;
      cursor_shape = "beam";
      cursor_blink_interval  = "0.5 ease-in-out";
      cursor_trail = 2;
      cursor_trail_decay = "0.1 0.4";
      cursor_trail_start_threshold = 3;

    };
  };




}
