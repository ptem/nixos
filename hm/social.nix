# hm/social.nix
{ pkgs, config, ... }:

{

  home.packages = with pkgs; [
    gajim # xmpp
    # teamspeak6-client
    vesktop
  ];

  xdg.desktopEntries.vesktop = {
    name = "Discord";
    exec = "vesktop --ozone-platform=x11 %U";
    icon = "vesktop";
    terminal = false;
    type = "Application";
    categories = [
      "InstantMessaging"
      "Chat"
    ];
    settings = {
      Keywords = "discord;voice;chat;vesktop;";
    };
  };

}
