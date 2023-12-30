{ pkgs, ... }: {
  config = {
    services.udev.packages = with pkgs; [
      android-udev-rules
    ];
  };
}
