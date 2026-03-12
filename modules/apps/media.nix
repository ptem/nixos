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

      # images   
      qview
    ];

    # simple video player
    programs.mpv = {
      enable = true;
      defaultProfiles = ["high-quality"];
      scripts = [ pkgs.mpvScripts.mpris ];

      config = {
        vo = "gpu-next";
        # gpu-context = "kitty"; # for ghostty
        # gpu-api = "opengl";
      };
    };
  };
}
