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
<<<<<<< HEAD
      email = "em@axolotlsin.space";
=======
      email = "emily.anible@gmail.com";
>>>>>>> a1a6a0d151ae731f6d15058f2eb38dfa1dcfc82c
    };

    # TODO: config global init.defaultBranch <name>
  };

  programs.gh = {
    enable = true;
    settings.git_protocol = "ssh";
  };

}
