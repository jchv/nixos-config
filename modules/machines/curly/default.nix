{ config, pkgs, lib, ... }: {
  imports = [
    ./hardware-configuration.nix
    ../../base
    ../../desktop
    ../../programs
    ../../home
    ../../hardware/android.nix
    ../../hardware/gamecube.nix
    ../../hardware/wacom.nix
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

    system.autoUpgrade.dates = "20:00";
    system.autoUpgrade.enable = true;
    system.autoUpgrade.flake = "/etc/nixos#curly";
    system.autoUpgrade.flags = [ "--update-input" "nixpkgs" "--commit-lock-file" ];
    systemd.timers.nixos-upgrade.timerConfig.WakeSystem = "true";

    boot.kernelPackages = pkgs.linuxPackages_latest;
  };
}
