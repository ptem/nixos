# hm/git.nix
{ ... }:
{
  programs.git = {
    enable = true;

    settings = {
      user = {
        name = "ptem";
        email = "13301888+ptem@users.noreply.github.com";
      };

      init = {
        defaultBranch = "main";
      };
    };
  };

  programs.gh = {
    enable = true;
    settings.git_protocol = "ssh";
  };

}
