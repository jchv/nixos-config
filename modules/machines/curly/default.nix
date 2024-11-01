{ lib, pkgs, ... }:
{
  imports = [
    ./hardware-configuration.nix
    ../../base
    ../../desktop
    ../../programs
    ../../users
    ../../hardware/android.nix
    ../../hardware/gamecube.nix
    ../../hardware/wacom.nix
    ../../hardware/brother-ql800.nix
  ];

  config = {
    networking.hostName = "curly";
    system.stateVersion = "23.05";
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
      device = "/dev/disk/by-uuid/3b1ce9ad-69f9-460b-9472-799bf03fd423";
      preLVM = true;
      allowDiscards = true;
    };

    jchw.mullvadNs.enable = true;
    jchw.desktop.sway.enable = true;

    boot.kernelPackages = pkgs.linuxPackages_latest;
  };
}
