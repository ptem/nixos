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

  home.packages = [ pkgs.libsecret ];

  # Default Programs
  xdg.mimeApps = {
    enable = true;

    defaultApplications = {
      "text/html" = "librewolf.desktop";
      "x-scheme-handler/http" = "librewolf.desktop";
      "x-scheme-handler/https" = "librewolf.desktop";
      "x-scheme-handler/about" = "librewolf.desktop";
      "x-scheme-handler/unknown" = "librewolf.desktop";
    };
  };

  # Nonspecific HM environment vars. No better place to put these rn.
  home.sessionVariables = {
    GOPATH = "$HOME/.go";
  };

  home.sessionPath = [
    "$HOME/.go"
    "$HOME/.cargo/bin"
  ];

  # Compat / Defaults because idk, reasons. Things yelling.
  gtk = {
    # Default value of gtk.gtk4.theme has changed from config.gtk.theme to null
    # Adopt new behavior:
    gtk4.theme = null;

  };

}
