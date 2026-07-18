# sys/audio.nix
{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    qpwgraph
  ];

  # realtime prio for audio.
  security.rtkit.enable = true;

  services.pipewire = {
    enable = true;
    audio.enable = true; # use as primary sound server
    jack.enable = true; # JACK audio emulation routes JACK requests thru pipewire.

    alsa.enable = true; # routes audio from apps that output ALSA to pipewire
    alsa.support32Bit = true;

    pulse.enable = true; # PulseAudio compat layer. allows legacy apps to communicate w/ pipewire.
    wireplumber.enable = true;

    extraConfig.pipewire = {
      "99-desktop-group-sink" = {
        "context.objects" = [
          {
            factory = "adapter";
            args = {
              "factory.name" = "support.null-audio-sink";
              "node.name" = "desktop-group-bus";
              "node.description" = "Desktop Applications Bus";
              "media.class" = "Audio/Sink";
              "audio.position" = "FL,FR";
              "monitor.channel-volumes" = "true";
            };
          }
        ];
      };
    };
  };
}
