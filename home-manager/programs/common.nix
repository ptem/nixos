{ 
  pkgs,
  ...
}:

{
  # Programs with minimal config
  home.packages = with pkgs; [
    jq
    fd
    ripgrep
    tree
    nano
  ];


  # Programs with dedicated Home Manager modules
  programs.bash.enable = true;

  
  # Nano                                                                                                                                                
  home.file.".nanorc".text = ''                                                                                                                                                                                                   
      set tabsize 2                                                                                                                                     
      set tabstospaces                                                                                                                                  
      set autoindent                                                                                                                                    
      set indicator                                                                                                                                     
      set linenumbers                                                                                                                                   
      set numbercolor grey,black                                                                                                                        
      set titlecolor white,black                                                                                                                        
      set matchbrackets "(<[{)>]}"                                                                                                                      
                                                                                                                                                        
      include ${pkgs.nano}/share/nano/*.nanorc                                                                                                          
                                                                                                                                                        
      bind Sh-M-d "{cut}{up}{paste}{up}"  main ## Shift-Alt-D - Move Line Up        
      bind M-d "{cut}{down}{paste}{up}"   main ## Alt-D - Move Line Down 
      bind ^D "{copy}{paste}{up}"         main ## Ctrl-D - Duplicate Line       
    '';

  
}
