{
  pkgs,
  lib,
  username,
  ...
}: 
{
  # ======================
  # User
  # ======================
  
  # Define user account
  users.users.${username} = {
    isNormalUser = true;
    description = username;
    extraGroups = [ "networkmanager" "wheel" "users" ];
  };


  # ======================
  # Nix
  # ======================

  nix.settings.trusted-users = [username];


  nix.settings = {
    download-buffer-size = 524288000; # 500mb download buffer
    auto-optimise-store = true;
  
    # enable flakes
    experimental-features = ["nix-command" "flakes"];

    # substituters = [
    #   # cache mirrors, etc.
    # ]
  };

  nix.gc = {
    automatic = lib.mkDefault true;
    dates = lib.mkDefault "weekly";
    options = lib.mkDefault "--delete-older-than 7d";
  };

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;


  # ======================
  # System Settings
  # ======================

  # Time zone
  time.timeZone = "America/New_York";

  # Select internationalization properties
  i18n.defaultLocale = "en_US.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_US.UTF-8";
    LC_IDENTIFICATION = "en_US.UTF-8";
    LC_MEASUREMENT = "en_US.UTF-8";
    LC_MONETARY = "en_US.UTF-8";
    LC_NAME = "en_US.UTF-8";
    LC_NUMERIC = "en_US.UTF-8";
    LC_PAPER = "en_US.UTF-8";
    LC_TELEPHONE = "en_US.UTF-8";
    LC_TIME = "en_US.UTF-8";
  };


  # libratbag, DBus daemon to configure input devices
  services.ratbagd.enable = true;

  
  # Fonts 
  fonts = {
    packages = with pkgs; [
      
      material-design-icons

      # nerdfonts
      # https://github.com/NixOS/nixpkgs/blob/nixos-unstable-small/pkgs/data/fonts/nerd-fonts/manifests/fonts.json
      nerd-fonts.symbols-only # symbols icon only
      nerd-fonts.fira-code
      nerd-fonts.jetbrains-mono
      nerd-fonts.iosevka
      
    ];

    enableDefaultPackages = false;

    # user defined fonts
    fontconfig.defaultFonts = {
      monospace = [ "JetBrains Mono" ];
    };
  };

  console.font = "Lat2-Terminus16";
  

  # ======================
  # Window Manager
  # ======================
  
  # Enable X11 windowing system
  services.xserver.enable = true;

  # Configure keymap in X11
  services.xserver.xkb = {
    layout = "us";
    variant = "";
  };

  # Enable KDE Plasma DEE
  services.displayManager.sddm.enable = true;
  services.desktopManager.plasma6.enable = true;


  
  # ======================
  # Audio
  # ======================
                                                                                                                                                     
  # pipewire                                                                                                                         
  services.pulseaudio.enable = false;                                                                                                                   
  security.rtkit.enable = true;                                                                                                                         

  services.pipewire = {                                                                                                                                 
    enable = true;                                                                                                                                      
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    # If you want to use JACK applications, uncomment this
    #jack.enable = true;
  
    # use the example session manager (no others are packaged yet so this is enabled by default,
    # no need to redefine it in your config for now)
    # media-session.enable = true;
  };


  # ======================
  # Networking
  # ======================
 
  networking.networkmanager.enable = true;  


  # Tailscale
  services.tailscale.enable = true;


  # OpenSSH
  services.openssh = {
    enable = true;

    settings = {
      PasswordAuthentication = false;
      KbdInteractiveAuthentication = false;
      PermitRootLogin = "prohibit-password";
    };
  };
  

  # Firewall settings
  networking.firewall = {
    enable = true;
    
    allowedTCPPorts = [ ];
    allowedUDPPorts = [ ];


    # Let tailscale vibe.
    trustedInterfaces = [ "tailscale0" ];
    checkReversePath = "loose";
  };
  

  # ======================
  # Other
  # ======================
  
  # Enable CUPS to print documents.
  services.printing.enable = true;


  # ======================
  # System Packages
  # ======================

  environment.systemPackages = with pkgs; [
    git
    wget
    curl

    piper           # GUI tool for ratbag (g600t buttons)
    libratbag

    tailscale
    openssh
    protonvpn-gui

    # vulkan-tools
    # protonup-qt   # Manage multiple proton installs

    cifs-utils      # Allows mounting/managing smb/cifs shares
    ntfs3g          # NTFS mount support
  ];
  
}
