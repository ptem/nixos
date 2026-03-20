# hm/default.nix
# user configurations for all (im lazy)
{ ... }:

{
  imports = [
    # base setup items
    ./audio.nix
    ./git.nix
    ./browsers.nix
    ./kitty.nix
    ./helix.nix

    # all other
    ./social.nix
    ./gaming.nix
    ./util.nix
    ./fastfetch.nix

    ./media.nix
    ./naviterm.nix
    ./obs.nix

    ./sway
  ];

}
