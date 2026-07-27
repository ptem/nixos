{ config, pkgs, ... }:

{
  users.users.autumn = {
    isNormalUser = true;
    description = "autumn";
  };

  services.samba = {
    enable = true;
    openFirewall = true;

    settings = {
      global = {
        "workgroup" = "WORKGROUP";
        "server string" = "sierpinski";
        "security" = "user";

        "hosts allow" = "127.0.0.1 192.168.1.0/24 100.64.0.0/10";
        "hosts deny" = "0.0.0.0/0";
      };

      "store" = {
        "path" = "/mnt/store";
        "browseable" = "yes";
        "read only" = "no";
        "guest ok" = "no";
        "valid users" = "autumn bee";
        "force user" = "bee";
      };

      "music" = {
        "path" = "/mnt/music";
        "browseable" = "yes";
        "read only" = "no";
        "guest ok" = "no";
        "valid users" = "autumn bee";
        "force user" = "bee";
      };

    };
  };

  services.samba-wsdd = {
    enable = true;
    openFirewall = true;
  };
}
