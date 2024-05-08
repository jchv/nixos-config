{ config, lib, ... }:
{
  options = {
    jchw.nvidia.enable = lib.mkEnableOption "NVIDIA drivers and software";
  };

  config = lib.mkIf config.jchw.nvidia.enable {
    hardware = {
      nvidia = {
        open = true;
        modesetting.enable = true;
      };
      opengl = {
        enable = true;
        driSupport32Bit = true;
      };
      i2c.enable = true;
    };
    nvidia-container-toolkit = {
      enable = true;
    };
  };
}
