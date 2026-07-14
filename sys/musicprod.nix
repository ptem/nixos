# sys/musicprod.nix
{
  config,
  pkgs,
  lib,
  ...
}:

{
  environment.systemPackages = with pkgs; [
    ardour
  ];

}
