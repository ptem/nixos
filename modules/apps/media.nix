# modules/apps/media.nix
{ pkgs, ... }:

{
  # home manager user configuration
  home = {
    home.packages = with pkgs; [

      # consume the content 
      feishin
      streamlink
      nicotine-plus
      
      # audio control
      pulsemixer

      # images / manip
      imv
    ];

    # simple video player
    programs.mpv = {
      enable = true;
      defaultProfiles = ["high-quality"];
      scripts = [ pkgs.mpvScripts.mpris ];
    };
  };
}
