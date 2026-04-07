# sys/peripheral.nix
{ pkgs, config, ... }:

{
  environment.systemPackages = with pkgs; [

    # Mouse setup. piper for gui, libratbag provides DBus daemon
    piper
    libratbag
  ];

  # DBus daemon for configuring gaming mice (use with piper for g600)
  services.ratbagd.enable = true;

  # Printing Setup
  services.printing = {
    enable = true;
    logLevel = "error";
  };
  services.colord.enable = true;

  # Printing: IPP Everywhere protocol (port 5353)
  services.avahi = {
    enable = true;
    nssmdns4 = true;
    openFirewall = true;
  };

}
