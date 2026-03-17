{ pkgs, ... }:

{
  home.packages = with pkgs; [
    beets
    termusic # for easier playing. TODO: find alternative
  ];

  programs.beets = {
    enable = true;

    mpdIntegration = {
      enableStats = false;
      enableUpdate = false;
    };

    settings = {
      directory = "~/slsk/beets/library"; # where beets stores music files
      library = "~/slsk/beets/library.db"; # where beets stores its db file
      import = {
        copy = false; # during import, copies cleaned-up music into directory vs. just correcting tags on music.
        move = true; # during import, moves cleaned-up music into directory instead of copy
        write = true; # modify tags on music vs. leave alone (stores tags in db)
        resume = "ask";
      };

      paths = {
        default = "$albumartist/[$year] $album/$track - $title";
      };

      plugins = "musicbrainz fetchart inline discogs lyrics edit mbsync";

      fetchart = {
        auto = true;
        cover_names = "cover front album folder";
      };

      musicbrainz = {
        data_source_mismatch_penalty = 0.3;
        host = "musicbrainz.org";
        https = "no";
        ratelimit = 1;
        genres = true;
        external_ids = {
          discogs = true;
          bandcamp = true;
        };
      };

      discogs = {
        data_source_mismatch_penalty = 0.9;
      };

      lyrics = {
        auto = true;
        dist_thresh = 0.05;
        fallback = null;
        force = false;

        print = true;
        sources = [
          "lrclib"
          # "google" # TODO: API Key
          "genius"
          "netease"
        ];
        synced = true; # only from lrclib, apparently.
      };

    };

  };

}
