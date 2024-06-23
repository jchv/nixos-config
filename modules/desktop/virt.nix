{ pkgs, lib, ... }:
{
  config = {
    environment.systemPackages = [
      pkgs.qemu
      pkgs.virt-manager
      pkgs.virt-viewer
      pkgs.spice-gtk
      pkgs.swtpm
      pkgs.libguestfs-with-appliance
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

    # Workaround for NixOS/nixpkgs#280881
    nixpkgs.overlays = [
      (self: super: {
        libguestfs-with-appliance = super.libguestfs-with-appliance.overrideAttrs (
          final: prev: rec {
            pname = "libguestfs";
            version = "1.46.2";
            src = super.fetchurl {
              url = "https://libguestfs.org/download/${lib.versions.majorMinor version}-stable/${pname}-${version}.tar.gz";
              sha256 = "sha256-5uppylIdYPDFS9bT2vH1kcxi4RBdwlOJcVJImqNIAGs=";
            };
          }
        );
      })
    ];

    virtualisation.waydroid.enable = true;

    boot.binfmt.emulatedSystems = [ "aarch64-linux" ];
  };
}
