{ config, pkgs, ... }:
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
in {
  config = {
    services.upower.enable = true;
    environment.etc."sway/config".text = ''
        # Idle timeout
        exec ${pkgs.swayidle.out}/bin/swayidle -w \
            timeout 750 '${swaylockCommand}' \
            timeout 800 '${swayDPMSOff}' \
            timeout 900 '${sleepIfOnBattery}' \
            resume '${swayDPMSOn}' \
            idlehint 750 \
            before-sleep '${beforeSleep}'

        bindsym $mod+l exec ${swaylockCommand}
    '';
  };
}
