{
  lib,
  config,
  pkgs,
  ...
}:
{
  imports = [
    ./globalshortcuts.nix
    ./ssh.nix
  ];

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

    programs.kdeconnect.enable = true;

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
      pkgs.kdePackages.discover
      pkgs.kdePackages.packagekit-qt
    ];

    environment.sessionVariables = {
      NIXOS_OZONE_WL = "1";

      # TODO: Remove this soon? Qt 6.7 or so should fix these bugs
      QT_SCALE_FACTOR_ROUNDING_POLICY = "RoundPreferFloor";
    };

    environment.etc."xdg/KTailctlrc".text = ''
      [Interface]
      peerFilter=tailnet-b8bc.ts.net.
      startMinimized=true
    '';

    xdg.autostart.enable = true;

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
  };
}
