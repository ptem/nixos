# hm/kitty.nix
{
  ...
}:

let
  # My themes are stored in ~/.dotfiles/style/themes/[themeName]/[themeName]-kitty.nix
  colorScheme = "EULR";
in
{
  programs.kitty = {
    enable = true;
    themeFile = "Later_This_Evening";

    settings = {
      scrollback_pager = "hx -";
      initial_window_width = "172c";
      initial_window_height = "50c";
      placement_strategy = "center";
      remember_window_size = "no";

    }
    // import ../style/themes/${colorScheme}/${colorScheme}-kitty.nix;

    keybindings = {
      "ctrl+shift+enter" = "new_window";
      "ctrl+shift+[" = "previous_window";
    };

    shellIntegration.enableBashIntegration = true;
    shellIntegration.enableZshIntegration = true;

    font = {
      # see font_features in extraConfig for styling.
      name = "IBM Plex Mono";
      size = 12;
    };

    extraConfig = ''
      # ss02: single-story g; ss03: slashed 0
      font_features IBMPlexMono +ss02 +ss03
      font_features IBMPlexMono-Regular +ss02 +ss03
      font_features IBMPlexMono-Italic +ss02 +ss03
      font_features IBMPlexMono-Bold +ss02 +ss03
      font_features IBMPlexMono-BoldItalic +ss02 +ss03
    '';
  };

  programs.bash = {
    enable = true;

    # [user@hostname:loc]$ with applied theming.
    bashrcExtra = ''
      # ANSI 8  = Grey
      # ANSI 9  = Red
      # ANSI 15 = White
      # ANSI 14 = Cyan
      # ANSI 11 = Gold
      export PS1="\[\e[38;5;8m\][\[\e[38;5;9m\]\u@\h\[\e[38;5;15m\]:\[\e[38;5;14m\]\w\[\e[38;5;8m\]]\[\e[38;5;11m\]\\$ \[\e[0m\]"
    '';
  };

}
