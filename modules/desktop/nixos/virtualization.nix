{
  config,
  pkgs,
  lib,
  ...
}:
{
  options = {
    jchw.virtualization.enable = lib.mkOption {
      type = lib.types.bool;
      default = true;
    };
  };

  config = lib.mkIf config.jchw.virtualization.enable {
    environment.systemPackages = [
      pkgs.qemu
      pkgs.virt-manager
      pkgs.virt-viewer
      pkgs.spice-gtk
      pkgs.swtpm
      pkgs.virtiofsd
    ];

    virtualisation.libvirtd = {
      enable = true;
      nss.enableGuest = true;
      qemu = {
        swtpm.enable = true;
        ovmf = {
          enable = true;
          packages = [
            (pkgs.OVMFFull.override {
              secureBoot = true;
              tpmSupport = true;
            }).fd
          ];
        };
      };
    };

    boot.binfmt.emulatedSystems = [ "aarch64-linux" ];
  };
}
