# hm/sway.nix
{ pkgs, ... }:

{
  # environment.systemPackages = with pkgs; [];
  #

  wayland.windowManager.sway = {
    enable = true;

    # allow linking systemd services to sway session
    systemd.enable = true;

    config = rec {
      modifier = "Mod4";
      terminal = "kitty";

      # kb layout/config
      input."*" = {
        xkb_layout = "us";
      };

      startup = [
        # Launch Firefox on start
        { command = "firefox"; }
      ];
    };
  };

  # Kanshi - dynamic output configuration
  services.kanshi = {
    enable = true;
    systemdTarget = "sway-session.target";
    profiles = {
      default = {
        outputs = [
          {
            criteria = "*";
            status = "enable";
          }
        ];
      };
    };
  };

}
