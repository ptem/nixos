# hm/gaming.nix
{ pkgs, config, ... }:

{

  home.packages = with pkgs; [
    xivlauncher
    fflogs

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

}
