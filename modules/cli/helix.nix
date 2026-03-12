# modules/cli/helix.nix
{ pkgs, ... }:

{
  home = {
    programs.helix = {
      enable = true;
      defaultEditor = true;

      settings = {
        theme = "catpuccin_mocha";

        editor = {
          line-number = "relative";
          mouse = true;
          cursorline = true;
          color-modes = true;
          /*
          cursor-shape = {
            insert = "bar";
            normal = "block";
            select = "undereline";
          };
          */
        };

        indent-guides.render = true;
        lsp.display-messages = true;
      };
    };
  };
}

