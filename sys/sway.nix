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

  # Sway requires polkit.
  security.polkit.enable = true;

  # Enable the gnome-keyring secrets vault.
  # Will be exposed through DBus to programs willing to store secrets.
  services.gnome.gnome-keyring.enable = true;

  services.dbus.packages = [ pkgs.gcr ];

  security.pam.services = {
    login.enableGnomeKeyring = true;
    greetd.enableGnomeKeyring = true;
    swaylock-plugin = { };
  };

  # Keyring manager
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
        command = "${pkgs.tuigreet}/bin/tuigreet --time --asterisks --greeting '.remember our promise.' --cmd \"bash -l -c '${pkgs.swayfx}/bin/sway > /dev/null 2>&1'\"";
        user = "greeter";
      };
    };
  };

  xdg.portal = {
    enable = true;
    wlr.enable = true;
    extraPortals = [ pkgs.xdg-desktop-portal-gtk ];
    config.common.default = "*";
  };

  # GTK things
  programs.dconf.enable = true;

  environment.sessionVariables = {
    NIXOS_OZONE_WL = "1";
    MOZ_ENABLE_WAYLAND = "1";

    ELECTRON_OZONE_PLATFORM_HINT = "auto";

    SDL_VIDEODRIVER = "wayland";
    _JAVA_AWT_WM_NONREPARENTING = "1";
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

  # Gives greetd a temp home. Not really needed but I don't like seeing bad logs.
  systemd.tmpfiles.rules = [
    "d /var/lib/greetd/.cache 0750 greeter greetd -"
    "d /var/lib/greetd/.local/share/keyrings 0700 greeter greetd -"
  ];

}
