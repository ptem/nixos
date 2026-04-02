# hm/kitty.nix
{
  config,
  lib,
  ...
}:

{
  programs.kitty = {
    enable = true;

    settings =
      let
        colors = config.lib.stylix.colors;
      in
      {
        scrollback_pager = "hx -";
        initial_window_width = "172c";
        initial_window_height = "50c";
        placement_strategy = "center";
        remember_window_size = "no";

        # background_opacity = lib.mkForce "0.5";
        background_blur = lib.mkForce "0";

        # dynamic_background_opacity = lib.mkForce "yes";

        background = lib.mkForce "#${colors.base0E}";
        # foreground = lib.mkForce "#${colors.base08}";
        selection_background = lib.mkForce "#${colors.base0F}";
        # selection_foreground = lib.mkForce "#${colors.base05}";
        # cursor = lib.mkForce "#${colors.base0B}";
        # cursor_text_color = lib.mkForce "#${colors.base00}";
        # url_color = lib.mkForce "#${colors.base09}";

        open_url_with = "librewolf";

      };

    keybindings = {
      "ctrl+shift+enter" = "new_window";
      "ctrl+shift+[" = "previous_window";
    };

    shellIntegration.enableBashIntegration = true;
    shellIntegration.enableZshIntegration = true;
  };

  programs.bash = {
    enable = true;

    bashrcExtra = ''
      # handle shell prompt
      export PROMPT_DIRTRIM=1
      export PS1="\[\e[92m\]\u \[\e[32m\]\w \[\e[92m\]❯ \[\e[0m\]"

      export HOME_MANAGER_CONFIG="/home/bee/.dotfiles/users/bee/default.nix"
    '';
  };

}
