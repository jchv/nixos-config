{ pkgs, ... }: {
  config = {
    sound.enable = true;
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
    environment.systemPackages = with pkgs; [
      pavucontrol
      pulsemixer
      broadcom-bt-firmware
      qjackctl
    ];
  };
}
