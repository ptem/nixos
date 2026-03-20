# users/bee/default.nix
{
  username,
  lib,
  pkgs,
  inputs,
  ...
}:

{

  imports = [
    # default hm imports
    ../../hm
  ];

  home = {
    username = username;
    homeDirectory = "/home/${username}";
    stateVersion = "25.11";
  };

  # use home manager
  programs.home-manager.enable = true;

  home.packages = [ pkgs.libsecret ];

  # Nonspecific HM environment vars. No better place to put these rn.
  home.sessionVariables = {
    GOPATH = "$HOME/.go";
  };

}
