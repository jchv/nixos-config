{
  imports = [
    ./hardware-configuration.nix
    ../../base
    ../../desktop
    ../../programs
    ../../users
    ../../hardware/android.nix
    ../../hardware/brother-ql800.nix
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

    microsoft-surface.ipts.enable = true;
    microsoft-surface.surface-control.enable = true;

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
