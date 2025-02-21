{ config, lib, ... }:
{
  options = {
    jchw.gcadapter.enable = lib.mkEnableOption "GameCube Controller Adapter support";
  };

  config = lib.mkIf config.jchw.gcadapter.enable {
    # udev rule to allow libusb user access to GameCube controller adapter
    services.udev.extraRules = ''
      SUBSYSTEM=="usb", ENV{DEVTYPE}=="usb_device", ATTRS{idVendor}=="057e", ATTRS{idProduct}=="0337", MODE="0666"
    '';

    # "Overclocking" to increase GameCube controller adapter poll rate up to 1000hz
    boot.extraModulePackages = [ config.boot.kernelPackages.gcadapter-oc ];
    boot.kernelModules = [ "gcadapter-oc" ];
  };
}
