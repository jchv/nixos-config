{ pkgs, ... }:
{
  config = {
    environment.systemPackages = [
      pkgs.gitFull
      pkgs.libarchive
      pkgs.unar
      pkgs.age
      pkgs.fd
      pkgs.file
      pkgs.killport
      pkgs.nix-index
      pkgs.usbutils
      pkgs.pciutils
      pkgs.moreutils
      pkgs.psmisc
      pkgs.iptables
      pkgs.ripgrep
      pkgs.sops
    ];
  };
}
