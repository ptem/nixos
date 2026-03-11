{
  pkgs,
  config,
  username,
  ...
}:
{

  programs = {

    firefox = {
      enable = true; # TODO: Anything else.
    };
    
  };
}
