{
  pkgs,
  config,
  ...
}:
{
  # imports = [ ];

  home.packages = with pkgs; [
    # Video Player
    # -- mpv, defined below

    # Audio Control
    pulsemixer

    # Images
    imv

  ];


  programs = {
    mpv = {
      enable = true;
      defaultProfiles = ["high-quality"];
      scripts = [pkgs.mpvScripts.mpris];
    };


    # (pkgs.wrapOBS {
    #   plugins = with pkgs.obs-studio-plugins; [
    #     obs-vkcapture
    #   ];
    # })
  };

  services = {
    # playerctld.enable = true;
    
    
  };

}
