# users/bee/default.nix
{ username, ... }:

{
  # nixos user account
  users.users.${username} = {
    isNormalUser = true;
    description = username;
    extraGroups = [ "networkmanager" "wheel" "users" ];

    # TODO: hashed pw w/ agenix?
  };

  # home-manager identity metadata
  home = {
    home.username = username;
    home.homeDirectory = "/home/${username}";
    home.stateVersion = "25.11";
  };
}
