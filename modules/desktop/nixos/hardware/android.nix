{
  config,
  lib,
  pkgs,
  ...
}:
{
  options = {
    jchw.android.enable = lib.mkEnableOption "Android device connectivity";
  };

  config = lib.mkIf config.jchw.android.enable {
    services.udev.packages = [ pkgs.android-udev-rules ];
  };
}
