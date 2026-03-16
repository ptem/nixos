# nix/plasma.nix
{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [

    # syncs KDE settings to GTK apps
    kdePackages.kde-gtk-config

    # breeze theme for GTK 2/3 apps
    kdePackages.breeze-gtk

    # Wayland compositor
    # kdePackages.kwin -- included in plasma enable anyway
  ];

  # GTK things
  programs.dconf.enable = true;

  # x11 & keyboard
  services.xserver = {
    enable = true;
    xkb.layout = "us";
    xkb.variant = "";
  };

  xdg.portal = {
    enable = true;
    extraPortals = with pkgs; [
      kdePackages.xdg-desktop-portal-kde
    ];
    config.common.default = "kde";
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

}
