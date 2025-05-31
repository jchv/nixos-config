{ pkgs, ... }:
{
  imports = [
    ../common
  ];

  config = {
    home-manager.useGlobalPkgs = true;
    home-manager.useUserPackages = true;
    home-manager.users.john = import ./john;
    home-manager.backupFileExtension = "hm-backup";

    users = {
      mutableUsers = false;
      users.root = {
        openssh.authorizedKeys.keys = [
          "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIIgZ9V1xE87W7TXaySAvHpAM9QQ8IOc8qItnhh659d/e john@nullptr"
        ];
      };
      users.john = {
        isNormalUser = true;
        home = "/home/john";
        uid = 1000;
        shell = pkgs.zsh;
        extraGroups = [
          "wheel"
          "networkmanager"
          "libvirtd"
          "adbusers"
          "video"
          "wireshark"
          "vboxusers"
        ];
        hashedPassword = "$6$LK8j4pHMaTP$cwfQlA5j3ZXB4XrfDsk1qK9CDCjLlzS3.Y.BXaiW5BrYBPn9uxS7DyxFPZiyfJ5O/wlAdWSMk5DGhr.Zqg50K1";
        openssh.authorizedKeys.keys = [
          "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIIgZ9V1xE87W7TXaySAvHpAM9QQ8IOc8qItnhh659d/e john@nullptr"
        ];
        subUidRanges = [
          {
            count = 65534;
            startUid = 100001;
          }
        ];
        subGidRanges = [
          {
            count = 65534;
            startGid = 100001;
          }
        ];
      };
    };
  };
}
