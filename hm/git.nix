# hm/git.nix
{ pkgs, ... }:
{
  home.packages = with pkgs; [
    delta # git --diff
    lazygit # lazy staging
  ];

  programs.git = {
    enable = true;

    settings.user = {
      name = "ptem";
      email = "em@axolotlsin.space";
    };

    # TODO: config global init.defaultBranch <name>
  };

  programs.gh = {
    enable = true;
    settings.git_protocol = "ssh";
  };

}
