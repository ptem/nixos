# hm/sway.nix
{
  pkgs,
  lib,
  config,
  ...
}:

{
  # environment.systemPackages = with pkgs; [];
  #

  # Sway configuration is linked from ../cfg/sway/config
  xdg.configFile."sway/config".source = lib.mkForce (
    config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/.dotfiles/cfg/sway/config"
  );

  # Waybar configuration is linked from ../cfg/waybar/config
  xdg.configFile."waybar/config".source = lib.mkForce (
    config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/.dotfiles/cfg/waybar/config"
  );

  wayland.windowManager.sway = {
    enable = true;
    config = null; # Defined in ../cfg/sway

    # allow linking systemd services to sway session
    systemd.enable = true;
  };

  home.packages = with pkgs; [
    wofi # simple launcher menu program (replace with dmenu clone or something)
    swaylock # screen locking utility
    pamixer # pulseaudio cli mixer - https://github.com/cdemoulins/pamixer
    swaybg # wallpaper tool
    mako # notification daemon

    # snip region + copy
    grim
    slurp
    wl-clipboard
  ];

  # wayland services
  programs.waybar.enable = true; # not swaybar
  services.mako.enable = true; # notification daemon

  services.swayidle = {
    enable = true;

    events = {
      before-sleep = "swaylock";
      lock = "swaylock";
    };

    timeouts = [
      {
        timeout = 300;
        command = "swaylock";
      }
      {
        timeout = 600;
        command = "swaymsg 'output * power off'";
        resumeCommand = "swaymsg 'output * power on'";
      }
    ];
  };

  programs.swaylock = {
    enable = true;

    settings = {
      image = "${../users/bee/wallpaper.png}"; # copies file to store
      scaling = "fill";

      # indicator geometry. bro i hate this shit sm
      indicator-radius = 120;
      indicator-thickness = 15;
    };
  };

}
