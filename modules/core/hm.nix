# modules/core/hm.nix
{ lib, config, username, ... }:

{
  # define the custom home option
  options.home = lib.mkOption {
    # https://nixos.org/manual/nixos/stable/index.html#sec-option-types deferredModule
    type = lib.types.deferredModule;
    default = {};
    description = "alias for home-manager user config";
  };

  # route alias to home-manager user
  config = {
    home-manager.users.${username} = config.home;
    
    # global home manager defaults
    home-manager.useGlobalPkgs = true;
    home-manager.useUserPackages = true;

    # in case there's a funny conflict again between ~ configs and home-manager configs
    home-manager.backupFileExtension = "backup";
  };  
}
