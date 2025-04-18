{config, pkgs, inputs, ...}:


{
  home.packages = with pkgs; [
      rofi-wayland
      rofi-pass-wayland
      pass
  ];

  # programs.rofi = {
  #   enable = true;
  #   extraConfig = {
  #       modi = "drun";
  #       # icon-theme = "Oranchelo";
  #       # show-icons = true;
  #       # terminal = "ghostty";
  #       # drun-display-format = "{icon} {name}";
  #       location = 0;
  #       disable-history = false;
  #       # hide-scrollbar = true;
  #       display-drun = "   Apps ";
  #       display-run = "   Run ";
  #       # display-window = "󰍲   Window";
  #       # display-Network = " 󰤨  Network";
  #       # sidebar-mode = true;
  #     };
  #
  # };
  # programs.rofi.pass = {
  #   enable = true;
  # };
    home.file.".config/rofi-pass/config".text = ''
      # Set alternative password store dirs. Use ":" to separate multiple roots.
      # Can be switched at runtime with with corresponding hotkeys
      # ROOTS=/path/to/root_one:/path/to/root_two

      # You can define password store env vars here and they will be sourced in
      # the script and applied to all pass commands called. Like:
      # PASSWORD_STORE_CLIP_TIME=30
      # PASSWORD_STORE_GENERATED_LENGTH=13

      # Same way you can define other env vars that pass is using:
      # EDITOR='vim -x'
      # BROWSER= # default: xdg-open

      # Fields to be used
      URL_FIELD='url'
      USERNAME_FIELD='user'
      AUTOTYPE_FIELD='autotype'

      BACK_OPTION='← back'

      # delay to be used for :delay keyword
      delay=2
      # rofi-pass needs to close itself before it can type passwords. Set delay here.
      wait=0.2
      # delay between keypresses when typing (in ms)
      type_delay=12

      ## Options for generating new password entries
      # open new password entries in editor
      edit_new_pass="true"
      # set to ':basename' for user field to be set to password basename
      default_user="$(whoami)"
      default_user2=""

      ## Misc settings

      default_autotype="pass"
      auto_enter='true'
      notify='true'

      # default shortcuts
      help="Alt+h"

      kb_type_field="Alt+t"
      kb_type_pass="Alt+p"
      kb_type_user="Alt+n"
      kb_type_otp="Alt+o"
      kb_autotype="Alt+a"

      kb_copy_field="Alt+C"
      kb_copy_pass="Alt+P"
      kb_copy_user="Alt+N"
      kb_copy_otp="Alt+O"

      kb_insert="Alt+i"
      kb_show="Alt+Return"

      # Actions
      kb_move="Alt+m"
      kb_remove="Alt+x"
      kb_edit="Alt+e"
      kb_generate="Alt+I"

      kb_browse_url="Alt+U"
      kb_qrcode="Alt+q"
      kb_switch_root="Alt+bracketright" # ]

      # --- Customisable functions ---

      _rofi() { rofi -no-auto-select -i -dmenu "$@" -theme /etc/nixos/configs/simple-tokyonight.rasi; }

      _notify() { notify-send -e "rofi-pass" "$1"; }

      _generate_pass() { pass generate --clip --in-place "$@" > /dev/null; }

      _get_otp() { pass otp "$@"; }
    '';

}
