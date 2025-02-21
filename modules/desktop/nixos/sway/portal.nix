{
  config,
  pkgs,
  lib,
  ...
}:
{
  config = lib.mkIf config.jchw.desktop.sway.enable {
    xdg.portal = {
      enable = true;
      config = lib.mkForce {
        common = {
          default = [ "wlr" ];
          "org.freedesktop.impl.portal.FileChooser" = [ "kde" ];
          "org.freedesktop.impl.portal.AppChooser" = [ "gtk" ];
        };
      };
      xdgOpenUsePortal = true;
      extraPortals = [
        pkgs.xdg-desktop-portal-hyprland
        pkgs.kdePackages.xdg-desktop-portal-kde
        pkgs.xdg-desktop-portal-gtk
      ];
    };
    nixpkgs.overlays = [
      (final: prev: {
        discord = final.symlinkJoin {
          name = "discord";
          paths = [
            (final.writeShellScriptBin "Discord" ''
              export GTK_USE_PORTAL=1
              exec ${prev.discord}/bin/Discord "$@"
            '')
            (final.writeShellScriptBin "discord" ''
              export GTK_USE_PORTAL=1
              exec ${prev.discord}/bin/discord "$@"
            '')
            prev.discord
          ];
        };
      })
    ];
  };
}
