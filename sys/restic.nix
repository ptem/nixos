# sys/restic.nix
{ config, pkgs, ... }:

{
  age.secrets."restic".file = ../secrets/restic.age;

  environment.systemPackages = [ pkgs.restic ];
  # services.restic.backups.immich = {
  #   repository = "/mnt/store/backup/sierpinski/immich";
  #   # etc.
  # };
}
