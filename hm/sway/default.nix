# hm/sway/default.nix
{
  pkgs,
  lib,
  config,
  ...
}:

{

  imports = [
    ./waybar.nix
  ];

  wayland.windowManager.sway = {
    enable = true;
    package = null;
    checkConfig = false;
    systemd.enable = true;

    extraConfig = builtins.readFile ./config;

    config = {
      keybindings = lib.mkForce { };
      modes = lib.mkForce { };
      bars = [ ];
    };

  };

  home.packages = with pkgs; [

    swaybg
    rubyPackages_4_0.gdk_pixbuf2
    imagemagick

    dunst # notification daemon # TODO: this
    libnotify # sends notifs to notif daemon

    # clipboard + history
    wl-clipboard
    cliphist
    xdg-user-dirs

    swayidle
    gtklock
    # swaylock
    # swaylock-plugin
    # wmenu
  ];

  services.dunst = {
    enable = true;
  };

  systemd.user.services.polkit-gnome-authentication-agent-1 = {
    Unit.Description = "polkit-gnome-authentication-agent-1";
    Install.WantedBy = [ "sway-session.target" ];
    Service = {
      Type = "simple";
      ExecStart = "${pkgs.polkit_gnome}/libexec/polkit-gnome-authentication-agent-1";
      Restart = "on-failure";
      RestartSec = 1;
      TimeoutStopSec = 10;
    };
  };

  services.swayidle = {
    enable = true;
    events = {
      before-sleep = "${pkgs.gtklock}/bin/gtklock -d";
    };
    timeouts = [
      {
        timeout = 1200;
        command = "${pkgs.swaylock-plugin}/bin/gtklock -d";
      }
      {
        timeout = 1800;
        command = "${pkgs.sway}/bin/swaymsg 'output * power off'";
        resumeCommand = "${pkgs.sway}/bin/swaymsg 'output * power on'";
      }
    ];
  };

  xdg.configFile."gtklock/style.css".source = ./gtklock-style.css;

  wayland.windowManager.sway.config = {
    colors = {

      # border - color of border around outside edge of title bar
      # background - primary  background of title bar itself
      # text - color of font used for window title text inside title bar
      # indicator - color of split indicator line. on inside edge of focused window
      #             to show  where next tiled application will be placed
      # childBorder - color of border  drawn around actual application window content.

      # Window which currently has the focus
      focused = {
        # border = "#${config.lib.stylix.colors.base04}";
        # background = "#${config.lib.stylix.colors.base04}";
        # text = "#${config.lib.stylix.colors.base00}";
        # indicator = "#${config.lib.stylix.colors.base04}";
        childBorder = lib.mkForce "#${config.lib.stylix.colors.base02}";
        indicator = lib.mkForce "#${config.lib.stylix.colors.base02}";
      };

      # Window which is the focused one in its container, but does not have focus at the moment.
      focusedInactive = {
        childBorder = lib.mkForce "#${config.lib.stylix.colors.base01}";
        indicator = lib.mkForce "#${config.lib.stylix.colors.base01}";
      };

      # Window which is not focused.
      unfocused = {
        childBorder = lib.mkForce "#${config.lib.stylix.colors.base10}";
        indicator = lib.mkForce "#${config.lib.stylix.colors.base10}";
      };

      # Window which has its urgency hint activated.
      urgent = {
        childBorder = lib.mkForce "#${config.lib.stylix.colors.base08}";
        indicator = lib.mkForce "#${config.lib.stylix.colors.base08}";
      };

    };

  };

}
