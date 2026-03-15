# hm/gaming.nix
{ pkgs, config, ... }:

{

  # TODO: figure this shit out these are like social things minus xiv so idk. xiv probably deserves its own for the symlinking.
  home.packages = with pkgs; [
    stable.xivlauncher
    gajim
    teamspeak6-client
  ];

}
