{ pkgs, ... }:
{
  imports = [
    ./hardware-configuration.nix
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

    services.logind.extraConfig = ''
      HandlePowerKey=suspend
    '';

    services.thermald.enable = true;
    services.tlp.enable = true;

    jchw.autosuspend = true;
    jchw.desktop.sway.enable = true;
    jchw.virtualization.enable = false;
    jchw.android.enable = true;
    jchw.brother-ql800.enable = true;

    home-manager.users.john.programs.firefox.profiles.john.settings = {
      "middlemouse.openNewWindow" = false;
      "browser.tabs.opentabfor.middleclick" = false;
    };

    boot.kernelPackages = pkgs.linuxPackages_latest;
  };
}
