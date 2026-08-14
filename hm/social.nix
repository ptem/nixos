# hm/social.nix
{ pkgs, config, ... }:

{

  home.packages = with pkgs; [
    gajim # xmpp
    # teamspeak6-client
    vesktop
  ];

  xdg.desktopEntries.vesktop = {
    name = "Vesktop";
    exec = "env XDG_SESSION_TYPE=x11 WAYLAND_DISPLAY= vesktop --ozone-platform=x11 --disable-features=WebRTCPipeWireCapturer %U";
    icon = "vesktop";
    terminal = false;
    type = "Application";
    categories = [
      "Network"
      "InstantMessaging"
      "Chat"
    ];
    settings = {
      Keywords = "vesktop;discord;voice;chat;";
    };
  };

  # xdg.desktopEntries."vesktop-wlr" = {
  #   name = "Vesktop (wl/wlr)";
  #   exec = "vesktop --ozone-platform-hint=auto --enable-features=WaylandWindowDecorations %U";
  #   icon = "vesktop";
  #   terminal = false;
  #   type = "Application";
  #   categories = [
  #     "Network"
  #     "InstantMessaging"
  #     "Chat"
  #   ];
  #   settings = {
  #     Keywords = "vesktop;discord;voice;chat;wayland;wlr;";
  #   };
  # };

}
