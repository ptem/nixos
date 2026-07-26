# hosts/sierpinski/default.nix
{
  lib,
  pkgs,
  inputs,
  users,
  superusers,
  config,
  ...
}:

{
  imports = [
    # hardware scan
    # ./hardware-configuration.nix

    # system-level definitions
    ../../sys
    ../../sys/network.nix
    ../../sys/system.nix

    # server modules
    # ../../sys/services/tailscale.nix <- maybe bespoke for this machine since talking to VPS?
    ../../sys/services/navidrome.nix
  ];

  networking.hostName = "sierpinski";
  networking.wireless.enable = lib.mkForce false;

  # Bootloader
  boot.consoleLogLevel = 0;
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  boot.kernelPackages = pkgs.linuxPackages;

  services.openssh.enable = true;

  users.users =
    (lib.genAttrs users (name: {
      isNormalUser = true;
      extraGroups = [ "users" ];
    }))
    // (lib.genAttrs superusers (name: {
      isNormalUser = true;
      extraGroups = [
        "users"
        "wheel"
        "networkmanager"
      ];
    }));

  system.stateVersion = "26.05";
}
