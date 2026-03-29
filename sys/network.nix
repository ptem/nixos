# sys/network.nix
{
  pkgs,
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

  # base networking & firewall
  networking.networkmanager.enable = true;

  services.tailscale.enable = true;

  networking.firewall = {
    enable = true;
    trustedInterfaces = [ "tailscale0" ];
    allowedTCPPorts = [ 57218 ];
    allowedUDPPorts = [ 57218 ];
    checkReversePath = "loose";
  };

  # SSH
  services.openssh = {
    enable = true;
    settings = {
      PasswordAuthentication = false;
      KbdInteractiveAuthentication = false;
      PermitRootLogin = "no";
      AllowUsers = [ "bee" ];
    };
  };

  # SSH intrusion prevention
  services.fail2ban.enable = true;

}
