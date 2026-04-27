{
  pkgs,
  config,
  ...
}:

let
  mountOptions = [
    "x-systemd.automount"
    "noauto"
    "_netdev"
    "x-systemd.idle-timeout=0"
    "x-systemd.device-timeout=5s"
    "x-systemd.mount-timeout=10s"
    "credentials=${config.sops.secrets."nas/credentials".path}"
    "uid=1000"
    "gid=100"
    "file_mode=0664"
    "dir_mode=0775"
    "vers=3.0"
    "resilienthandles"
    "echo_interval=10"
    "cache=loose"
  ];
  mkMount = folder: {
    device = "//192.168.1.139/${folder}";
    fsType = "cifs";
    options = mountOptions;
  };
  mkMounts =
    folders:
    builtins.listToAttrs (
      map (folder: {
        name = "/mnt/${folder}";
        value = mkMount folder;
      }) folders
    );
in
{
  config = {
    sops.secrets."nas/credentials" = { };

    environment.systemPackages = [
      pkgs.cifs-utils
    ];

    fileSystems = mkMounts [
      "home"
      "shared"
      "software"
      "media"
    ];
  };
}
