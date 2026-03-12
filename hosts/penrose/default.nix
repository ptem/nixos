# hosts/penrose/default.nix
{ lib, pkgs, inputs, ... }:

{
  imports = [
    # hardware scan
    ./hardware-configuration.nix

    # core system & bridge
    ../../modules/core/system.nix
    ../../modules/core/hm.nix
    ../../modules/core/smb.nix

    # applications  
    ../../modules/audio.nix
    ../../modules/apps
    ../../modules/cli
    
    # desktop env
    ../../modules/desktop/plasma.nix

    # identity
    ../../users/bee/default.nix
  ];

  # hostname & net overrides
  networking.hostName = "penrose";
  networking.wireless.enable = lib.mkForce false;

  # static ssh listen
  services.openssh.listenAddresses = [
    { addr = "100.93.133.61"; port = 22; }
  ];

  # host-specific packages
  environment.systemPackages = [
    inputs.agenix.packages.${pkgs.system}.default
  ];

  # bootloader
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # hardware quirk. for deadlock.
  boot.kernelParams = [ "amdgpu.sg_display=0" ];

  # state version
  system.stateVersion = "25.11";
}
