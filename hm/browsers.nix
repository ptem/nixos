# hm/browsers.nix
{ ... }:

{
  programs.firefox = {
    enable = false;
  };

  programs.librewolf = {
    enable = true;
  };
}
