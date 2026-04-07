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

  # host-specific packages
  environment.systemPackages = [
    inputs.agenix.packages.${pkgs.stdenv.hostPlatform.system}.default
  ];

  programs.ssh.askPassword = lib.mkForce "${pkgs.seahorse}/libexec/seahorse/ssh-askpass";

  boot.kernelPackages = pkgs.linuxPackages_latest;
  boot.initrd.kernelModules = [ "amdgpu" ];
  # bootloader
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.consoleLogLevel = 0;

  boot.kernelParams = [
    "amdgpu.sg_display=0"
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
