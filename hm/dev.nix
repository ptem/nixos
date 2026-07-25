# hm/dev.nix
{ pkgs, ... }:

{
  home.packages = with pkgs; [
    cargo
    rustc
    gcc

    rustfmt
    rust-analyzer
    clippy

    docker
    docker-compose

    winetricks
    wineWow64Packages.stable
  ];
}
