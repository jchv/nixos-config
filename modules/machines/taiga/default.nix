{ pkgs, ... }:
{
  imports = [
    ./hardware-configuration.nix
  ];

  config = {
    networking.hostName = "taiga";
    system.stateVersion = "22.05";

    boot.initrd.luks.devices.root = {
      name = "root";
      device = "/dev/disk/by-uuid/9300b4b3-8127-4ae4-9853-22c94aa5ce89";
      preLVM = true;
      allowDiscards = true;
    };

    services.logind.extraConfig = ''
      # Power key on Surface is really stupid and easy to hit. Ignore it.
      HandlePowerKey=ignore
    '';

    jchw.autosuspend = true;
    jchw.desktop.sway.enable = true;
    jchw.android.enable = true;
    jchw.brother-ql800.enable = true;

    services.iptsd.enable = true;
    environment.systemPackages = [ pkgs.surface-control ];

    boot.initrd.kernelModules = [
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
}
