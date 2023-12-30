{ pkgs, lib, ... }: {
  config =
  let
    dbus-sway-environment = pkgs.writeShellScript "dbus-sway-environment.sh" ''
      ${pkgs.dbus.out}/bin/dbus-update-activation-environment --systemd DISPLAY WAYLAND_DISPLAY SWAYSOCK XDG_CURRENT_DESKTOP=sway
      ${pkgs.systemd.out}/bin/systemctl --user stop pipewire wireplumber xdg-desktop-portal xdg-desktop-portal-wlr xdg-desktop-portal-kde
      ${pkgs.systemd.out}/bin/systemctl --user start pipewire wireplumber xdg-desktop-portal xdg-desktop-portal-wlr xdg-desktop-portal-kde
    '';
  in {
    environment = {
      etc."sway/config".text = lib.mkBefore ''
        exec --no-startup-id ${dbus-sway-environment}
      '';
    };
  };
}
