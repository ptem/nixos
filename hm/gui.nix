# hm/gui.nix
# GUI tools that don't gave a better home on their own
{ pkgs, ... }:

{
  home.packages = with pkgs; [
    pwvucontrol # pipewire volume control applet

    hyprpicker # color picker
    wayfreeze # freeze wlroots compositor
    slurp
    grim
  ];

  home.shellAliases = {
    glurp-frz = ''FILE=$(xdg-user-dir PICTURES)/grim/$(date +%Y%m%d-%H%M%S_grim_frz.png); wayfreeze & PID=$!; sleep .1; grim -g "$(slurp)" "$FILE" && wl-copy < "$FILE"; kill $PID'';
  };
}
