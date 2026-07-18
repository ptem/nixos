# hm/minecraft.nix
{ pkgs, ... }:

{
  home.packages = with pkgs; [
    (prismlauncher.override {

      jdks = [
        zulu25
        javaPackages.compiler.temurin-bin.jre-25
        javaPackages.compiler.temurin-bin.jre-8
        jre8
      ];

    })

  ];
}
