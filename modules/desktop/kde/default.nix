{
  lib,
  config,
  pkgs,
  ...
}:
{
  imports = [ ./globalshortcuts.nix ];

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

    # For SSSS fix
    nixpkgs.overlays = [
      (final: prev: {
        kdePackages = prev.kdePackages.overrideScope (
          finalScope: prevScope: {
            neochat = prevScope.neochat.overrideAttrs (
              finalAttrs: prevAttrs: {
                version = "unstable";
                src = final.fetchgit {
                  url = "https://invent.kde.org/network/neochat.git";
                  rev = "24480229cd71cd1f62d5c588dca58ddd58cfc3a6";
                  hash = "sha256-YBrsUkVPBi3GVR5sQiPYVtwOHjTcfb3WUXKfIiVOWMo=";
                };
                patches = (prevAttrs.patches or [ ]) ++ [
                  ./0001-Remove-preprocessor-checks-for-SSSSHandler-registrat.patch
                ];
              }
            );
          }
        );
      })
    ];

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
