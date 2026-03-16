# hm/helix.nix
#
#
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

      theme = "custom_helix";

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

    themes = {
      custom_helix = {
        inherits = "rasmus";

        palette = {
          crust = "#0A0C0E";
          base = "#141517";
          surface = "#242629";
          text = "#F2F2F2";
          subtext0 = "#8C8C8C";

          red = "#D6381C";
          maroon = "#A62D1A";
          peach = "#D6AA1B";
          yellow = "#B38F1F";
          green = "#277A4B";
          teal = "#2BA2B3";
          blue = "#1B64BA";
          mauve = "#6A7B8A";
          lavender = "#578C96";
        };

        "ui.background" = { };

        "ui.linenr" = {
          fg = "subtext0";
        };
        "ui.linenr.selected" = {
          fg = "text";
          modifiers = [ "bold" ];
        };

        "ui.statusline" = {
          fg = "text";
        };
        "ui.statusline.inactive" = {
          fg = "subtext0";
        };

        "ui.statusline.normal" = {
          fg = "crust";
          bg = "red";
        };
        "ui.statusline.insert" = {
          fg = "crust";
          bg = "teal";
        };
        "ui.statusline.select" = {
          fg = "crust";
          bg = "mauve";
        };

        "ui.cursor" = {
          fg = "crust";
          bg = "text";
        };
        "ui.cursor.match" = {
          fg = "teal";
          modifiers = [ "bold" ];
        };

        "ui.menu" = {
          fg = "text";
          bg = "surface";
        };
        "ui.menu.selected" = {
          fg = "text";
          bg = "#5D181A";
        };
        "ui.popup" = {
          fg = "text";
          bg = "surface";
        };
        "ui.window" = {
          fg = "base";
        };

        "ui.selection" = {
          bg = "#5D181A";
        };
        "ui.selection.primary" = {
          bg = "#5D181A";
        };

        "ui.gutter" = { };
        "diff.plus" = "green";
        "diff.delta" = "lavender";
        "diff.minus" = "maroon";

        "comment" = {
          fg = "subtext0";
          modifiers = [ "italic" ];
        };
        "string" = "green";
        "constant" = "blue";
        "constant.builtin" = "teal";
        "constant.numeric" = "teal";
        "constant.character.escape" = "maroon";
        "variable" = "maroon";
        "variable.other.member" = "maroon";
        "variable.parameter" = {
          fg = "lavender";
          modifiers = [ "italic" ];
        };
        "type" = "peach";
        "keyword" = "yellow";
        "keyword.control" = "yellow";
        "keyword.directive" = "mauve";
        "keyword.function" = "mauve";
        "function" = "blue";
        "punctuation" = "subtext0";
        "punctuation.bracket" = "text";
        "operator" = "teal";
        "label" = "blue";
        "attribute" = "yellow";
        "namespace" = "peach";
        "special" = "maroon";

        "markup.heading" = "red";
        "markup.list" = "text";
        "markup.bold" = {
          modifiers = [ "bold" ];
        };
        "markup.italic" = {
          modifiers = [ "italic" ];
        };
        "markup.link.url" = {
          fg = "blue";
          modifiers = [ "underline" ];
        };
        "markup.raw" = "text";
      };
    };

  };
}
