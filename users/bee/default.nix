# users/bee/default.nix
{
  username,
  lib,
  pkgs,
  inputs,
  ...
}:

{
  imports = [

    #home manager (user-level) definitions
    ../../hm/browsers.nix
    ../../hm/gaming.nix
    ../../hm/git.nix
    ../../hm/helix.nix
    ../../hm/kitty.nix
    ../../hm/media.nix
    ../../hm/util.nix
    ../../hm/fastfetch.nix
    ../../hm/naviterm.nix

  ];

  home = {
    username = "bee";
    homeDirectory = "/home/bee";
    stateVersion = "25.11";
  };

  # use home manager
  programs.home-manager.enable = true;

  home.packages = [ pkgs.libsecret ];
}
