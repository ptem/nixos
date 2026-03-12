{ config, pkgs, username, ... }:

{
  home = {
    # pywal16 packages + color methods
    home.packages = with pkgs; [
      (pywal16.overrideAttrs (oldAttrs: {
        propagatedBuildInputs = (oldAttrs.propagatedBuildInputs or []) ++ [
          python3Packages.haishoku
          python3Packages.modern-colorthief
          python3Packages.fast-colorthief
          python3Packages.colorthief
        ];
      }))
      
      colorz
    ];

    # seems nice
    home.shellAliases = {
      theme-ghostty = "wal -i ~/.dotfiles/users/bee/wallpaper.jpg --saturate 0.45 --contrast 4.5 --cols16 \"darken\" --backend haishoku";
    };

    programs.ghostty = {
      enable = true;
      
      enableBashIntegration = true; 
      enableZshIntegration = true;

      settings = {
        # Visuals
        theme = "/home/${username}/.cache/wal/ghostty.conf";
        config-file = "/home/${username}/.cache/wal/ghostty.conf"; # additional config for pywal16
        font-family = "IBM Plex Mono";
        font-style = "Text";
        font-size = 12;
                
        
        # IBM Plex Mono Type
        font-feature = [
          # "ss01" # single-story a
          "ss02" # single-story g 
          "ss03" # slashed 0
        ];

        
        
        # Window Management
        # gtk-titlebar-style = true;
        window-padding-x = 8;
        window-padding-y = 8;
        window-decoration = true;
      
        
        background-opacity = 0.78;
        background-blur = true;

        # background = 
          
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
