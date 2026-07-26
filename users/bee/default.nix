# users/bee/default.nix
# User config for 'bee' for all systems. should not directly import any desktop-specific tools.
{ pkgs, ... }:

{
  imports = [
    ../../hm
  ];

  home = {
    username = "bee";
    homeDirectory = "/home/bee";
    stateVersion = "26.05";
  };

  programs.home-manager.enable = true;

  # CLI tools / secret libs
  # TODO: extract anything in here out to hm/ dir
  home.packages = with pkgs; [
    libsecret
  ];

  # Universal CLI paths and variables
  home.sessionVariables = {
    GOPATH = "$HOME/.go";
  };

  home.sessionPath = [
    "$HOME/.go"
    "$HOME/.cargo/bin"
  ];
}
