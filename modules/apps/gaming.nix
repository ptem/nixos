# modules/apps/gaming.nix
{ pkgs, config, ... }:

{
  # graphics & wine compat
  hardware.graphics = {
    enable = true;
    enable32Bit = true;
    extraPackages = with pkgs; [
      libva-vdpau-driver
      libvdpau-va-gl
    ];
  };
  
  programs.nix-ld.enable = true;

  # steam as system service
  programs.steam = {
    enable = true;
    remotePlay.openFirewall = true;
    dedicatedServer.openFirewall = true;
    extraCompatPackages = with pkgs; [ proton-ge-bin ];
  };

  # user apps
  home = {
    home.packages = with pkgs; [
      stable.xivlauncher
      gajim
      teamspeak6-client
    ];
  };
}
