{ pkgs , ...}:

{
 environment.systemPackages = with pkgs; [
    libreoffice
    # onlyoffice-desktopeditors
  ];
}
