# users/bee/home.nix                                                                                                                                
# universal user profile for bee. applied to every machine.
{ 
  config, 
  pkgs, 
  username,
  ... 
}:


{
  imports = [
    ../../home-manager/core.nix
    ../../home-manager/programs # include all entries in home-manager/programs.
    
  ];

  programs.git = {
    enable = true;
    
    settings = {
      user.name = "ptem";
      user.email = "emily.anible@gmail.com";
    };
  };


   home = {
    username = username;
    homeDirectory = "/home/${username}";


    # This value determines the Home Manager release that your 
    # configuration is compatible with. This helps avoid breakage
    # when a new Home Manager release introduces backwards incompatible changes. 
    # 
    # You can update Home Manager without changing this value. See 
    # the Home Manager release notes for a list of state version
    # changes in each release.
    stateVersion = "25.11";
   };
  
}
