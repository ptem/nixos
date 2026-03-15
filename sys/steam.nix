# sys/steam.nix
{ pkgs, ... }:

{

  programs.steam = {
    enable = true;
    remotePlay.openFirewall = true;
    deedicatedServer.openFirewall = true;
    extraCompatPackages = with pkgs; [ proton-ge-bin ];
  };

}
