# hm/sway/waybar.nix
{
  lib,
  ...
}:

{
  programs.waybar = {
    enable = true;
    systemd.enableInspect = true;
  };

  # https://github.com/Alexays/Waybar/wiki/Configuration
  # https://github.com/nix-community/home-manager/blob/release-25.11/modules/programs/waybar.nix
  # https://home-manager-options.extranix.com/?query=waybar&release=release-25.11
  programs.waybar.settings = lib.mkForce [
    {
      layer = "top";
      position = "top";
      height = 20;
      width = 2300;
      margin-top = 3;

      # output = [ "DP-1" "DP-2" ];

      #########
      # layout
      #########

      modules-left = [
        "sway/workspaces"
        "sway/mode"
        "sway/scratchpad"
      ];
      modules-center = [
        "sway/window"
      ];
      modules-right = [
        "image#album-art"
        "mpris"
        "tray"
        "pulseaudio"
        "clock"
      ];

      #########
      # modules
      #########

      "sway/workspaces" = {
        all-outputs = false;
        disable-scroll = true;
        format = "{icon} {name}";
        format-icons = {
          "1" = "";
          "2" = "";
          "4" = "";
          # "5" = "";
          "6" = "";
          "urgent" = "";
          "focused" = "";
          "default" = "";
          "high-priority-named" = [
            "1"
            "2"
          ];
        };
      };

      "sway/mode" = {

      };

      "sway/scratchpad" = {
        show-empty = false;
        format-icons = [
          ""
          ""
        ];
        format = "{icon} {count}";
      };

      "sway/window" = {
        max-length = 120;
        format = "{}";
      };

      "image#album-art" = {
        exec = "~/.dotfiles/hm/sway/waybar-albumart.sh";
        on-click = "swaymsg '[app_id=\"feishin\"] focus'";
        size = 20;
        interval = 5;
        tooltip = true;
        tooltip-format = "~";
      };

      "mpris" = {
        interval = 1;
        format = "{title} - {artist} {status_icon} [{position}:{length}]";
        format-paused = "{title} - {artist} {status_icon} [{position}:{length}]";
        player-icons = {
          default = ">";
        };
        status-icons = {
          playing = ">>";
          paused = "::";
        };
        ignored-players = [
          "firefox"
          "firefox.instance_1_79"
          "librewolf"
          "youtube"
        ];
      };

      "pulseaudio" = {
        format = "{icon}  {volume}%";
        format-bluetooth = "{icon}  {volume}%";
        format-muted = "  00%";
        format-icons = {
          default = [
            ""
            ""
          ];
        };
        on-click = "swaymsg '[app_id=\"com.saivert.pwvucontrol\"] kill' || pwvucontrol";
      };

      "tray" = {
        icon-size = 20;
        spacing = 5;
        show-passive-items = true;
        icons = {
          feishin = "<svg>/<svg>";
        };
      };

      "clock" = {
        format = "{:%m/%d/%Y %H:%M}";
        interval = 10;
        tooltip-format = "{calendar}";
        calendar = {
          "mode" = "year";
          "mode-mon-col" = 3;
          "weeks-pos" = "right";
          "on-scroll" = 1;
          "format" = {
            "months" = "<span color='#ffead3'><b>{}</b></span>";
            "days" = "<span color='#ecc6d9'><b>{}</b></span>";
            "weeks" = "<span color='#99ffdd'><b>W{}</b></span>";
            "weekdays" = "<span color='#ffcc66'><b>{}</b></span>";
            "today" = "<span color='#ff6699'><b><u>{}</u></b></span>";
          };
        };
        actions = {
          on-click-right = "mode";
          on-scroll-up = "shift_up";
          on-scroll-down = "shift_down";
        };
      };

    }
  ];

  # can write the CSS for the waybar here or just path literal to file.
  programs.waybar.style = builtins.readFile ./waybar-style.css;

}
