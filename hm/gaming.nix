# hm/gaming.nix
{ pkgs, config, ... }:

{

  home.packages = with pkgs; [
    xivlauncher
    archon-lite

    stable.r2modman

    # listen up emma
    (prismlauncher.override {
      # additionalPrograms = [ ffmpeg ];

      # Java runtimes
      jdks = [
        zulu25
        javaPackages.compiler.temurin-bin.jre-25
        javaPackages.compiler.temurin-bin.jre-8
        jre8
      ];

    })

  ];

  # Fuzzel stuff
  xdg.desktopEntries = {
    archon-lite = {
      name = "Archon Lite";
      genericName = "Combat Log Uploader";
      comment = "Uploads combat logs to FFLogs";
      exec = "${pkgs.archon-lite}/bin/archon-lite";
      icon = "application-games";
      terminal = false;
      categories = [ "Game" ];

      settings = {
        Keywords = "ff;fflogs;archon;";
      };
    };
  };

}
