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
      email = "13301888+ptem@users.noreply.github.com";
    };

    # TODO: config global init.defaultBranch <name>
  };

  programs.gh = {
    enable = true;
    settings.git_protocol = "ssh";
  };

}
