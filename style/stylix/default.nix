# style/stylix/default.nix
{
  pkgs,
  lib,
  isHM ? false,
  ...
}:

let
  # theme = "catppuccin-macchiato";
  theme = "everforest-dark-hard";
  # theme = "darkmoss";
in
{

  stylix.enable = true;

  # To set a Tinted Theming color scheme: [accepts other files/formats supported by mkSchemeAttrs]
  stylix.base16Scheme = "${pkgs.base16-schemes}/share/themes/${theme}.yaml";
  # Can override using stylix.override, anything that base16.nix accepts.

  stylix.image = ../assets/wallpaper-lauripoldre-pine.jpg;
  # if base16Scheme is undeclared, stylix will generate one from the wallpaper.

  stylix.polarity = "dark"; # dark/light

  stylix.fonts = {
    serif = {
      package = pkgs.roboto-serif;
      name = "Roboto Serif";
    };

    sansSerif = {
      package = pkgs.roboto;
      name = "Roboto";
    };

    monospace = {
      package = pkgs.jetbrains-mono;
      name = "JetBrains Mono";
    };

    emoji = {
      package = pkgs.twitter-color-emoji;
      name = "Twitter Color Emoji";
    };
  };

  stylix.opacity = {
    applications = 1.0;
    desktop = 1.0;
    popups = 1.0;
    terminal = 1.0;
  };

  # Targets - anything which can have colors, fonts, or wallpaper applied.
  # for each target, stylix.targets.<<target>>.enable
  # By default, enabled whenever target is installed.

  # Global auto-target:
  stylix.autoEnable = true;

  imports = lib.optional isHM {

    stylix.targets.kitty = {
      enable = true;
    };

    stylix.targets.firefox.enable = false;

    stylix.targets.gtk.extraCss = ''
      window.background {
        border-radius: 0;
      }

      decoration {
        border-radius: 0;
      }
    '';

  };

}
