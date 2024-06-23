{ config, lib, ... }:
{
  config = lib.mkIf config.jchw.desktop.sway.enable {
    fonts.fontconfig.antialias = true;
    fonts.fontconfig.subpixel.rgba = "none";
    fonts.fontconfig.hinting.enable = false;
  };
}
