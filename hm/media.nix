# hm/media.nix
{ pkgs, ... }:

{
  home.packages = with pkgs; [
    ffmpeg

    # consume the content
    # feishin
    streamlink
    nicotine-plus

    # track management
    yt-dlp
    exiftool
    opustags
    wrtag

    # audio
    pulsemixer
    playerctl

    # images
    qview
  ];

  programs.bash.initExtra = ''
    # ffopus( "filename.xyz" ) -> filename.opus
    ffopus() {
      ffmpeg -hide_banner -i "$1" -vn -c:a libopus -b:a 160k -vbr on "''${1%.*}.opus"
    }
  '';

  # simple video player
  programs.mpv = {
    enable = true;
    defaultProfiles = [ "high-quality" ];
    scripts = [ pkgs.mpvScripts.mpris ];

    config = {
      vo = "gpu-next";
    };
  };
}
