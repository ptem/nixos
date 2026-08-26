# hm/file.nix
{ pkgs, ... }:

{
  programs.ranger = {
    enable = true;

    plugins = [
      {
        name = "ranger-devicons2";
        src = pkgs.fetchFromGitHub {
          owner = "cdump";
          repo = "ranger-devicons2";
          rev = "94bdcc19218681debb252475fd9d11cfd274d9b1";
          hash = "sha256-aJCIoDfzmOnzMLlbOe+dy6129n5Dc4OrefhHnPsgI8k=";
        };
      }
    ];

    aliases = {
      e = "edit";
      dots = "cd ~/.dotfiles";
    };

    settings = {
      column_ratios = "1,3,3";
      confirm_on_delete = "always";
      vcs_aware = true;
      unicode_ellipsis = true;
      draw_borders = "both";
      show_hidden = true;

      # Preview Configuration
      preview_images = true;
      preview_images_method = "kitty";
      preview_max_size = 10485760;
      wrap_plaintext_previews = true;
    };

    extraPackages = with pkgs; [
      ffmpegthumbnailer
      file
      libarchive
      lynx
    ];

    extraConfig = ''
      default_linemode devicons2
    '';
  };
}
