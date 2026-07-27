# sys/services/navidrome.nix
{ config, pkgs, ... }:

{
  services.navidrome = {
    enable = true;
    settings = {
      MusicFolder = "/mnt/music/music";
      EnableTranscodingConfig = true;
      EnableSharing = true;
      DefaultShareExpiration = "8760h";
      LyricsPriority = ".lrc,.txt,embedded";
      PluginsEnabled = true;
      Address = "0.0.0.0";

      Scanner = {
        Schedule = "@every 30m";
      };
    };

    plugins = with pkgs.navidromePlugins; [
      listenbrainz-daily-playlist
    ];

  };

  systemd.services.navidrome.serviceConfig = {
    ProtectSystem = "strict";
    ProtectHome = true;
    PrivateTmp = true;
    PrivateDevices = true;
    NoNewPrivileges = true;
    LockPersonality = true;
    RestrictRealtime = true;
    RestrictNamespaces = true;
    MemoryDenyWriteExecute = false;

    ReadWritePaths = [ "/var/lib/navidrome" ];
    ReadOnlyPaths = [ "/mnt/music" ];

    RestrictAddressFamilies = [
      "AF_UNIX"
      "AF_INET"
      "AF_INET6"
    ];
    SystemCallFilter = [
      "@system-service"
      "~@privileged"
      "~@resources"
    ];
  };

  # Ensure navidrome user can read the music directory
  users.users.navidrome.extraGroups = [ "users" ];

  networking.firewall.allowedTCPPorts = [ 4533 ];

  # Backups
  # To view snapshots: sudo restic -r /mnt/store/backup/sierpinski/navidrome --password-file /run/agenix/restic snapshots (or 'latest' instead of 'snapshots')
  # Create temp location, restore from latest backup: mkdir -p /tmp/restored-backup && sudo restic -r /mnt/store/backup/sierpinski/navidrome --password-file /run/agenix/restic restore <latest> --target /tmp/restored-backup
  # Restore specific files: sudo restic -r /mnt/store/backup/sierpinski/navidrome --password-file /run/agenix/restic restore latest --target /tmp/restored-backup --include /var/lib/navidrome/navidrome_dump.db
  age.secrets."restic".file = ../../secrets/restic.age;

  services.restic.backups.navidrome = {
    initialize = true;
    repository = "/mnt/store/backup/sierpinski/navidrome";
    passwordFile = config.age.secrets."restic".path;

    paths = [
      "/var/lib/navidrome"
    ];

    # extraBackupArgs = [
    #   "--exclude=/var/lib/navidrome/cache"
    #   "--exclude=/var/lib/private/navidrome/cache"
    #   "--exclude=/var/lib/navidrome/navidrome.db"
    #   "--exclude=/var/lib/navidrome/navidrome.db-shm"
    #   "--exclude=/var/lib/navidrome/navidrome.db-wal"
    # ];

    pruneOpts = [
      "--keep-daily 7"
      "--keep-weekly 4"
      "--keep-monthly 6"
    ];

    timerConfig = {
      OnCalendar = "daily";
      Persistent = true;
    };

    backupPrepareCommand = ''
      ${pkgs.sqlite}/bin/sqlite3 /var/lib/navidrome/navidrome.db ".backup '/var/lib/navidrome/navidrome_dump.db'"
    '';

    backupCleanupCommand = ''
      rm -f /var/lib/navidrome/navidrome_dump.db
    '';
  };

}
