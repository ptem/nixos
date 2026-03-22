# hm/sway/default.nix
{
  pkgs,
  lib,
  ...
}:

{

  imports = [
    ./waybar.nix # waybar configuration
    ./fuzzel.nix
  ];

  wayland.windowManager.sway = {
    enable = true;
    package = pkgs.swayfx;
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
    pamixer # pulseaudio cli mixer - https://github.com/cdemoulins/pamixer

    swaybg # wallpaper tool
    rubyPackages_4_0.gdk_pixbuf2
    imagemagick

    dunst # notification daemon # TODO: this
    libnotify # sends notifs to daemon

    fuzzel # launcher/fzf # TODO: this

    # snip region
    grim
    slurp

    # clipboard + history
    wl-clipboard
    # wl-clipboard-history # TODO: not in nixpkgs. is just a bash script, can re-implement -- https://github.com/janza/wl-clipboard-history

    # auto-included packages:
    brightnessctl # currently not really useful. only has kb/mic lights.
    # foot
    # grim
    pulseaudio
    swayidle
    # swaylock
    # swaylock-plugin
    # wmenu
  ];

  programs.swaylock = {
    enable = true;

    package = pkgs.swaylock-plugin;

    settings = {
      show-failed-attempts = true;
      # show-keyboard-layout = true;
      indicator-caps-lock = true;
      # font = "";
      # font-size = 24;
      indicator-idle-visible = false;
      indicator-radius = 100;
      indicator-thickness = 5;
      # indicator-x-position = 0;
      # indicator-y-position = 0;
      line-uses-inside = true;
      line-uses-ring = false;
    };
  };

  services.dunst = {
    enable = true;
  };

}
