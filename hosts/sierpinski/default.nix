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
    ./hardware-configuration.nix

    # system-level definitions
    ../../sys
    ../../sys/network.nix
    ../../sys/system.nix

    # server modules
    # ../../sys/services/tailscale.nix <- maybe bespoke for this machine since talking to VPS?
    ../../sys/services/navidrome.nix
    ../../sys/services/gameservers.nix
    ../../sys/services/immich.nix
    ../../sys/services/samba.nix
  ];

  fileSystems."/mnt/store" = {
    device = "/dev/disk/by-uuid/92ac8dad-0e09-4d66-ae1a-0ab692bc1e86";
    fsType = "ext4";
    options = [
      "defaults"
      "nofail"
      "x-systemd.automount"
      "x-systemd.idle-timeout=600"
    ];
  };

  fileSystems."/mnt/music" = {
    device = "/dev/disk/by-uuid/19442411-371a-4229-96bc-68f973a3ab85";
    fsType = "ext4";
    options = [
      "defaults"
      "nofail"
      "x-systemd.automount"
      "x-systemd.idle-timeout=600"
    ];
  };

  networking.hostName = "sierpinski";
  networking.wireless.enable = lib.mkForce false;

  # Bootloader
  boot.consoleLogLevel = 0;
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  boot.kernelPackages = pkgs.linuxPackages;

  hardware.cpu.intel.updateMicrocode = true;

  services.openssh.enable = true;

  environment.systemPackages = [
    inputs.agenix.packages.${pkgs.stdenv.hostPlatform.system}.default

    pkgs.docker-compose
  ];

  virtualisation.docker.enable = true;

  users.users =
    (lib.genAttrs users (name: {
      isNormalUser = true;
      extraGroups = [
        "users"
        "docker"
      ];
    }))
    // (lib.genAttrs superusers (name: {
      isNormalUser = true;
      extraGroups = [
        "users"
        "wheel"
        "networkmanager"
        "docker"
      ];
    }));

  # Graphics Configuration. Revisit if I ever switch sierpinski to not be headless.
  services.xserver.videoDrivers = [ "nvidia" ];

  hardware.graphics = {
    enable = true;
    enable32Bit = true;
  };

  hardware.nvidia = {
    modesetting.enable = true;
    powerManagement.enable = false;

    open = true;

    # true if i switch to running a desktop on sierpinski
    nvidiaSettings = false;
    package = config.boot.kernelPackages.nvidiaPackages.stable;
  };

  system.stateVersion = "26.05";
}
