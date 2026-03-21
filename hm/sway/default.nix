# hm/sway.nix
{
  pkgs,
  lib,
  config,
  ...
}:

{

  # Waybar configuration is linked from ../cfg/sway/waybar-config.jsonc
  # xdg.configFile."waybar/config".source = lib.mkForce (
  #  config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/.dotfiles/hm/sway/waybar-config.jsonc"
  # );

  # Waybar style.css is linked from ../cfg/sway/waybar-style.css
  # xdg.configFile."waybar/style.css".source = lib.mkForce (
  #  config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/.dotfiles/hm/sway/waybar-style.css"
  # );

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

  programs.waybar = {
    enable = true;
  };

  home.packages = with pkgs; [
    pamixer # pulseaudiCo cli mixer - https://github.com/cdemoulins/pamixer

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
    swaylock
    # wmenu
  ];

  programs.swaylock = {
    enable = true;

    settings = {
      # indicator geometry. bro i hate this shit sm
      indicator-radius = 120;
      indicator-thickness = 15;
    };
  };

  services.dunst = {
    enable = true;
  };

}
