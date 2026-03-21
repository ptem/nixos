# hm/file.nix
{ pkgs, ... }:

{

  programs.ranger = {
    enable = true;

    # plugins = [
    #   {
    #     name = "zoxide";
    #     src = builtins.fetchGit {
    #       url = "https://github.com/jchook/ranger-zoxide.git";
    #       rev = "363df97af34c96ea873c5b13b035413f56b12ead";
    #     };
    #   }
    # ];

    aliases = {
      e = "edit";
    };

    settings = {
      # column_ratios = "1,3,3";
      # confirm_on_delete = "never";
      # scroll_offset = 8;
      unicode_ellipsis = true;
      preview_images = true;
      preview_images_method = "kitty";
    };

    extraPackages = with pkgs; [
      ueberzugpp
      ffmpegthumbnailer
      file
      libarchive
    ];

    # rifle = [
    #   # list of submodule
    #   # rifle.*.command, .condition
    # ];

  };

  # https://github.com/jarun/nnn
  programs.nnn = {
    enable = false;

    # package = pkgs.nnn.override { withNerdIcons = true; };

    # bookmarks = {
    #   d = "~/.dotfiles";
    #   D = "~/Downloads";
    # };

    # extraPackages = with pkgs; [
    #   ffmpegthumbnailer
    #   mediainfo
    #   sxiv
    # ];

    # plugins = {
    #   src =
    #     (pkgs.fetchFromGitHub {
    #       owner = "jarun";
    #       repo = "nnn";
    #       rev = "v5.2";
    #       sha256 = "sha256-u+88aDHfOZ6bSkg6ahS6eNZWj2QCwJXKW+8nHR99kic=";
    #     })
    #     + "/plugins";

    #   mappings = {
    #     v = "imgview";
    #     p = "preview-tui";
    #   };
    # };

  };
}
