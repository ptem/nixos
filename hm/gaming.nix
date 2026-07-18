# hm/gaming.nix
{ pkgs, ... }:

{

  home.packages = with pkgs; [
    stable.r2modman
  ];

}
