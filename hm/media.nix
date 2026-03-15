# hm/media.nix
{ pkgs, ... }:

{
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
    defaultProfiles = [ "high-quality" ];
    scripts = [ pkgs.mpvScripts.mpris ];

    config = {
      vo = "gpu-next";
    };
  };
}
