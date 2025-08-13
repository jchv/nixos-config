{ pkgs, ... }:
{
  imports = [
    ./hardware-configuration.nix
  ];

  config = {
    boot = {
      initrd = {
        luks.devices.root = {
          name = "root";
          device = "/dev/disk/by-uuid/9300b4b3-8127-4ae4-9853-22c94aa5ce89";
          preLVM = true;
          allowDiscards = true;
        };
        kernelModules = [
          "surface_hid_core"
          "surface_hid"
          "surface_aggregator_registry"
          "surface_aggregator"
          "8250_dw"
          "pinctrl_tigerlake"
          "intel_lpss"
          "intel_lpss_pci"
        ];
      };
    };
    environment = {
      systemPackages = [ pkgs.surface-control ];
    };
    services = {
      logind.extraConfig = ''
        # Power key on Surface is really stupid and easy to hit. Ignore it.
        HandlePowerKey=ignore
      '';
      iptsd.enable = true;
    };
    jchw = {
      desktop.kde.enable = true;
    };
    networking.hostName = "taiga";
    system.stateVersion = "22.05";
  };
}
