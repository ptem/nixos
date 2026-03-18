# hm/git.nix
{ ... }:
{
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
