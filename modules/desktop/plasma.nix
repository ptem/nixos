# modules/desktop/plasma.nix
{ pkgs, ... }:

{
  # x11 & keyboard
  services.xserver = {
    enable = true;
    xkb.layout = "us";
    xkb.variant = "";
  };

  # plasma 6
  services.displayManager.sddm.enable = true;
  services.desktopManager.plasma6.enable = true;

  # fonts
  console.font = "Lat2-Terminus16";
  fonts = {
    enableDefaultPackages = false;
    packages = with pkgs; [
      material-design-icons
      nerd-fonts.symbols-only
      nerd-fonts.fira-code
      nerd-fonts.jetbrains-mono
      nerd-fonts.iosevka
    ];
    
    fontconfig.defaultFonts = {
      monospace = [ "JetBrains Mono" ];
    };
  };
}
