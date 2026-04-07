# sys/sway.nix
{ pkgs, ... }:

{

  # Required for integrating sway at system level
  programs.sway = {
    enable = true;
    wrapperFeatures.gtk = true;
    package = pkgs.swayfx;

    # remove default packages. declared in hm/sway.nix
    extraPackages = [ ];
  };

  # polkit required for sway
  security.polkit.enable = true;
  security.pam.services.swaylock-plugin = { };

  # Enable the gnome-keyring secrets vault.
  # Will be exposed through DBus to programs willing to store secrets.
  services.gnome.gnome-keyring.enable = true;
  security.pam.services.login.enableGnomeKeyring = true;
  security.pam.services.greetd.enableGnomeKeyring = true;
  programs.seahorse.enable = true;

  # realtime priority to help with latency/stuttering in high load scenarios (per nixos wiki)
  security.pam.loginLimits = [
    {
      domain = "@users";
      item = "rtprio";
      type = "-";
      value = 1;
    }
  ];

  # greetd - login manager daemon
  # must initialize as login shell and source ~/.profile + Home Manager sessions vars into  memory, hence execution `bash -l -c [sway]`
  # some things [like cursors] don't seem to get respected if set later if this isn't done
  services.greetd = {
    enable = true;
    settings = {
      default_session = {
        command = "${pkgs.tuigreet}/bin/tuigreet --time --asterisks --greeting '.remember our promise.' --cmd \"bash -l -c ${pkgs.swayfx}/bin/sway\"";
        user = "greeter";
      };
    };
  };

  # GTK things
  programs.dconf.enable = true;

  # Graphics
  hardware.graphics = {
    enable = true;
    enable32Bit = true;
    extraPackages = with pkgs; [
      libva-vdpau-driver
      libvdpau-va-gl
    ];
  };

  environment.sessionVariables = {
    AMD_DEBUG = "wsi_force_bgra8_unorm=0";
    NIXOS_OZONE_WL = "1"; # force electron/chromium apps to use wl
  };

  environment.systemPackages = with pkgs; [
    sway
  ];

  users.users.greeter = {
    extraGroups = [
      "video"
      "input"
    ];
  };

}
