{
  config = {
    # udev rule to allow libusb user access to Brother QL800 label printer
    services.udev.extraRules = ''
      SUBSYSTEM=="usb", ENV{DEVTYPE}=="usb_device", ATTRS{idVendor}=="04f9", ATTRS{idProduct}=="209b", MODE="0666"
    '';
  };
}
