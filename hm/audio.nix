{ pkgs, ... }:

{
  home.packages = with pkgs; [
    pwvucontrol
  ];

  xdg.configFile."wireplumber/wireplumber.conf.d/51-user-rules.conf".text = ''
    wireplumber.settings = {
       # Config
    }
  '';

}
