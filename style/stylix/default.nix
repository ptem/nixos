# style/stylix/default.nix
{
  pkgs,
  lib,
  isHM ? false,
  ...
}:

{
  imports = lib.optional isHM {
    stylix.targets.librewolf.enable = false;
  };

  stylix.enable = true;

  # To set a Tinted Theming color scheme: [accepts other files/formats supported by mkSchemeAttrs]
  stylix.base16Scheme = "${pkgs.base16-schemes}/share/themes/gruvbox-dark-hard.yaml";
  # Can override using stylix.override, anything that base16.nix accepts.

  stylix.image = ../assets/wallpaper-1.png;
  # if base16Scheme is undeclared, stylix will generate one from the wallpaper.

  stylix.polarity = "dark"; # dark/light

  stylix.fonts = {
    serif = {
      package = pkgs.ibm-plex;
      name = "IBM Plex Serif";
    };

    sansSerif = {
      package = pkgs.geist-font;
      name = "Geist";
    };

    monospace = {
      package = pkgs.ibm-plex;
      name = "IBM Plex Mono Text";
    };

    emoji = {
      package = pkgs.twitter-color-emoji;
      name = "Twitter Color Emoji";
    };
  };

  stylix.cursor = {
    package = pkgs.bibata-cursors;
    name = "Bibata-Modern-Ice";
    size = 32;
  };

  # Targets - anything which can have colors, fonts, or wallpaper applied.
  # for each target, stylix.targets.<<target>>.enable
  # By default, enabled whenever target is installed.

  # Global auto-target:
  stylix.autoEnable = true;
}
