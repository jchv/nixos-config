{ pkgs, ... }:
{
  config = {
    services.pipewire = {
      enable = true;
      alsa = {
        enable = true;
        support32Bit = true;
      };
      jack.enable = true;
      pulse.enable = true;
    };
    hardware.bluetooth.enable = true;
    hardware.bluetooth.package = pkgs.bluez;
    environment.systemPackages = [
      pkgs.pulsemixer
    ];
  };
}
