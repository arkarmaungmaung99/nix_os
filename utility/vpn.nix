{ config, pkgs, ... }:

{
 	environment.systemPackages = with pkgs; [
		update-resolv-conf
		openvpn
	];
	
	environment.etc.openvpn.source = "${pkgs.update-resolv-conf}/libexec/openvpn";
}
