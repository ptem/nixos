# sys/desktop.nix
# gui/desktop specific system modules and configuration for desktop-using hosts
{ ... }:

{
  imports = [
    ./fonts.nix
    ./file.nix

    ./audio.nix
    ./sway.nix
    ./steam.nix

    ./peripheral.nix
    ./triggerhappy.nix
  ];
}
