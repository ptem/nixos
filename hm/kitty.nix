{
  config,
  pkgs,
  username,
  ...
}:

{
  programs.kitty = {
    enable = true;
    # themeFile = "Farin";
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

      background_opacity = "0.90";
      background = "#0D0808";
      background_blur = 1;
      background_tint = "0.3";
      dynamic_background_opacity = "yes";

      foreground = "#F2F2F2";
      selection_background = "#5D181A";
      selection_foreground = "#F2F2F2";
      cursor = "#2BA2B3";
      cursor_text_color = "#0A0C0E";
      url_color = "#1B64BA";

      color0 = "#0A0C0E";
      color8 = "#242629";

      color1 = "#A62D1A";
      color9 = "#D6381C";

      color2 = "#277A4B";
      color10 = "#21B563";

      color3 = "#B38F1F";
      color11 = "#D6AA1B";

      color4 = "#223A5E";
      color12 = "#1B64BA";

      color5 = "#5D181A";
      color13 = "#802B2E";

      color6 = "#578C96";
      color14 = "#2BA2B3";

      color7 = "#D6CFC8";
      color15 = "#F2F2F2";

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

}
