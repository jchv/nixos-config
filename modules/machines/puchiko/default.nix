{ lib, pkgs, ... }:
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
    networking.hostName = "puchiko";
    system.stateVersion = "23.05";

    nixpkgs.config.allowUnfreePredicate =
      pkg:
      builtins.elem (lib.getName pkg) [
        "broadcom-bt-firmware"
        "obsidian"
        "steam"
        "steam-original"
        "steam-run"
      ];

    boot.initrd.luks.devices.root = {
      name = "root";
      device = "/dev/disk/by-uuid/8484c3df-4843-48ed-85ea-0d1e38bc7ea7";
      preLVM = true;
      allowDiscards = true;
    };

    services.logind.extraConfig = ''
      HandlePowerKey=suspend
    '';

    services.thermald.enable = true;
    services.tlp.enable = true;

    jchw.autosuspend = true;
    jchw.u2f.enable = true;
    jchw.u2f.sudo.enable = true;
    jchw.u2f.screenLock.enable = true;
    jchw.desktop.sway.enable = true;
    jchw.virtualization.enable = false;

    home-manager.users.john.programs.firefox.profiles.john.settings = {
      "middlemouse.openNewWindow" = false;
      "browser.tabs.opentabfor.middleclick" = false;
    };

    boot.kernelPackages = pkgs.linuxPackages_5_10;
  };
}
