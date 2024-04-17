{
  lib,
  config,
  pkgs,
  ...
}:
let
  onBattery = pkgs.writeShellScript "onBattery" ''
    set -e
    [ "$(upower -i /org/freedesktop/UPower/devices/DisplayDevice | grep --color=never state: | tr -s ' '  | cut -d ' ' -f 3)" = "discharging" ]
  '';
  sleepIfOnBattery = pkgs.writeShellScript "sleepIfOnBattery" ''
    if [ ${onBattery} ]; then
      systemctl suspend
    fi
  '';
  swaylockCommand = "${pkgs.swaylock.out}/bin/swaylock -f -c 000000";
  pauseAllPlayers = "${pkgs.playerctl.out}/bin/playerctl --all-players pause";
  swayDPMSOff = pkgs.writeShellScript "swayDPMSOff" ''
    ${config.programs.sway.package.out}/bin/swaymsg "output * dpms off"
  '';
  swayDPMSOn = pkgs.writeShellScript "swayDPMSOn" ''
    ${config.programs.sway.package.out}/bin/swaymsg "output * dpms on"
  '';
  beforeSleep = pkgs.writeShellScript "beforeSleep" ''
    ${swaylockCommand}
    ${pauseAllPlayers}
  '';
in
{
  options = {
    jchw.autosuspend = lib.mkOption {
      type = lib.types.bool;
      default = false;
    };
  };

  config = {
    services.upower.enable = true;
    environment.etc."sway/config".text =
      let
        suspendTimeout = lib.optionalString config.jchw.autosuspend "timeout 900 '${sleepIfOnBattery}'";
      in
      ''
        # Idle timeout
        exec ${pkgs.swayidle.out}/bin/swayidle -w \
            timeout 600 '${swayDPMSOff}' resume '${swayDPMSOn}' \
            timeout 610 '${swaylockCommand}' \
            ${suspendTimeout} \
            idlehint 300 \
            before-sleep '${beforeSleep}'

        bindsym $mod+l exec ${swaylockCommand}
      '';
  };
}
