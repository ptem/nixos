# sys/sway.nix
{ pkgs, lib, ... }:

{

  # Required for integrating sway at system level
  programs.sway = {
    enable = true;
    wrapperFeatures.gtk = true;
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
    gtklock = { };
  };

  # Keyring manager
  programs.seahorse.enable = true;

  # greetd - login manager daemon
  # must initialize as login shell and source ~/.profile + Home Manager sessions vars into  memory, hence execution `bash -l -c [sway]`
  services.greetd = {
    enable = true;
    settings = {
      default_session = {
        command = "${pkgs.tuigreet}/bin/tuigreet --remember-session --time --asterisks --greeting '.remember our promise.' --cmd 'bash -l -c sway'";
        user = "greeter";
      };
    };
  };

  xdg.portal = {
    enable = true;
    wlr.enable = true;

    wlr.settings = {
      screencast = {
        chooser_type = "simple";
        chooser_cmd = "${pkgs.slurp}/bin/slurp -f %o -or";
        max_fps = 60;
        force_mod_linear = 1;
        damage_tracking = 0;
      };
    };

    config.sway = {
      default = [ "gtk" ];
      "org.freedesktop.impl.portal.ScreenCast" = [ "wlr" ];
      "org.freedesktop.impl.portal.Screenshot" = [ "wlr" ];
    };

    extraPortals = with pkgs; [
      xdg-desktop-portal-gtk
    ];

    config.common.default = "*";
  };

  # GTK things
  programs.dconf.enable = true;

  environment.sessionVariables = {
    NIXOS_OZONE_WL = "1";
    MOZ_ENABLE_WAYLAND = "1";

    SDL_VIDEODRIVER = "wayland";
    _JAVA_AWT_WM_NONREPARENTING = "1";
  };

  environment.systemPackages = with pkgs; [
    sway
    polkit_gnome

    fuzzel
    slurp
    grim
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
