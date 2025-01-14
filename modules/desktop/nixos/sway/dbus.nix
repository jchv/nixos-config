{
  config,
  pkgs,
  lib,
  ...
}:
{
  config =
    let
      dbus-sway-environment = pkgs.writeShellScript "dbus-sway-environment.sh" ''
        ${pkgs.dbus.out}/bin/dbus-update-activation-environment --systemd --all
        ${pkgs.systemd.out}/bin/systemctl --user stop pipewire wireplumber xdg-desktop-portal xdg-desktop-portal-wlr xdg-desktop-portal-gtk
        ${pkgs.systemd.out}/bin/systemctl --user start pipewire wireplumber xdg-desktop-portal xdg-desktop-portal-wlr xdg-desktop-portal-gtk
      '';
    in
    lib.mkIf config.jchw.desktop.sway.enable {
      environment = {
        etc."sway/config".text = lib.mkBefore ''
          # DBus graphical environment
          exec --no-startup-id ${dbus-sway-environment}
        '';
      };
    };
}
