{ config, pkgs, lib, ... }: {
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

    boot.initrd.luks.devices.root = {
      name = "root";
      device = "/dev/disk/by-uuid/8484c3df-4843-48ed-85ea-0d1e38bc7ea7";
      preLVM = true;
      allowDiscards = true;
    };

    services.thermald.enable = true;
    services.tlp.enable = true;

    home-manager.users.john.programs.firefox.profiles.john.settings = {
      "middlemouse.openNewWindow" = false;
    };

    boot.kernelPackages = pkgs.linuxPackages_5_10;
  };
}
