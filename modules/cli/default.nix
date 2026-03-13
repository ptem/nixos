# modules/cli/default.nix
{
  imports = [
    ./kitty.nix
    # ./ghostty.nix
    ./git.nix
    ./util.nix
    ./helix.nix
  ];
}
