# hm/helix.nix
{
  config,
  lib,
  pkgs,
  ...
}:

{
  programs.helix = {
    enable = true;
    defaultEditor = true;

    extraPackages = with pkgs; [
      nil
      nixfmt
    ];

    settings = {
      theme = "catppuccin_kitty";
      #theme = "base16_transparent";

      editor = {
        line-number = "relative";
        mouse = true;
        cursorline = false;
        color-modes = true;
        indent-heuristic = "hybrid";
        trim-trailing-whitespace = true;
        auto-pairs = true;

        cursor-shape = {
          insert = "bar";
          normal = "block";
          # select = "underline";
        };

        lsp.display-messages = true;
      };
    };

    themes = {
      catppuccin_kitty = {
        inherits = "catppuccin_mocha";

        "ui.background" = { };

        "ui.statusline" = {
          fg = "text";
        };
        "ui.statusline.inactive" = {
          fg = "subtext0";
        };
        "ui.menu" = {
          fg = "text";
        };
        "ui.popup" = {
          fg = "text";
        };
        "ui.window" = {
          fg = "crust";
        };
      };
    };

    languages = {
      language = [
        {
          name = "nix";
          auto-format = true;
          formatter.command = "${pkgs.nixfmt}/bin/nixfmt";
          language-servers = [ "nil" ];
        }
      ];

      language-server.nil = {
        command = "${pkgs.nil}/bin/nil";
        config.nil.formatting.command = [ "nixfmt" ];
      };
    };

  };

}
