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
  ];
}
