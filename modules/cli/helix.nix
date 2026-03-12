# modules/cli/helix.nix
{ config, lib, pkgs, ... }:

{
  home = {
    programs.helix = {
      enable = true;
      defaultEditor = true;

      settings = {
        theme = "base16_transparent";

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

        indent-guides = {
          render = true;
          # character = "|";
        };

        lsp.display-messages = true;
      };
      
      languages = {
        language = [
          {
            name = "nix";
            auto-format = true;
            formatter.command = "${pkgs.nixfmt}/bin/nixfmt";
          }
        ];
      };

      extraPackages = with pkgs; [
        nil
        nixfmt
      ];
    };
  };
}

