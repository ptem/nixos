# hm/gaming.nix
{ pkgs, config, ... }:

{

  # TODO: xiv symlinking.
  home.packages = with pkgs; [
    stable.xivlauncher

  ];

}
