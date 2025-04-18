{ pkgs , config, ...}:

{
 environment.systemPackages = with pkgs; [
      zsh
      zsh-autosuggestions
      zsh-syntax-highlighting
      zsh-autocomplete
      zsh-powerlevel10k
      zsh-fzf-tab
      
      fzf
      zoxide
 ];
  programs.zsh = {
    enable = true;
    enableCompletion = true;
    enableBashCompletion = true;
    autosuggestions.enable = true;
    syntaxHighlighting.enable = true;
    histSize = 10000;
    shellAliases = {
      #...
    };
    # setOptions = [
    #   "AUTO_CD"
    # ]
    shellInit = ''

      # Set up fzf key bindings and fuzzy completion
      source <(fzf --zsh)

      eval "$(zoxide init zsh)"


      # Import colorscheme from 'wal' asynchronously
      # &   # Run the process in the background.
      # ( ) # Hide shell job control messages.
      (cat $XDG_CACHE_HOME/wal/sequences &)
    '';
    promptInit = ''
      source ${pkgs.zsh-powerlevel10k}/share/zsh-powerlevel10k/powerlevel10k.zsh-theme

    '';
    ohMyZsh = {
      enable = true;
      plugins = [ "git" "dirhistory" "history" ];
    };
  };
  users.defaultUserShell = pkgs.zsh;
  environment.shells = with pkgs; [ zsh ];
}
