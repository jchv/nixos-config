{ pkgs, ... }:
{
  imports = [
    ./hardware-configuration.nix
  ];

  config = {
    networking.hostName = "curly";
    system.stateVersion = "23.05";

    boot.initrd.luks.devices.root = {
      name = "root";
      device = "/dev/disk/by-uuid/3b1ce9ad-69f9-460b-9472-799bf03fd423";
      preLVM = true;
      allowDiscards = true;
    };

    jchw.mullvadNs.enable = true;
    jchw.mullvadProxy.enable = true;
    jchw.desktop.kde.enable = true;
    jchw.amdgpu.enable = true;
    jchw.steam.enable = true;
    jchw.android.enable = true;
    jchw.gcadapter.enable = true;
    jchw.wacom.enable = true;
    jchw.brother-ql800.enable = true;

    boot.kernelPackages = pkgs.linuxPackages_latest;
  };
}
