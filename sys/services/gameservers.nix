# sys/services/gameservers.nix
{ config, pkgs, ... }:

{
  virtualisation.oci-containers.backend = "docker";

  # this should already be set
  # networking.firewall.trustedInterfaces = [ "tailscale0" ];

  # example game server.
  # Management:
  # - server files at /mnt/store/gameservers/<game>/<servername>
  # - use systemd service commands for docker-<servername>.service [eg journalctl -fu docker-servername or docker logs -f servername]
  # - mc has RCON, can exec through host with docker exec -it servername rcon-cli. alt, just attach to container w/ docker attach servername
  # on rebuild, only restarts if the service definition has changed.
  virtualisation.oci-containers.containers.mc-test = {
    image = "itzg/minecraft-server:latest";
    autoStart = true;

    ports = [ "25565:25565" ]; # exposed on lan. can do 100.x.x.x:port for tailscale -> VPS nonsense.
    # speaking of, need to add to Caddyfile on VPS: layer4 { :25565 { route { proxy { upstream 100.x.y.z:25565 } } } }
    # have an A record for traffic to mc.domain.name, need to juggle SRVs if i want to do anything more. idc enough.

    environment = {
      EULA = "TRUE";
      # TYPE = "CURSEFORGE";
      MEMORY = "4G";
      SERVER_NAME = "testie testie";
      # CF_SERVER_MOD = "/data/modpack.zip"; # image script expects this to be downloaded in the container, e.g. to /mnt/store/gameservers/minecraft/mc-test/modpack.zip
    };

    volumes = [
      "/mnt/store/gameservers/minecraft/mc-test:/data"
    ];
  };
}
