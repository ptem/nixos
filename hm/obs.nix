{ config, pkgs, ... }:

{
  home.packages = with pkgs; [

    stable.obs-studio-plugins.obs-vkcapture
  ];

  programs.obs-studio = {
    enable = true;

    plugins = [
      pkgs.obs-studio-plugins.wlrobs
      pkgs.stable.obs-studio-plugins.obs-pipewire-audio-capture
      pkgs.stable.obs-studio-plugins.obs-vaapi
      pkgs.stable.obs-studio-plugins.obs-gstreamer
      pkgs.stable.obs-studio-plugins.obs-vkcapture
    ];

  };

}
