# hm/cursor.nix
# Defines cursor theme for Home-Manager. As of 07/08/2026, stylix cursor application seemed to stop behaving nicely. This is the best workaround I have.
{ pkgs, ... }:

{

  home.pointerCursor = {
    enable = true;
    gtk.enable = true;
    x11.enable = true;
    package = pkgs.everforest-cursors;
    name = "everforest-cursors";
    size = 32;
  };

  home.sessionVariables = {
    XCURSOR_THEME = "everforest-cursors";
    XCURSOR_SIZE = 32;
  };

}
