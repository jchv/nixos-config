{
  config,
  lib,
  pkgs,
  ...
}:
{
  options = {
    jchw.wacom.enable = lib.mkEnableOption "WACOM tablet support";
  };

  config = lib.mkIf config.jchw.wacom.enable {
    environment.systemPackages = [ pkgs.libwacom ];

    nixpkgs.config.hardware.wacom.enabled = true;
  };
}
