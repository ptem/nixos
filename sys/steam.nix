# sys/steam.nix
{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    gamescope
    mangohud
  ];

  # Steam requires system-level installation for reasons
  programs.steam = {
    enable = true;
    remotePlay.openFirewall = true;
    dedicatedServer.openFirewall = true;
    extraCompatPackages = with pkgs; [ proton-ge-bin ];

    gamescopeSession = {
      enable = true;

      args = [ "mangoapp" ];
    };

    package = pkgs.steam.override {
      extraPkgs =
        pkgs: with pkgs; [
          libkrb5
          keyutils
        ];
    };
  };
}
