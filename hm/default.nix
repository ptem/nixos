# hm/default.nix
# user configurations for all (im lazy)
{ ... }:

{
  imports = [
    # base setup items
    ./git.nix
    ./browsers.nix
    ./kitty.nix
    ./helix.nix
    ./file.nix
    ./dev.nix

    # all other
    ./social.nix

    ./gaming.nix
    ./ffxiv.nix
    ./minecraft.nix

    ./util.nix
    ./fastfetch.nix

    ./media.nix
    ./obs.nix

    ./sway
    ./cursor.nix

    ./gui.nix
    ./fuzzel.nix
  ];

}
