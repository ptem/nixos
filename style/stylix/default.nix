# style/stylix/default.nix
{
  pkgs,
  lib,
  isHM ? false,
  ...
}:

{

  stylix.enable = true;

  # To set a Tinted Theming color scheme: [accepts other files/formats supported by mkSchemeAttrs]
  # stylix.base16Scheme = "${pkgs.base16-schemes}/share/themes/gruvbox-dark-hard.yaml";
  # Can override using stylix.override, anything that base16.nix accepts.

  stylix.image = ../assets/wallpaper-mack.jpg;
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

  # will default to base cursors if there's a fuckup here.
  # debug/runtime set: swaymsg seat "*" xcursor_theme catppuccin-mocha-green-cursors 24
  stylix.cursor = {
    package = pkgs.everforest-cursors;
    name = "everforest-cursors";
    size = 32;
  };

  stylix.opacity = {
    applications = 0.9;
    desktop = 0.8;
    popups = 0.8;
    terminal = 0.85;
  };

  # Targets - anything which can have colors, fonts, or wallpaper applied.
  # for each target, stylix.targets.<<target>>.enable
  # By default, enabled whenever target is installed.

  # Global auto-target:
  stylix.autoEnable = true;

  imports = lib.optional isHM {
    stylix.targets.librewolf.enable = false;

    stylix.targets.kitty = {
      enable = true;
    };

  };

}
