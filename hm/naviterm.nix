{
  pkgs,
  inputs,
  lib,
  ...
}:

{
  home.packages = [
    inputs.naviterm.packages.${pkgs.stdenv.hostPlatform.system}.default
  ];

  xdg.configFile."naviterm/config.ini".text = ''
    server_address=http://navi:4533
    user=emily
    password_store=secretservice
    server_auth=token
    mpv_path=${lib.getExe pkgs.mpv}
    replay_gain=auto
    primary_accent=red
    secondary_accent=gray
    home_list_size=30
    follow_cursor_queue=true
    draw_while_unfocused=true
    save_player_status=true
    use_dbus=true
    wait_for_ipc_ms=200
    mpv_custom_args=
    album_list_api=v1
    reorder_random_queue=false
    parser_type=json
  '';
}
