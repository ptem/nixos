# sys/samba.nix
{
  pkgs,
  config,
  superusers,
  users,
  ...
}:

{
  environment.systemPackages = [ pkgs.cifs-utils ];

  age.secrets.samba = {
    file = ../secrets/samba.age;
  };

  fileSystems."/mnt/music" = {
    device = "//sierpinski/music";
    fsType = "cifs";
    options = [
      "credentials=${config.age.secrets.samba.path}"
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
    device = "//sierpinski/store";
    fsType = "cifs";
    options = [
      "credentials=${config.age.secrets.samba.path}"
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
