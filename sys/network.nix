# sys/network.nix
{
  pkgs,
  config,
  lib,
  ...
}:

{
  environment.systemPackages = with pkgs; [
    vopono
    libnatpmp
    wireguard-tools
    iproute2
    openresolv

    # Wrapped home-level applications in their relevant hm/ nix files.
    # Wrapped system-level applications below:

  ];

  systemd.services.vopono = {
    description = "Vopono Namespace Daemon";
    wantedBy = [ "multi-user.target" ];
    wants = [ "network-online.target" ];
    after = [ "network-online.target" ];
    path = [
      pkgs.vopono
      pkgs.libnatpmp
      pkgs.wireguard-tools
      pkgs.iproute2
      pkgs.iptables
      pkgs.openresolv
    ];

    serviceConfig = {
      ExecStart = "${pkgs.vopono}/bin/vopono daemon";
      Restart = "on-failure";
      User = "root";
    };

  };

}
