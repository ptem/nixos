# secrets/secrets.nix
# utilized by agenix to store secrets.
let
  bee = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIPkyNXPC76tKcKtfZQa+aNDuxzzJ4nlqfR/4FCZoo72X bee@penrose";      # bee ssh pub
  penrose = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIM6NcAJ4N7sqLG4Id8KH5Hsxxvsv94ad5pWBKpJqaXQq root@penrose"; # root ssh pub
in
{
  "smb-secrets.age".publicKeys = [ bee penrose ];
}
