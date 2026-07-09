# sys/file.nix
{
  pkgs,
  ...
}:

{
  programs.thunar = {
    enable = true;

    plugins = with pkgs; [
      thunar-archive-plugin
      thunar-volman
      thunar-media-tags-plugin
    ];
  };

  environment.systemPackages = with pkgs; [
    file-roller
  ];

  # for configuration of thunar since not using xfce
  programs.xfconf.enable = true;

  services.gvfs.enable = true; # mnt, trash, etc.
  services.udisks2.enable = true;
  services.tumbler.enable = true; # thumbnail support
}
