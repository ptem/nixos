# hm/gui.nix
# GUI tools that don't gave a better home on their own
{ pkgs, ... }:

{
  home.packages = with pkgs; [
    pwvucontrol # pipewire volume control applet
  ];
}
