# sys/audio.nix
{ ... }:

{
  # realtime prio for audio. surely this fixes crackling.
  security.rtkit.enable = true;

  services.pipewire = {
    enable = true;
    audio.enable = true; # use as primary sound server
    jack.enable = true; # JACK audio emulation routes JACK requests thru pipewire.

    alsa.enable = true; # routes audio from apps that output ALSA to pipewire
    alsa.support32Bit = true;

    pulse.enable = true; # PulseAudio compat layer. allows legacy apps to communicate w/ pipewire.
    wireplumber.enable = true;

  };

}
