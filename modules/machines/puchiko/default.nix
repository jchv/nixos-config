{ pkgs, ... }:
{
  imports = [
    ./hardware-configuration.nix
  ];

  config = {
    boot = {
      initrd.luks.devices.root = {
        name = "root";
        device = "/dev/disk/by-uuid/8484c3df-4843-48ed-85ea-0d1e38bc7ea7";
        preLVM = true;
        allowDiscards = true;
      };
      kernelPackages = pkgs.linuxPackages_latest;
    };
    jchw = {
      desktop.kde.enable = true;
    };
    networking.hostName = "puchiko";
    services = {
      logind.extraConfig = ''
        HandlePowerKey=suspend
      '';
      thermald.enable = true;
      tlp.enable = true;
    };
    system.stateVersion = "23.05";
  };
}
