# hm/media.nix
{ config, pkgs, ... }:

{
  home.packages = with pkgs; [
    ffmpeg

    # consume the content
    feishin
    streamlink
    nicotine-plus # alt: wrapped w/ vopono

    # track management
    yt-dlp
    exiftool
    opustags
    wrtag
    picard

    # audio
    playerctl
    #mpd

    # images
    qview

    # wraps nicotine with vopono to assign temp network namespace under vpn.
    # alerts forwarded port + applies to nicotine config before launch.
    # should probably abstract this a bit into its own script if I ever want to use it for other stuff, but this is fine for now.
    # doesn't currently update the port after launch if it inevitably changes, nor does it alert. should handle the latter.
    # nicotine definitely won't allow for the former, but perhaps another client or recotine can.
    # (symlinkJoin {
    #   name = "nicotine-plus-vopono";
    #   paths = [ nicotine-plus ];
    #   buildInputs = [ makeWrapper ];
    #   postBuild =
    #     let
    #       launcherScript = pkgs.writeShellScript "nicotine-vopono-launcher" ''
    #         if [ -n "$VOPONO_FORWARDED_PORT" ]; then
    #           echo -n "$VOPONO_FORWARDED_PORT" | ${pkgs.wl-clipboard}/bin/wl-copy
    #           ${pkgs.libnotify}/bin/notify-send "Vopono" "Forwarded Port: $VOPONO_FORWARDED_PORT\n(Copied to Clipboard)"

    #           CONFIG_FILE="$HOME/.config/nicotine/config"
    #           if [ -f "$CONFIG_FILE" ]; then
    #             ${pkgs.gnused}/bin/sed -i "s/^portrange = .*/portrange = ($VOPONO_FORWARDED_PORT, $VOPONO_FORWARDED_PORT)/" "$CONFIG_FILE"
    #             ${pkgs.libnotify}/bin/notify-send "Vopono" "Wrote $VOPONO_FORWARDED_PORT to config."
    #           fi
    #         fi

    #         exec ${nicotine-plus}/bin/nicotine
    #       '';
    #     in
    #     ''
    #       wrapProgram $out/bin/nicotine \
    #         --run 'exec ${pkgs.vopono}/bin/vopono -v exec --provider custom \
    #         --custom ${config.home.homeDirectory}/.dotfiles/secrets/vopono-nixos-penrose.conf \
    #         --protocol wireguard \
    #         --custom-port-forwarding protonvpn \
    #         "${launcherScript}" \
    #         >> ${config.home.homeDirectory}/.cache/vopono-nicotine.log 2>&1'
    #     '';
    # })

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

  # music player daemon
  services.mpd = {
    enable = true;
    musicDirectory = "/mnt/music/music";

    network.listenAddress = "any";
    network.startWhenNeeded = true;

    extraConfig = "";
  };
}
