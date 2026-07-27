# sys/services/immich.nix
# Requires tailscale. Requires hardware stuff for acceleration, requires graphics configs. Set in hosts/sierpinski/default.nix
{ config, pkgs, ... }:

let
  cfg = config.services.immich;
in
{
  # ownership/perms for immich storage dir
  systemd.tmpfiles.settings."10-immich" = {
    "${cfg.mediaLocation}".d = {
      mode = "0750";
      user = cfg.user;
      group = cfg.group;
    };
  };

  services.immich = {
    enable = true;
    port = 2283;
    host = "0.0.0.0";
    mediaLocation = "/mnt/store/services/immich";

    # null? null.
    accelerationDevices = null;

    settings = {
      server = {
        externalDomain = "https://photos.axolotlsin.space";
      };
    };
  };

  users.users.immich.extraGroups = [
    "video"
    "render"
  ];

  services.redis.servers.immich.logLevel = "warning";

}
