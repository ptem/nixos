{ 
  pkgs,
  ...
}:

{
  # Programs with minimal config
  home.packages = with pkgs; [
  
    fastfetch           # sysinfo
    nnn                 # terminal file manager
    zip                 # zip
    unzip               # de-zip
    xz                  # zip 2
    
    ripgrep             # 'rg' - recursive text search (replaces grep)
    fd                  # Find
    fzf                 # Fuzzy finder
    file                # Determines file types
    which               # Shows full path of shell commands
    tree                # Dir tree
    jq                  # Command-line JSON processor
    yq-go               # YAML/XML processor

    eza                 # 'ls' replacement
    btop                # 'htop' replacement
    ncdu                #  ncurses disk usage analyzer
    dust                # 'dust' disk usage tree

    mtr                 # ping and traceroute
    iperf3              # Tool for measuring maximum TCP/UDP bandwidth perf
    ldns                # 'drill' (good dig)
    nmap                # Network discovery / sec. aud tool
    ipcalc              # IPv4/IPv6 address and subnet calc
    socat               # Multipurpose relay

    nix-output-monitor  # 'nom' - makes Nix builds easier to read
    iotop               # Monitor disk I/O usage
    iftop               # Monitor network bandwidth usage
    sysstat             # Performance monitoring tools (sar, iostat, mpstat)
    lm_sensors          # 'sensors' - check CPU temperatures and fan speeds
    ethtool             # Utility for examining and tuning network interface settings
    pciutils            # 'lspci' - list all PCI devices
    usbutils            # 'lsusb' - list all USB devices
                        
    strace              # Trace system calls and signals
    ltrace              # Trace library calls
    lsof                # "List Open Files" - what's using a file/port
    glow                # Terminal .md renderer
    cowsay              # moo
   

    nano                # bad editor

  ];


  # Programs with dedicated Home Manager modules
  programs.bash.enable = true;

  home.shellAliases = {
    ll = "eza -l --icons --git -a";
    ltree = "eza --tree --level=4 --icons";

    top = "btop";
  };
  
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
