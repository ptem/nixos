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

  home.shellAliases = {
    nfu = "git add . && nix flake update && git add flake.lock";
    nrs = "sudo nixos-rebuild switch --flake ~/.dotfiles#penrose";
  };
  

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

  # Symlink so that ffxiv/dalamud can install on bdrive
  home.file.".xlcore" = {
    source = config.lib.file.mkOutOfStoreSymlink "/mnt/bdrive/Games/.xlcore";
  };
}
