# hm/util.nix
{ pkgs, ... }:

{

  home.packages = with pkgs; [
    # arch/env
    unzip
    xdg-user-dirs
    xz
    zip

    # hw/bus
    pciutils
    usbutils

    # sys/monitoring
    btop
    file
    lsof
    ncdu

    # find shit
    fzf
    ripgrep
    eza

    # debug/trace
    ltrace # trace lib calls
    strace # trace system calls

    # Network & Data Processing
    ldns # drill for dns shit
    mtr # ping/tracert
    yq-go # cli yaml processor
    jq # cli json processor

    # nix
    nix-output-monitor # viz nix build logs + dep graphs

    # docs/manpages
    bat
    bat-extras.batdiff
    bat-extras.batgrep
    bat-extras.batman
    tldr
    delta

    # fun/info
    fastfetch
  ];

  # shell & aliases
  programs.bash.enable = true;

  home.shellAliases = {
    d = "cd ~/.dotfiles";
    ll = "eza -l --icons --git -a";
    ltree = "eza --tree --level=4 --icons";
    top = "btop";
    nfu = "git add . && nix flake update && git add flake.lock";
    # swapped hardcoded 'penrose' for dynamic hostname evaluation
    nrs = "sudo nixos-rebuild switch --flake ~/.dotfiles#$(hostname)";
    hmr = "home-manager switch --flake ~/.dotfiles#bee@penrose";
    rebuild = "nrs && hmr";

    # refresh-plasma = "fc-cache -f && systemctl --user restart plasma-plasmashell.service";

    # glurp = ''FILE=$(xdg-user-dir PICTURES)/grim/$(date +%Y%m%d-%H%M%S_grim.png); grim -g "$(slurp)" "$FILE" && wl-copy < "$FILE"'';
    glurp = ''FILE=$(xdg-user-dir PICTURES)/grim/$(date +%Y%m%d-%H%M%S_grim.png); grim -g "$(slurp)" "$FILE" && wl-copy < "$FILE" && notify-send -t 3000 "Screenshot Taken" "Saved to $FILE and copied to clipboard"'';

  };

}
