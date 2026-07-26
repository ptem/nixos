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
  ];

  # base networking & firewall
  networking.networkmanager.enable = true;

  services.tailscale.enable = true;
  services.tailscale.extraUpFlags = [ "--ssh" ];

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
