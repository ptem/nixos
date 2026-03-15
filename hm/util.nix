# hm/util.nix
{ pkgs, ... }:

{

  home.packages = with pkgs; [
    # sysinfo & fetch
    fastfetch
    btop
    ncdu
    dust
    iotop
    iftop
    sysstat
    lm_sensors
    glow
    cowsay

    # file management
    nnn
    zip
    unzip
    xz
    eza
    tree
    file
    lsof

    # search
    ripgrep
    fd
    fzf
    which
    strace
    ltrace

    # network
    mtr
    iperf3
    ldns
    nmap
    ipcalc
    socat
    ethtool

    # nix tools
    nix-output-monitor
    yq-go
  ];

  # shell & aliases
  programs.bash.enable = true;

  home.shellAliases = {
    ll = "eza -l --icons --git -a";
    ltree = "eza --tree --level=4 --icons";
    top = "btop";
    nfu = "git add . && nix flake update && git add flake.lock";
    # swapped hardcoded 'penrose' for dynamic hostname evaluation
    nrs = "sudo nixos-rebuild switch --flake ~/.dotfiles#$(hostname)";

    refresh-plasma = "fc-cache -f && systemctl --user restart plasma-plasmashell.service";

  };

}
