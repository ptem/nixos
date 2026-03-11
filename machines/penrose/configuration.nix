# machines/penrose/configuration.nix
# Primary entrypoint for penrose machine. Bootloader settings, hostnames, machine-wide packages (that aren't already global)
{ 
  lib,
  config, 
  pkgs, 
  inputs, 
  ... 
}: 

{
  imports = [ 
    # Defaults used for all my machines
    ../../modules/system.nix

    # Hardware scan results
    ./hardware-configuration.nix 
  ];

  age.secrets.smb-secrets = {
    file = ../../secrets/smb-secrets.age;
  };

  # ======================                                                                                                                              
  # Networking                                                                                                                                          
  # ======================    

  networking.hostName = "penrose";
  networking.wireless.enable = lib.mkForce false;

  services.openssh = {
    listenAddresses = [
      { addr = "100.93.133.61"; port = 22; }
    ];
  };


  # ======================                                                                                                                              
  # Machine-specific Packages                                                                                                                              
  # ======================

  environment.systemPackages = with pkgs; [
    inputs.agenix.packages.${pkgs.system}.default
    # Packages specific to this machine but not global to all machines
  ];

  programs.steam = {
    enable = true;
    remotePlay.openFirewall = true; # Open ports in fw for Steam Remote Play
    dedicatedServer.openFirewall = true; # Open ports in fw for Source Dedicated Server
    extraCompatPackages = with pkgs; [ proton-ge-bin ];
  };

  programs.nix-ld.enable = true;

  # ======================                                                                                                                              
  # Boot                                                                                                                                          
  # ======================
    
  boot.loader = {
    systemd-boot.enable = true;
    efi.canTouchEfiVariables = true;
  };


  # ======================                                                                                                                              
  # Graphics                                                                                                                              
  # ======================

  hardware.graphics = {
    enable = true;
    enable32Bit = true;
    extraPackages = with pkgs; [
      # amdvlk - deprecated
      libva-vdpau-driver
      libvdpau-va-gl
      
      # obs-studio-plugins.obs-vkcapture
    ];    

    extraPackages32 = with pkgs; [
      pkgsi686Linux.obs-studio-plugins.obs-vkcapture
    ];
  };



  # ======================                                                                                                                              
  # Storage                                                                                                                                          
  # ======================
/*
  # Bee Drive
  fileSystems."/mnt/beedr" = {
    device = "/dev/disk/by-uuid/b33a466e-6a95-4c26-bffe-b73406304270";
    fsType = "ext4";
    options = [ 
      "nofail" 
      "x-systemd.device-timeout=5s" 
    ];
  };
*/
  # LAN-Mounted Navidrome share
  fileSystems."/mnt/music" = {
    device = "//proxmox-home/music"; # Tailscale nameres (if weird just use local ip) 
    fsType = "cifs";
    options = [
      "credentials=/run/agenix/smb-secrets"
      "uid=1000"       
      "gid=100"        
      "file_mode=0644"
      "dir_mode=0755"
      "noserverino"
      "x-systemd.automount"
      "noauto"
      "_netdev"
      "user"
      "x-gvfs-hide"
    ];
  };  

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "25.11"; # Did you read the comment?

}
