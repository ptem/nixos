{ config, pkgs, ... }:

{
  home = {
    programs.ghostty = {
      enable = true;
      
      enableBashIntegration = true; 
      enableZshIntegration = true;

      settings = {
        # Visuals
        theme = "Catppuccin Mocha";
        font-family = "JetBrains Mono";
        font-size = 11;
        
        # Window Management
        window-padding-x = 8;
        window-padding-y = 8;
        window-decoration = false;
      
        
        background-opacity = 0.8;  
        /*
        # Native Splits - Vim-style navigation
        keybind = [
          # Create splits
          "ctrl+shift+enter=new_split:auto"
          "ctrl+shift+d=new_split:right"
          "ctrl+shift+e=new_split:down"
          
          # Navigate splits
          "ctrl+shift+h=goto_split:left"
          "ctrl+shift+j=goto_split:bottom"
          "ctrl+shift+k=goto_split:top"
          "ctrl+shift+l=goto_split:right"
          
          # Resize splits
          "ctrl+shift+left=resize_split:left,10"
          "ctrl+shift+right=resize_split:right,10"
          "ctrl+shift+up=resize_split:up,10"
          "ctrl+shift+down=resize_split:down,10"
        ];
        */
      };
    };
  };
}
