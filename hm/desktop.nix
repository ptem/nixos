# hm/desktop.nix
# desktop machine default imports for users/hm.
{ pkgs, ... }:

{
  imports = [
    # DE/WM
    ./sway
    ./fuzzel.nix
    ./cursor.nix
    ./gui.nix

    # Term/Browsers
    ./kitty.nix
    ./browsers.nix

    # Dev/Files
    ./dev.nix

    # Comms
    ./social.nix

    # Media, Production, Recording, etc.
    ./media.nix
    ./obs.nix

    # Gaming
    ./gaming.nix
    ./ffxiv.nix
    ./minecraft.nix
  ];

  # GTK & Icon themes
  home.packages = with pkgs; [
    hicolor-icon-theme
    adwaita-icon-theme
  ];

  gtk = {
    enable = true;
    iconTheme = {
      package = pkgs.papirus-icon-theme;
      name = "Papirus-Dark";
    };
    colorScheme = "dark";
  };

  # Hyprland eval warning. I don't use hyprland so idk why home manager cares so much.
  # TODO: Look at this.
  wayland.windowManager.hyprland.configType = "hyprlang";

  # Desktop MIME apps
  xdg.mimeApps = {
    enable = true;
    defaultApplications = {
      "text/html" = "firefox.desktop";
      "x-scheme-handler/http" = "firefox.desktop";
      "x-scheme-handler/https" = "firefox.desktop";
      "x-scheme-handler/about" = "firefox.desktop";
      "x-scheme-handler/unknown" = "firefox.desktop";
      "inode/directory" = "thunar.desktop";
      "text/plain" = "helix.desktop";
    };
  };

  # Desktop Environment Variables
  home.sessionVariables = {
    XDG_DATA_DIRS = "$XDG_DATA_DIRS:/var/lib/flatpak/exports/share:$HOME/.local/share/flatpak/exports/share";
    TERMINAL = "kitty";
    QT_QPA_PLATFORMTHEME = "gtk3";
  };
}
