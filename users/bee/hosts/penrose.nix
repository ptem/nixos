# users/bee/hosts/penrose.nix
# specific programs for penrose applied to bee's profile.
{ 
  config, 
  pkgs,
  ...
}:

{
  # Import [bee] baseline profile
  imports = [
    ../home.nix
  ];

  # Packages specific to [bee], only on [nixos] host
  home.packages = with pkgs; [

    # Chat
    gajim
    teamspeak6-client

    # Media
    feishin
    streamlink
    nicotine-plus

    # Kate editor (TO BE REMOVED GET OUT GET OUT GET OUT)
    stable.kdePackages.kate

    # Games
    stable.xivlauncher
  ];

}
