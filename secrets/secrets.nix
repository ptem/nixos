# secrets/secrets.nix
# utilized by agenix to store secrets.
let
  bee = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIPkyNXPC76tKcKtfZQa+aNDuxzzJ4nlqfR/4FCZoo72X bee@penrose"; # bee ssh pub
  penrose = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIM6NcAJ4N7sqLG4Id8KH5Hsxxvsv94ad5pWBKpJqaXQq root@penrose"; # root ssh pub
  sierpinski = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIPkyNXPC76tKcKtfZQa+aNDuxzzJ4nlqfR/4FCZoo72X bee@sierpinski"; # homelab
  sierpinski-rt = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIHlmGmWzyUBEBplkVQkcNoO6jmcMDlD60Xvtt+V7qQCR root@sierpinski"; # homelab rt
in
{
  "samba.age".publicKeys = [
    bee
    penrose
    sierpinski
  ];
  "restic.age".publicKeys = [
    bee
    penrose
    sierpinski
    sierpinski-rt
  ];
  "navidrome.age".publicKeys = [
    bee
    penrose
    sierpinski
    sierpinski-rt
  ];
}
