# sys/amdgpu.nix
{ pkgs, ... }:

{
  # See ../hosts/penrose/default.nix for amd kernel params and modules.

  # Graphics tweaks for my 9070XT + 7770X
  environment.systemPackages = with pkgs; [
    amdgpu_top
    lact
  ];

  # Graphics
  hardware.graphics = {
    enable = true;
    enable32Bit = true;
    extraPackages = with pkgs; [
      rocmPackages.clr.icd
      libva

      # legacy
      libvdpau-va-gl
    ];
  };

  environment.sessionVariables = {
    # RDNA4 DCC
    AMD_DEBUG = "nodisplaydcc";
  };

  services.lact.enable = true;

  # openrgb service
  services.hardware.openrgb.enable = true;
  services.hardware.openrgb.motherboard = "amd";

}
