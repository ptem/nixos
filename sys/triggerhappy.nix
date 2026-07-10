# sys/triggerhappy.nix
# exists literally just so i can do my PTT shenanigans. shouldnt be necessary but WHATEVER.
{ config, pkgs, ... }:

let
  targetUser = "bee";
  userUid = toString config.users.users.${targetUser}.uid;
  userHome = config.users.users.${targetUser}.home;

  pttHandler = pkgs.writeShellScript "ptt-handler.sh" ''
    export XDG_RUNTIME_DIR="/run/user/${userUid}"
    export DBUS_SESSION_BUS_ADDRESS="unix:path=/run/user/${userUid}/bus"

    if [ "$1" = "start" ]; then
      ${pkgs.wireplumber}/bin/wpctl set-mute @DEFAULT_AUDIO_SOURCE@ 0
      ${pkgs.pipewire}/bin/pw-play --volume 0.5 ${userHome}/.local/share/sounds/micsounds/ptt-start.wav
    elif [ "$1" = "stop" ]; then
      ${pkgs.wireplumber}/bin/wpctl set-mute @DEFAULT_AUDIO_SOURCE@ 1
      ${pkgs.pipewire}/bin/pw-play --volume 0.5 ${userHome}/.local/share/sounds/micsounds/ptt-stop.wav
    fi
  '';

  thdConfigFile = pkgs.writeText "triggerhappy.conf" ''
    KEY_F14 1 ${pttHandler} start
    KEY_F14 0 ${pttHandler} stop
  '';

  restartThd = pkgs.writeShellScriptBin "restart-thd.sh" ''
    ${pkgs.systemd}/bin/systemd-run --no-block ${pkgs.systemd}/bin/systemctl restart triggerhappy.service
  '';
in
{
  systemd.services.triggerhappy = {
    description = "Global hotkey daemon";
    wantedBy = [ "multi-user.target" ];
    after = [ "multi-user.target" ];
    serviceConfig = {
      ExecStart = "${pkgs.triggerhappy}/bin/thd --user ${targetUser} --socket /run/thd.socket --triggers ${thdConfigFile} --deviceglob /dev/input/by-id/usb-Logitech_Gaming_Mouse_G600_*-event-*";
    };
  };

  environment.systemPackages = [ restartThd ];

  services.udev.extraRules = ''
    ACTION=="add", SUBSYSTEM=="input", ATTRS{idVendor}=="046d", ATTRS{idProduct}=="c24a", RUN+="${restartThd}/bin/restart-thd.sh"
  '';
}
