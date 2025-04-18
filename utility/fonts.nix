{ config, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
      meslo-lgs-nf
  ];

  fonts.fontDir.enable = true;
  fonts.fontconfig.enable = true;
  fonts.packages = with pkgs; [
    (pkgs.stdenv.mkDerivation {
      pname = "Custom Fonts";
      version = "1.0";
      src = ../fonts;

      installPhase = ''
	mkdir -p $out/share/fonts/truetype
	cp *.ttf $out/share/fonts/truetype/
      '';
    })
  ];

  fonts.fontconfig.defaultFonts = {
	serif = [  "0xProto" "Meslo" "Pyidaungsu"];
	sansSerif = [ "0xProto" "Meslo" "Pyidaungsu" ];
	monospace = [ "0xProto" "Meslo" "Pyidaungsu" ];
  };
}
