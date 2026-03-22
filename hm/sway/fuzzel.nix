# hm/sway/fuzzel.nix
{
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
    };

  };

}
