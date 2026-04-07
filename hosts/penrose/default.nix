# hosts/penrose/default.nix
{
  lib,
  pkgs,
  inputs,
  users,
  superusers,
  ...
}:

{
  imports = [
    # hardware scan
    ./hardware-configuration.nix

    # system-level definitions
    ../../sys
    ../../sys/audio.nix
    ../../sys/peripheral.nix

    ../../sys/smb.nix
    ../../sys/system.nix
    ../../sys/steam.nix

    ../../sys/network.nix

    ../../sys/sway.nix
  ];

  programs.nix-ld.enable = true;

  # hostname & net overrides
  networking.hostName = "penrose";
  networking.wireless.enable = lib.mkForce false;

  services.openssh.enable = true;

  hardware.bluetooth.enable = true;
  services.blueman.enable = true;

  hardware.enableRedistributableFirmware = true;

  # host-specific packages
  environment.systemPackages = [
    inputs.agenix.packages.${pkgs.stdenv.hostPlatform.system}.default
  ];

  programs.ssh.askPassword = lib.mkForce "${pkgs.seahorse}/libexec/seahorse/ssh-askpass";

  # Bootloader
  boot.consoleLogLevel = 0;
  boot.initrd.verbose = false;
  boot.loader = {
    systemd-boot.enable = true;
    efi.canTouchEfiVariables = true;

    timeout = 5;
  };

  # Kernel
  boot.kernelPackages = pkgs.linuxPackages_latest;
  boot.initrd.kernelModules = [ "amdgpu" ];

  boot.kernelParams = [
    "amdgpu.sg_display=0"

    # Perhaps handling the 9070xt SMU issue
    "amdgpu.cwsr_enable=0"

    "quiet"
    "udev.log_priority=4"
    "rd.udev.log_priority=3"
    "vt.global_cursor_default=0"
    "boot.shell_on_fail"
  ];

  # openrgb service
  services.hardware.openrgb.enable = true;
  services.hardware.openrgb.motherboard = "amd";

  security.sudo.extraRules = [
    {
      groups = [ "wheel" ];
      commands = [
        {
          command = "ALL";
          options = [ "NOPASSWD" ];
        }
      ];
    }
  ];

  security.sudo.extraConfig = ''
    Defaults env_keep += "VOPONO_FORWARDED_PORT VOPONO_HOST_IP VOPONO_NS_IP VOPONO_NS DBUS_SESSION_BUS_ADDRESS WAYLAND_DISPLAY XDG_RUNTIME_DIR DISPLAY"
  '';

  # Users of Penrose
  users.users =
    (lib.genAttrs users (name: {
      isNormalUser = true;
      extraGroups = [
        "users"
      ];
    }))
    // (lib.genAttrs superusers (name: {
      isNormalUser = true;
      extraGroups = [
        "users"
        "networkmanager"
        "wheel"
      ];
    }));

  # state version
  system.stateVersion = "25.11";
}
