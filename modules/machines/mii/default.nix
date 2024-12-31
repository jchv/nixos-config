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
    networking.hostName = "mii";
    system.stateVersion = "22.05";
    jchw.autosuspend = true;
    jchw.desktop.kde.enable = true;
    services.fwupd.enable = true;
    security.pam.services.login.fprintAuth = false;
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
    disko.devices = {
      disk = {
        root = {
          type = "disk";
          device = "/dev/disk/by-id/nvme-Samsung_SSD_990_PRO_4TB_S7KGNJ0X202693F";
          content = {
            type = "gpt";
            partitions = {
              ESP = {
                size = "1G";
                type = "EF00";
                content = {
                  type = "filesystem";
                  format = "vfat";
                  mountpoint = "/boot";
                  mountOptions = [ "defaults" ];
                };
              };
              luks = {
                size = "100%";
                content = {
                  type = "luks";
                  name = "cryptroot";
                  passwordFile = "/tmp/secret.key";
                  settings = {
                    allowDiscards = true;
                  };
                  content = {
                    type = "btrfs";
                    extraArgs = [ "-f" ];
                    subvolumes = {
                      "/root" = {
                        mountpoint = "/";
                        mountOptions = [
                          "compress=zstd"
                          "noatime"
                        ];
                      };
                      "/home" = {
                        mountpoint = "/home";
                        mountOptions = [
                          "compress=zstd"
                          "noatime"
                        ];
                      };
                      "/nix" = {
                        mountpoint = "/nix";
                        mountOptions = [
                          "compress=zstd"
                          "noatime"
                        ];
                      };
                      "/swap" = {
                        mountpoint = "/.swapvol";
                        swap.swapfile.size = "6G";
                      };
                    };
                  };
                };
              };
            };
          };
        };
      };
    };
  };
}
