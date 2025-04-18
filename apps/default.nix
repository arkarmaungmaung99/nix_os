{ config, pkgs, ... }:

{
  imports = [
	./browsers.nix
	./fileManager.nix
	# ./viber.nix
	./office_apps.nix
	./pdf_viewer.nix
	./shell.nix
  ];

}
