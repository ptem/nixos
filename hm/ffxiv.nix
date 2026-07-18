# hm/ffxiv.nix
{ pkgs, ... }:

{

  home.packages = with pkgs; [
    xivlauncher
    archon-lite

  ];

  xdg.desktopEntries = {
    archon-lite = {
      name = "Archon Lite";
      comment = "Uploads ffxiv logs to fflogs";
      exec = "${pkgs.archon-lite}/bin/archon-lite";
      icon = "document-send"; # TODO: default icon stuff for everything
      terminal = false;
      categories = [ "Game" ]; # see https://specifications.freedesktop.org/menu/latest/

      settings = {
        Keywords = "ff;fflogs;archon;";
      };
    };
  };

}
