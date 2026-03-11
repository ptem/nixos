 # home-manager/core.nix                                                                                                                    
 # baseline user settings required for home manager + universal tools
{
  pkgs,
  ...
}:
{
  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;


  # Home Manager needs information about you and the paths it should manage
  home = {
   /*
    sessionVariables = {
      EDITOR = "nano"; # lol
    };
   */
  };

}
