# hm/default.nix
# user configurations for all hosts.
{ ... }:

{
  imports = [
    ./git.nix
    ./helix.nix
    ./util.nix
    ./ssh.nix
    #./fastfetch.nix
  ];

}
