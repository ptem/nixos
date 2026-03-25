# sys/system.nix
{
  lib,
  pkgs,
  superusers,
  ...
}:

{
  # nix package manager
  nixpkgs.config.allowUnfree = true;

  nix = {
    settings = {
      trusted-users = superusers;
      download-buffer-size = 524288000; # 500mb
      auto-optimise-store = true;
      experimental-features = [
        "nix-command"
        "flakes"
      ];
    };
    gc = {
      automatic = lib.mkDefault true;
      dates = lib.mkDefault "weekly";
      options = lib.mkDefault "--delete-older-than 7d";
    };
  };

  # locale & time
  time.timeZone = "America/New_York";
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

  # base networking & firewall
  # TODO: move networking to standalone module
  networking.networkmanager.enable = true;
  services.tailscale.enable = true;

  networking.firewall = {
    enable = true;
    trustedInterfaces = [ "tailscale0" ];
    checkReversePath = "loose";
  };

  # base services
  services.openssh = {
    enable = true;
    settings = {
      PasswordAuthentication = false;
      KbdInteractiveAuthentication = false;
      PermitRootLogin = "prohibit-password";
    };
  };

  services.printing.enable = true; # TODO: peripheral support, technically.
  services.ratbagd.enable = true;

  # base system packages
  environment.systemPackages = with pkgs; [
    protonvpn-gui # TODO: move to user or desktop env. not applicable for headless use.
    piper # TODO: same thing.
    libratbag # TODO: peripheral support, also move.

    # need frame one
    git
    curl
    gnused
  ];
}
