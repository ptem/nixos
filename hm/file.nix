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
      preview_images = true;
      preview_max_size = 10485760;
      draw_borders = "both";
      preview_images_method = "kitty";
      use_preview_script = true;
      preview_script = "~/.config/ranger/scope.sh";
      wrap_plaintext_previews = true;
      show_hidden = true;
    };

    extraPackages = with pkgs; [
      ffmpegthumbnailer
      file
      libarchive
      lynx
      haskellPackages.pdftotext
      haskellPackages.epub
      # bat -- already have
    ];

    # rifle = [
    #   # list of submodule
    #   # rifle.*.command, .condition
    # ];

    extraConfig = ''
      default_linemode devicons2
    '';
  };

  # preview script
  xdg.configFile."ranger/scope.sh" = {
    executable = true;
    text = ''
      #!/usr/bin/env bash
      # arguments passed by ranger
      path="$1"         # path of the selected file
      width="$2"        # preview pane width
      height="$3"       # preview pane height
      image_enable="$5"

      extension=$(echo "''${path##*.}" | tr '[:upper:]' '[:lower:]')

      case "$extension" in
          md|markdown)
              bat --color=always "$path" && exit 5
              exit 1;;
      esac

      mimetype=$(file --mime-type -Lb "$path")

      case "$mimetype" in
        image/*)
          if [[ "$image_enable" == "True" ]]; then
            exit 7
          fi
          exit 1;;
        text/* | application/json | */xml)
          bat --color=always --style=plain "$path" && exit 5
          exit 1;;
      esac

      exit 1
    '';
  };
}
