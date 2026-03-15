# sys/fonts.nix
{ pkgs, ... }:

{
  environment.sessionVariables = {
    # Freetype engine
    FREETYPE_PROPERTIES = "cff:no-stem-darkening=0 autofitter:no-stem-darkening=0 truetype:interpreter-version=40";
  };

  # fonts
  console.font = "sun12x22";

  fonts = {
    fontDir.enable = true;
    enableDefaultPackages = false;

    packages = with pkgs; [
      # Text (Sans + Serif + Mono)
      ibm-plex
      noto-fonts
      geist-font
      nerd-fonts.jetbrains-mono
      nerd-fonts.fira-code

      # Symbols
      material-design-icons
      nerd-fonts.symbols-only

      # Emoji
      twitter-color-emoji
      noto-fonts-color-emoji

      # Arial/TNR compatibility
      liberation_ttf
    ];

    fontconfig = {
      enable = true;
      antialias = true;

      # align font vectors to pixel grid slightly
      hinting = {
        enable = true;
        style = "slight";
        autohint = true;
      };

      # subpixel rendering
      subpixel = {
        rgba = "rgb";
        lcdfilter = "default";
      };

      # generally nerd-fonts.font-name -> "FontName Nerd Font"
      # Each defaultFonts option takes a list
      # First is highest prio, subsequent are fallbacks
      defaultFonts = {
        sansSerif = [
          "Geist"
          "Noto Sans Serif"
        ];
        serif = [
          "IBM Plex Serif"
          "Noto Serif"
        ];
        monospace = [
          "IBM Plex Mono Text"
          "JetBrainsMono Nerd Font"
        ];
        emoji = [
          "Twitter Color Emoji"
          "Noto Color Emoji"
        ];
      };
    };
  };

}
