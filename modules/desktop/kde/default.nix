{
  lib,
  config,
  pkgs,
  ...
}:
{
  options = {
    jchw.desktop.kde = {
      enable = lib.mkEnableOption "KDE desktop";
    };
  };

  config = lib.mkIf config.jchw.desktop.kde.enable {
    services = {
      desktopManager.plasma6.enable = true;
      displayManager.sddm = {
        enable = true;
        wayland.enable = true;
      };
    };

    environment.systemPackages = [
      (pkgs.stdenv.mkDerivation {
        name = "kde-global";
        buildCommand = ''
          mkdir -p $out/etc/xdg/autostart
          mkdir -p $out/share/kglobalaccel
          cp -R ${./autostart}/* $out/etc/xdg/autostart
          cp -R ${./kglobalaccel}/* $out/share/kglobalaccel
        '';
      })
    ];

    environment.sessionVariables = {
      NIXOS_OZONE_WL = "1";
    };

    xdg.autostart.enable = true;

    programs.ssh = {
      startAgent = true;
      enableAskPassword = true;
      askPassword = "${pkgs.kdePackages.ksshaskpass}/bin/ksshaskpass";
    };

    i18n.inputMethod = {
      enabled = "fcitx5";
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
  };
}
