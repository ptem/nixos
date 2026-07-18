# hm/util.nix
{ pkgs, ... }:

{

  home.packages = with pkgs; [
    # arch/env
    unzip
    xdg-user-dirs
    xz
    zip
    rar

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

    # idk
    fastfetch

    # flatpaks
    flatpak
  ];

  # shell & aliases
  programs.bash.enable = true;

  home.shellAliases = {
    d = "cd ~/.dotfiles";
    r = "ranger";
    ll = "eza -l --icons --git -a";
    ltree = "eza --tree --level=4 --icons";
    top = "btop";
    nfu = "git add . && nix flake update && git add flake.lock";
    nrs = "sudo nixos-rebuild switch --flake ~/.dotfiles#$(hostname)";
    hmr = "home-manager switch --flake ~/.dotfiles#bee@penrose";
    rebuild = "nrs && hmr";
  };

}
