# sys/stylix/default.nix
{ pkgs, ... }:

{
  stylix.enable = true;

  # To set a Tinted Theming color scheme: [accepts other files/formats supported by mkSchemeAttrs]
  stylix.base16Scheme = "${pkgs.base16-schemes}/share/themes/gruvbox-dark-hard.yaml";
  # Can override using stylix.override, anything that base16.nix accepts.

  stylix.image = ../../style/assets/wallpaper-1.png;
  # if base16Scheme is undeclared, stylix will generate one from the wallpaper.

  stylix.polarity = "dark"; # dark/light

  # Targets - anything which can have colors, fonts, or wallpaper applied.
  # for each target, stylix.targets.<<target>>.enable
  # By default, enabled whenever target is installed.

  # Global auto-target:
  stylix.autoEnable = true;

}
