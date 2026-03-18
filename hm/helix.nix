# hm/helix.nix
{
  pkgs,
  ...
}:

let
  # my defined themes located in ~/.dotfiles/hm/style/helix/
  themeName = "EULR";
in
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
          scope = "source.nix";
          auto-format = true;
          formatter.command = "${pkgs.nixfmt}/bin/nixfmt";
          language-servers = [ "nil" ];
        }
        {
          name = "json";
          scope = "source.json";
          file-types = [ "json" ];
          language-servers = [ "vscode-json-language-server" ];
        }
        {
          name = "jsonc";
          scope = "source.json";
          file-types = [ "jsonc" ];
          language-servers = [ "vscode-json-language-server" ];
        }
      ];

      language-server.nil = {
        command = "${pkgs.nil}/bin/nil";
        config.nil.formatting.command = [ "nixfmt" ];
      };

      language-server.vscode-json-language-server = {
        command = "${pkgs.nodePackages.vscode-langservers-extracted}/bin/vscode-json-language-server";
        args = [ "--stdio" ];
      };
    };

    settings.theme = themeName;
    themes = import ./style/helix/${themeName}.nix;
  };
}
