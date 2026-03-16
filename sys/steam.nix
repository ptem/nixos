# sys/steam.nix
{ pkgs, ... }:

{
  # Steam requires system-level installation for reasons
  programs.steam = {
    enable = true;
    remotePlay.openFirewall = true;
    dedicatedServer.openFirewall = true;
    extraCompatPackages = with pkgs; [ proton-ge-bin ];
  };
}
