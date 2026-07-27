# sys/default.nix
# system-level configurations used on every machine
{ ... }:

{
  imports = [
    ./system.nix
    ./network.nix
    ./restic.nix
  ];
}
