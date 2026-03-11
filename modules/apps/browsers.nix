# modules/apps/browsers.nix
{ ... }:

{
  home = {
    programs.firefox = {
      enable = true;
    };
  };
}
