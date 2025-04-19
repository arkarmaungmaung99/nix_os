{ pkgs , ...}:

{
  environment.systemPackages = with pkgs; [
    zsh
    zsh-powerlevel10k
    zsh-vi-mode
    zsh-fzf-tab
    zoxide
    fzf
  ];
  programs.zsh = {
    enable = true;
    enableCompletion = true;
    enableBashCompletion = true;
    autosuggestions.enable = true;
    syntaxHighlighting.enable = true;
    histSize = 10000;
    shellInit = ''
        (cat $XDG_CACHE_HOME/wal/sequences &)

	eval "$(zoxide init zsh)"
    '';
    interactiveShellInit = ''
      source ${pkgs.zsh-vi-mode}/share/zsh-vi-mode/zsh-vi-mode.zsh
      source ${pkgs.zsh-fzf-tab}/share/fzf-tab/fzf-tab.plugin.zsh
    '';
    promptInit = ''
      # this act as your ~/.zshrc but for all users (/etc/zshrc)
      source ${pkgs.zsh-powerlevel10k}/share/zsh-powerlevel10k/powerlevel10k.zsh-theme

      # uncomment if you want to customize your LS_COLORS
      # https://manpages.ubuntu.com/manpages/plucky/en/man5/dir_colors.5.html
      #LS_COLORS='...'
      #export LS_COLORS


    '';
  };

  programs.fzf = {
    fuzzyCompletion = true;
    keybindings = true;
  };
  users.defaultUserShell = pkgs.zsh;
  system.userActivationScripts.zshrc = "touch .zshrc"; # to avoid being prompted to generate the config for first time
  environment.loginShellInit = ''
    # equivalent to .profile
    # https://search.nixos.org/options?show=environment.loginShellInit
  '';
}
