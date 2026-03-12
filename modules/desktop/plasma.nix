# modules/desktop/plasma.nix
{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [

    # syncs KDE settings to GTK apps
    kdePackages.kde-gtk-config

    # breeze theme for GTK 2/3 apps
    kdePackages.breeze-gtk
  ];

  # GTK things
  programs.dconf.enable = true;

  # x11 & keyboard
  services.xserver = {
    enable = true;
    xkb.layout = "us";
    xkb.variant = "";
  };

  # plasma 6
  services.displayManager.sddm.enable = true;
  services.desktopManager.plasma6.enable = true;

  environment.sessionVariables = {
    # Monitor / Refresh Rate / Color
    KWIN_DRM_DISABLE_TRIPLE_BUFFERING = "1";
    KWIN_DRM_NO_AMS = "1";
    KWIN_DRM_PREFER_COLOR_DEPTH = "30";
    AMD_DEBUG = "wsi_force_bgra8_unorm=0";

    # Freetype Engine
    FREETYPE_PROPERTIES = "cff:no-stem-darkening=0 autofitter:no-stem-darkening=0 truetype:interpreter-version=40";
    QT_SCALE_FACTOR_ROUNDING_POLICY = "RoundPreferFloor";
  };


  # remove default plasma apps
  environment.plasma6.excludePackages = with pkgs.kdePackages; [
    gwenview
    okular
    elisa
    khelpcenter
    kate
  ];


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
        sansSerif = [ "Geist" "Noto Sans Serif" ];
        serif = [ "IBM Plex Serif" "Noto Serif" ];
        monospace = [ "IBM Plex Mono Text" "JetBrainsMono Nerd Font" ];
        emoji = [ "Twitter Color Emoji" "Noto Color Emoji" ];
      };
    };

    
  };
}
