# hm/social.nix
{ pkgs, config, ... }:

{

  home.packages = with pkgs; [
    gajim # xmpp
    teamspeak6-client
    vesktop # lightweight/privacy-focused discord client
  ];

}
