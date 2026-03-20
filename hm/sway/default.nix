# hm/sway.nix
{
  pkgs,
  lib,
  config,
  ...
}:

let
  # select wallpaper in ..style/assets
  wallpaper = "wallpaper-1.png";
in
{
  # environment.systemPackages = with pkgs; [];
  #

  # Sway configuration is linked from ../cfg/swaw/config
  xdg.configFile."sway/config".source = lib.mkForce (
    config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/.dotfiles/hm/sway/config"
  );

  # Waybar configuration is linked from ../cfg/sway/waybar-config.jsonc
  xdg.configFile."waybar/config".source = lib.mkForce (
    config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/.dotfiles/hm/sway/waybar-config.jsonc"
  );

  # Waybar style.css is linked from ../cfg/sway/waybar-style.css
  xdg.configFile."waybar/style.css".source = lib.mkForce (
    config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/.dotfiles/hm/sway/waybar-style.css"
  );

  wayland.windowManager.sway = {
    enable = true;
    package = pkgs.swayfx;
    # config = null; # Defined in ../cfg/sway

    # allow linking systemd services to sway session
    systemd.enable = true;

    # HIGH VELOCITY RAYTRACING SHADOW CASTING RTX ON

  };

  home.packages = with pkgs; [
    pamixer # pulseaudio cli mixer - https://github.com/cdemoulins/pamixer

    swaybg # wallpaper tool

    dunst # notification daemon
    libnotify # sends notifs to daemon

    fuzzel # launcher/fzf

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

  # wayland services
  programs.waybar.enable = true; # not swaybar
  services.mako.enable = true; # notification daemon

  programs.swaylock = {
    enable = true;

    settings = {
      image = "${../../style/assets/${wallpaper}}"; # copies file to store
      scaling = "fill";

      # indicator geometry. bro i hate this shit sm
      indicator-radius = 120;
      indicator-thickness = 15;
    };
  };

  services.dunst = {
    enable = true;

    # iconTheme = {
    #   name = "string";
    #   package = pkgs.package;
    #   size = 20;
    # };

    # settings = {
    #   global.icon_path = "path/to/look/for/icons";
    # };

    # # sets dunst's `WAYLAND_DISPLAY` env var
    # waylandDisplay = "sets {env} WAYLAND_DISPLAY var";
  };

}
