# users/bee/default.nix
{
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
    username = "bee";
    homeDirectory = "/home/bee";
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
