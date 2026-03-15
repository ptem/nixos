# nix/audio.nix
{ ... }:

{
  # realtime prio for audio. surely this fixes crackling.
  security.rtkit.enable = true;

  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;

    # TODO: enable when livecoding setup
    jack.enable = false;
  };
}
