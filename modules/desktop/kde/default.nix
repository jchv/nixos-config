{
  lib,
  config,
  pkgs,
  ...
}:
let
  kdeGlobals = (
    pkgs.stdenv.mkDerivation {
      name = "kde-globals";
      buildCommand = ''
        mkdir -p $out/etc/xdg/autostart
        mkdir -p $out/share/kglobalaccel
        cp -R ${./autostart}/* $out/etc/xdg/autostart
        cp -R ${./kglobalaccel}/* $out/share/kglobalaccel
      '';
    }
  );
in
{
  options = {
    jchw.desktop.kde = {
      enable = lib.mkEnableOption "KDE desktop";
    };
  };
  config = lib.mkIf config.jchw.desktop.kde.enable {
    environment = {
      systemPackages = [
        kdeGlobals
        pkgs.kdePackages.discover
        pkgs.kdePackages.krfb
        pkgs.kdePackages.packagekit-qt
      ];
      sessionVariables = {
        NIXOS_OZONE_WL = "1";
      };
      etc = {
        "xdg/KTailctlrc".text = ''
          [Interface]
          peerFilter=tailnet-b8bc.ts.net.
          startMinimized=true
        '';
      };
    };
    i18n.inputMethod = {
      enable = true;
      type = "fcitx5";
      fcitx5 = {
        addons = [
          pkgs.fcitx5-anthy
          pkgs.fcitx5-mozc
          pkgs.kdePackages.fcitx5-qt
        ];
        plasma6Support = true;
        waylandFrontend = true;
      };
    };
    programs = {
      ssh.askPassword = "${pkgs.kdePackages.ksshaskpass}/bin/ksshaskpass";
      kdeconnect.enable = true;
      partition-manager.enable = true;
    };
    services = {
      desktopManager.plasma6.enable = true;
      displayManager.sddm = {
        enable = true;
        wayland = {
          enable = true;
          compositor = "kwin";
        };
      };
    };
    xdg = {
      autostart.enable = true;
    };
  };
}
