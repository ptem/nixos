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

    winboat
    docker
    docker-compose
    electron_40

    winetricks
    wineWow64Packages.stable
  ];
}
