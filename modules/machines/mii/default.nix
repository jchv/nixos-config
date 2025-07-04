{ pkgs, ... }:
{
  imports = [
    ./hardware-configuration.nix
  ];

  config = {
    networking.hostName = "mii";
    system.stateVersion = "22.05";
    jchw.mullvadProxy.enable = true;
    jchw.autosuspend = true;
    jchw.desktop.kde.enable = true;
    jchw.amdgpu.enable = true;
    jchw.steam.enable = true;
    jchw.android.enable = true;
    jchw.brother-ql800.enable = true;
    services.fwupd.enable = true;
    security.pam.services.login.fprintAuth = false;
    boot.kernelPackages = pkgs.linuxPackages_latest;
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
