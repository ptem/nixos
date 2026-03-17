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

    settings.theme = themeName;
    themes = import ./style/helix/${themeName}.nix;
  };
}
