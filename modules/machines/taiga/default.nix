{ lib, pkgs, ... }:
{
  imports = [
    ./hardware-configuration.nix
    ../../base/nixos
    ../../desktop/nixos
    ../../programs/nixos
    ../../users/nixos
    ../../hardware/android.nix
    ../../hardware/brother-ql800.nix
  ];

  config = {
    networking.hostName = "taiga";
    system.stateVersion = "22.05";

    nixpkgs.config.allowUnfreePredicate =
      pkg:
      builtins.elem (lib.getName pkg) [
        "broadcom-bt-firmware"
        "obsidian"
        "steam"
        "steam-original"
        "steam-run"
        "steam-unwrapped"
      ];

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
    jchw.u2f.enable = true;
    jchw.u2f.sudo.enable = true;
    jchw.u2f.screenLock.enable = true;
    jchw.desktop.sway.enable = true;

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
