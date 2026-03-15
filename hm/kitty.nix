{
  config,
  pkgs,
  username,
  ...
}:

{
  home = {

    programs.kitty = {
      enable = true;
      themeFile = "Later_This_Evening";

      shellIntegration.enableBashIntegration = true;
      shellIntegration.enableZshIntegration = true;

      font = {
        name = "IBM Plex Mono";
        size = 12;
      };

      settings = {

        scrollback_pager = "hx -";
        initial_window_width = "172c";
        initial_window_height = "50c";
        placement_strategy = "center";
        remember_window_size = "no";

        background_opacity = "0.85";
        background = "#11111b";
        background_blur = 1;
        background_tint = 0.0;
        dynamic_background_opacity = "yes";

      };

      keybindings = {
        "ctrl+shift+enter" = "new_window";
        "ctrl+shift+[" = "previous_window";
      };

      extraConfig = ''
        # ss02: single-story g; ss03: slashed 0
        font_features = "IBMPlexMono-Regular-Regular +ss02 +ss03";
        font_features = "IBMPlexMono-Regular-Italic +ss02 +ss03";
        font_features = "IBMPlexMono-Regular-Bold +ss02 +ss03";
        font_features = "IBMPlexMono-Regular-BoldItalic +ss02 +ss03";
      '';
    };

  };
}
