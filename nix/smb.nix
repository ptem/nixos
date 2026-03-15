# nix/smb.nix
{
  pkgs,
  config,
  superusers,
  users,
  ...
}:

{
  environment.systemPackages = [ pkgs.cifs-utils ];

  age.secrets.smb-secrets = {
    file = ../../secrets/smb-secrets.age;
  };

  fileSystems."/mnt/music" = {
    device = "//proxmox-home/music";
    fsType = "cifs";
    options = [
      "credentials=${config.age.secrets.smb-secrets.path}"
      "uid=1000" # TODO: below
      "gid=100" # TODO: define local music storage group instead and apply to users.
      "_netdev"
      "x-systemd.automount"
      "x-systemd.idle-timeout=60"
      "x-systemd.mount-timeout=10s"
      "noauto"
      "x-systemd.requires=network-online.target"
      "file_mode=0660"
      "dir_mode=0770"
    ];
  };

  fileSystems."/mnt/store" = {
    device = "//proxmox-home/store";
    fsType = "cifs";
    options = [
      "credentials=${config.age.secrets.smb-secrets.path}"
      "uid=1000" # TODO: above
      "gid=100" # TODO: above
      "_netdev"
      "x-systemd.automount"
      "x-systemd.idle-timeout=60"
      "x-systemd.mount-timeout=10s"
      "noauto"
      "x-systemd.requires=network-online.target"
    ];
  };
}
