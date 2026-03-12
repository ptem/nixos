# modules/shell/util.nix
{ pkgs, ... }:

{
  # system-wide utils
  environment.systemPackages = with pkgs; [
    git 
    wget 
    curl 
    jq 
    pciutils 
    usbutils
    bat # cat but good
  ];

  home = {
    home.packages = with pkgs; [
      # sysinfo & fetch
      fastfetch btop ncdu dust iotop iftop sysstat lm_sensors glow cowsay
      
      # file management
      nnn zip unzip xz eza tree file lsof
      
      # search
      ripgrep fd fzf which strace ltrace
      
      # network
      mtr iperf3 ldns nmap ipcalc socat ethtool
      
      # nix tools
      nix-output-monitor yq-go
    ];

    # shell & aliases
    programs.bash.enable = true;
    
    home.shellAliases = {
      ll = "eza -l --icons --git -a";
      ltree = "eza --tree --level=4 --icons";
      top = "btop";
      nfu = "git add . && nix flake update && git add flake.lock";
      # swapped hardcoded 'penrose' for dynamic hostname evaluation
      nrs = "sudo nixos-rebuild switch --flake ~/.dotfiles#$(hostname)";

      refresh-plasma = "fc-cache -f && systemctl --user restart plasma-plasmashell.service";
      
    };

    # nano
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
      bind Sh-M-d "{cut}{up}{paste}{up}" main
      bind M-d "{cut}{down}{paste}{up}" main
      bind ^D "{copy}{paste}{up}" main
    '';
  };
}
