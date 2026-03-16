# hm/wallpapermanager.nix
{ config, pkgs, ... }:

# Wallpaper Engine kinda buggy and annoying on KDE Plasma.
# Keeping around just in case.
{
  services.linux-wallpaperengine =
    let
      enginePath = "/mnt/b/SteamLibrary/steamapps/workshop/content/431960/";
      wallpaperId = "2857321753";

      silent = true;
      fps = 30;
    in
    {
      enable = false;

      assetsPath = "/mnt/b/SteamLibrary/steamapps/common/wallpaper_engine/assets";
      wallpapers = [
        {
          monitor = "DP-1";
          wallpaperId = "${enginePath}${wallpaperId}";
          # scaling = "fill";
          # extraOptions = [ "--bg-color=FF00FF" ]
          audio = {
            silent = silent;
            automute = false;
            processing = false;
          };
        }
        {
          monitor = "DP-2";
          wallpaperId = "${enginePath}${wallpaperId}";
          # scaling = "fit"
        }
      ];
    };
}
