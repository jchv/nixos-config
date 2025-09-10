{ pkgs, ... }:
{
  imports = [
    ./hardware-configuration.nix
  ];

  config = {
    boot = {
      initrd.luks.devices.root = {
        name = "root";
        device = "/dev/disk/by-uuid/3b1ce9ad-69f9-460b-9472-799bf03fd423";
        preLVM = true;
        allowDiscards = true;
      };
      kernelPackages = pkgs.linuxPackages_latest;
    };
    hardware = {
      amdgpu.opencl.enable = true;
    };
    jchw = {
      desktop.kde.enable = true;
      vpn.namespace.enable = true;
      vpn.proxy.enable = true;
    };
    networking.hostName = "curly";
    system.stateVersion = "23.05";
    virtualisation.vmware.host.enable = true;
  };
}
