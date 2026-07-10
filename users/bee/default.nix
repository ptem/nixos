# users/bee/default.nix
{
  lib,
  pkgs,
  inputs,
  ...
}:

{

  imports = [
    # default hm imports
    ../../hm
  ];

  home = {
    username = "bee";
    homeDirectory = "/home/bee";
    stateVersion = "25.11";
  };

  # use home manager
  programs.home-manager.enable = true;

  home.packages = with pkgs; [
    libsecret

    # gtk icon fallbacks
    hicolor-icon-theme
    adwaita-icon-theme
  ];

  # Hyprland eval warning. I don't use hyprland so idk why home manager cares so much.
  # TODO: Look at this.
  wayland.windowManager.hyprland.configType = "hyprlang";

  # Default Programs
  xdg.mimeApps = {
    enable = true;

    defaultApplications = {
      "text/html" = "firefox.desktop";
      "x-scheme-handler/http" = "firefox.desktop";
      "x-scheme-handler/https" = "firefox.desktop";
      "x-scheme-handler/about" = "firefox.desktop";
      "x-scheme-handler/unknown" = "firefox.desktop";

      "inode/directory" = "thundar.desktop";
      "text/plain" = "helix.desktop";
    };
  };

  # Nonspecific HM environment vars. No better place to put these rn.
  home.sessionVariables = {
    GOPATH = "$HOME/.go";
    XDG_DATA_DIRS = "$XDG_DATA_DIRS:/var/lib/flatpak/exports/share:$HOME/.local/share/flatpak/exports/share";
    TERMINAL = "kitty";

    # for GTK apps
    QT_QPA_PLATFORMTHEME = "gtk3";
  };

  home.sessionPath = [
    "$HOME/.go"
    "$HOME/.cargo/bin"
  ];

  gtk = {
    enable = true;

    # Actual theme auto-set via stylix target.
    iconTheme = {
      package = pkgs.papirus-icon-theme;
      name = "Papirus-Dark";
    };
    colorScheme = "dark";
  };

}
