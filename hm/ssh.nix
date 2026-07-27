# hm/ssh.nix
{ ... }:
{
  programs.ssh = {
    enable = true;
    enableDefaultConfig = false;

    settings."*".AddKeysToAgent = "yes";
  };

}
