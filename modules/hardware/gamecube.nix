{ config, pkgs, ... }:
{
  config = {
    # udev rule to allow libusb user access to GameCube controller adapter
    services.udev.extraRules = ''
      SUBSYSTEM=="usb", ENV{DEVTYPE}=="usb_device", ATTRS{idVendor}=="057e", ATTRS{idProduct}=="0337", MODE="0666"
    '';

    # "Overclocking" to increase GameCube controller adapter poll rate up to 1000hz
    nixpkgs.overlays = [
      (self: super: {
        gcadapter-oc = config.boot.kernelPackages.callPackage ../../packages/gcadapter-oc.nix { };
      })
    ];
    boot.extraModulePackages = with pkgs; [ gcadapter-oc ];
    boot.kernelModules = [ "gcadapter-oc" ];
  };
}
