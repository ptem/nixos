# style/helix/EULR.nix

# Helix -- Signalis Color Scheme. See also: style/kitty/EULR.nix
{
  EULR = {
    palette = {
      black = "#0A0C0E";
      red = "#A62D1A";
      green = "#277A4B";
      yellow = "#B38F1F";
      blue = "#1B64BA";
      magenta = "#6A7B8A";
      cyan = "#2BA2B3";
      white = "#8C8C8C";

      bright_black = "#242629";
      bright_red = "#D6381C";
      bright_green = "#277A4B";
      bright_yellow = "#D6AA1B";
      bright_blue = "#578C96";
      bright_magenta = "#5D181A";
      bright_cyan = "#2BA2B3";
      bright_white = "#F2F2F2";
    };

    # Theming Scopes:
    # See https://docs.helix-editor.com/themes.html?highlight=ui.cur#scopes for a full reference
    # I think I got everything.

    #
    # === ui ===
    #

    # empty = inherits from kitty/whatever terminal you run hx in, it seems?
    "ui.background" = { };

    # line numbers
    "ui.linenr" = {
      fg = "white";
    };
    "ui.linenr.selected" = {
      fg = "bright_white";
      modifiers = [ "bold" ];
    };

    # statusline
    "ui.statusline" = {
      fg = "bright_white";
    };
    "ui.statusline.inactive" = {
      fg = "white";
    };

    # mode statuses (NOR, INS, SEL)
    "ui.statusline.normal" = {
      fg = "black";
      bg = "bright_red";
    };
    "ui.statusline.insert" = {
      fg = "black";
      bg = "cyan";
    };
    "ui.statusline.select" = {
      fg = "black";
      bg = "magenta";
    };

    # cursor in NOR
    "ui.cursor" = {
      fg = "black";
      bg = "bright_white";
    };

    # cursor/multicursor states
    "ui.cursor.primary" = {
      fg = "black";
      bg = "bright_white";
    };
    "ui.cursor.secondary" = {
      fg = "black";
      bg = "white";
    };
    "ui.cursor.normal" = {
      fg = "black";
      bg = "bright_red";
    };
    "ui.cursor.insert" = {
      fg = "black";
      bg = "cyan";
    };
    "ui.cursor.select" = {
      fg = "black";
      bg = "magenta";
    };

    # highlights for matching brackets
    "ui.cursor.match" = {
      fg = "cyan";
      modifiers = [ "bold" ];
    };

    # cursor lines and columns
    "ui.cursorline.primary" = {
      bg = "bright_black";
    };
    "ui.cursorline.secondary" = {
      bg = "bright_black";
    };
    "ui.cursorcolumn.primary" = {
      bg = "bright_black";
    };
    "ui.cursorcolumn.secondary" = {
      bg = "bright_black";
    };

    # code/command completion menus
    "ui.menu" = {
      fg = "bright_white";
      bg = "bright_black";
    };
    "ui.menu.selected" = {
      fg = "bright_white";
      bg = "bright_magenta";
    };

    # documentation popups (space+k)
    "ui.popup" = {
      fg = "bright_white";
      bg = "bright_black";
    };

    # borderlines separating splits
    "ui.window" = {
      fg = "bright_black";
    };

    # selections in editing area
    "ui.selection" = {
      bg = "bright_yellow";
    };
    # not sure difference...
    "ui.selection.primary" = {
      bg = "bright_magenta";
    };

    # gutter (remove bg)
    "ui.gutter" = { };

    # virtual ui elements (rulers, whitespace, indent guides)
    "ui.virtual.ruler" = {
      bg = "bright_black";
    };
    "ui.virtual.whitespace" = {
      fg = "bright_black";
    };
    "ui.virtual.indent-guide" = {
      fg = "bright_black";
    };
    "ui.virtual.inlay-hint" = {
      fg = "white";
    };
    "ui.virtual.jump-label" = {
      fg = "bright_red";
      modifiers = [ "bold" ];
    };

    # ui text elements and contextual help
    "ui.text" = {
      fg = "bright_white";
    };
    "ui.text.focus" = {
      fg = "bright_white";
      modifiers = [ "bold" ];
    };
    "ui.text.info" = {
      fg = "bright_blue";
    };
    "ui.text.directory" = {
      fg = "bright_blue";
    };
    "ui.help" = {
      fg = "bright_white";
      bg = "bright_black";
    };
    "ui.highlight" = {
      bg = "bright_black";
    };

    #
    # === diagnostic ===
    #

    # diagnostics (underlines in the editor)
    "diagnostic" = {
      modifiers = [ "underlined" ];
    };
    "diagnostic.hint" = {
      underline = {
        color = "white";
        style = "curl";
      };
    };
    "diagnostic.info" = {
      underline = {
        color = "bright_blue";
        style = "curl";
      };
    };
    "diagnostic.warning" = {
      underline = {
        color = "bright_yellow";
        style = "curl";
      };
    };
    "diagnostic.error" = {
      underline = {
        color = "bright_red";
        style = "curl";
      };
    };

    # base colors for diagnostic elements in the gutter/statusline
    "info" = "bright_blue";
    "hint" = "white";
    "warning" = "bright_yellow";
    "error" = "bright_red";

    # git diff colors
    "diff.plus" = "green";
    "diff.delta" = "bright_blue";
    "diff.minus" = "red";

    #
    # === syntax highlighting ===
    #

    "comment" = {
      fg = "white";
      modifiers = [ "italic" ];
    };
    "string" = "green";

    "constant" = "blue";
    "constant.builtin" = "cyan";
    "constant.numeric" = "cyan";
    "constant.character.escape" = "red";

    "variable" = "red";
    "variable.other.member" = "red";
    "variable.parameter" = {
      fg = "bright_blue";
      modifiers = [ "italic" ];
    };

    "type" = "bright_yellow";

    "keyword" = "yellow";
    "keyword.control" = "yellow";
    "keyword.directive" = "magenta";
    "keyword.function" = "magenta";

    "function" = "blue";

    "punctuation" = "white";
    "punctuation.bracket" = "bright_white";

    "operator" = "cyan";
    "label" = "blue";
    "attribute" = "yellow";
    "namespace" = "bright_yellow";
    "special" = "red";

    "markup.heading" = "bright_red";
    "markup.list" = "bright_white";
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
    "markup.raw" = "bright_white";
  };
}
