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
    ../../sys/audio.nix
    ../../sys/plasma.nix
    ../../sys/smb.nix
    ../../sys/system.nix
  ];

  # graphics & wine compat
  hardware.graphics = {
    enable = true;
    enable32Bit = true;
    extraPackages = with pkgs; [
      libva-vdpau-driver
      libvdpau-va-gl
    ];
  };

  programs.nix-ld.enable = true;

  # steam as system service
  programs.steam = {
    enable = true;
    remotePlay.openFirewall = true;
    dedicatedServer.openFirewall = true;
    extraCompatPackages = with pkgs; [ proton-ge-bin ];
  };

  # hostname & net overrides
  networking.hostName = "penrose";
  networking.wireless.enable = lib.mkForce false;

  # static ssh listen
  services.openssh.listenAddresses = [
    {
      addr = "100.93.133.61";
      port = 22;
    }
  ];

  # host-specific packages
  environment.systemPackages = [
    inputs.agenix.packages.${pkgs.stdenv.hostPlatform.system}.default
  ];

  # bootloader
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # hardware quirk. for deadlock.
  boot.kernelParams = [ "amdgpu.sg_display=0" ];

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
