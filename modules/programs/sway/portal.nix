{ pkgs, lib, ... }: {
  config = {
    xdg.portal = {
      enable = true;
      config = lib.mkForce {
        common = {
          default = [
            "wlr"
          ];
          "org.freedesktop.impl.portal.FileChooser" = [
            "kde"
          ];
          "org.freedesktop.impl.portal.AppChooser" = [
            "gtk"
          ];
        };
      };
      xdgOpenUsePortal = true;
      extraPortals = with pkgs; with plasma5Packages; [
        xdg-desktop-portal-wlr
        xdg-desktop-portal-kde
        xdg-desktop-portal-gtk
      ];
    };
  };
}
