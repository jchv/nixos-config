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
          "org.freedesktop.impl.portal.OpenURI" = [
            "kde"
          ];
        };
      };
      xdgOpenUsePortal = true;
      extraPortals = with pkgs; [
        xdg-desktop-portal-wlr
        plasma5Packages.xdg-desktop-portal-kde
      ];
    };
  };
}
