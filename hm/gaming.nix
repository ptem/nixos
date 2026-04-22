# hm/gaming.nix
{ pkgs, config, ... }:

{

  # TODO: xiv symlinking.
  home.packages = with pkgs; [
    stable.xivlauncher

    r2modman

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
