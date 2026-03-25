# sys/default.nix
# system-level configurations used on every machine
{ ... }:

{
  imports = [
    ./fonts.nix
    ./peripheral.nix
  ];

}
