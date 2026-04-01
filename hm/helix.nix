# hm/helix.nix
{
  pkgs,
  ...
}:

# let
#   # my defined themes located in ~/.dotfiles/style/themes/[themeName]/[themeName]-helix.nix
#   themeName = "EULR";
# in
{
  programs.helix = {
    enable = true;
    defaultEditor = true;

    extraPackages = with pkgs; [
      nil
      nixfmt
    ];

    settings = {
      editor = {
        line-number = "relative";
        mouse = true;
        cursorline = false;
        color-modes = true;
        indent-heuristic = "hybrid";
        trim-trailing-whitespace = true;
        auto-pairs = true;
        # rulers = [ 100 ];

        cursor-shape = {
          insert = "bar";
          normal = "block";
          # select = "underline";
        };

        lsp.display-messages = true;
        lsp.display-inlay-hints = true;
      };
    };

    languages = {
      language = [
        {
          name = "nix";
          scope = "source.nix";
          auto-format = true;
          formatter.command = "${pkgs.nixfmt}/bin/nixfmt";
          language-servers = [
            "nil"
            "uwu_colors"
          ];
        }
        {
          name = "rust";
          auto-format = true;
          formatter.command = "${pkgs.rustfmt}/bin/rustfmt";
          language-servers = [
            "rust-analyzer"
          ];
        }
        {
          name = "json";
          scope = "source.json";
          file-types = [ "json" ];
          language-servers = [
            "vscode-json-language-server"
            "uwu_colors"
          ];
        }
        {
          name = "jsonc";
          scope = "source.json";
          file-types = [ "jsonc" ];
          language-servers = [
            "vscode-json-language-server"
            "uwu_colors"
          ];
        }
      ];

      language-server.nil = {
        command = "${pkgs.nil}/bin/nil";
        config.nil.formatting.command = [ "nixfmt" ];
      };

      language-server.rust-analyzer = {
        command = "rust-analyzer";
        config = {
          cargo = {
            buildScripts.enable = true;
          };
          check = {
            command = "clippy";
          };
          inlayHints = {
            bindingModeHints.enable = false;
            closingBraceHints.minLines = 10;
            closureReturnTypeHints.enable = "with_block";
            disciminantHints.enable = "fieldless";
            lifetimeElisionHints.enable = "skip_trivial";
            typeHints.hideNamedConstructor = false;
          };
        };
      };

      language-server.vscode-json-language-server = {
        command = "${pkgs.nodePackages.vscode-langservers-extracted}/bin/vscode-json-language-server";
        args = [ "--stdio" ];
      };

      language-server.vscode-css-language-server = {
        command = "${pkgs.nodePackages.vscode-langservers-extracted}/bin/vscode-css-language-server";
        args = [ "--stdio" ];
      };

      language-server.uwu_colors = {
        command = "${pkgs.uwu-colors}/bin/uwu_colors";
      };
    };

    # settings.theme = themeName;
    # themes = import ../style/themes/${themeName}/${themeName}-helix.nix;
  };
}
