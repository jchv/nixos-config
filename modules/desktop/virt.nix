{ pkgs, ... }: {
  config = {
    environment.systemPackages = with pkgs; [
      qemu
      virt-manager
      virt-viewer
      spice-gtk
      swtpm
      libguestfs
      libguestfs-appliance
      virtiofsd
    ];

    virtualisation.libvirtd = {
      enable = true;
      nss.enableGuest = true;
      qemu = {
        swtpm.enable = true;
        ovmf = {
          enable = true;
          packages = [(pkgs.OVMFFull.override {
            secureBoot = true;
            tpmSupport = true;
          }).fd];
        };
      };
    };

    virtualisation.waydroid.enable = true;

    boot.binfmt.emulatedSystems = [ "aarch64-linux" ];
  };
}
