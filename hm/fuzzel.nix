# hm/fuzzel.nix
{
  config,
  pkgs,
  lib,
  ...
}:

{

  programs.fuzzel = {
    enable = true;
  };

  programs.fuzzel.settings = {
    main = {
      terminal = "${pkgs.kitty}/bin/kitty";
      layer = "overlay";
      icon-theme = "Adwaita";
    };

    colors =
      let
        colors = config.lib.stylix.colors;
      in
      {
        background = lib.mkForce "#${colors.base01}ff";
      };

  };

}
