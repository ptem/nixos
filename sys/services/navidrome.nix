# sys/services/navidrome.nix
{ config, pkgs, ... }:

{

  services.navidrome = {
    enable = true;

    settings = {
      Address = "0.0.0.0";
      Port = 4533;

      # TODO: Change This
      MusicFolder = "/home/bee/Music";

      # Performance & transcode tuning
      ScanSchedule = "@every 1h";
      LogLevel = "info";

      # Reverse proxy settings (headers from Caddy on VPS?)
      # ReverseProxyUserHeader = "Remote-User";
    };
  };

  # Systemd hardening/permission handling
  systemd.services.navidrome = {
    serviceConfig = {
      # Gives Navidrome read-only access to the mount point
      # BindReadOnlyPaths = [ "/mnt/media" ];
    };
  };

  networking.firewall.allowedTCPPorts = [ 4533 ];
}
