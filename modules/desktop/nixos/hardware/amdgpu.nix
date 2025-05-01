{
  config,
  lib,
  pkgs,
  ...
}:
{
  options = {
    jchw.amdgpu.enable = lib.mkEnableOption "AMD GPU drivers and software";
  };

  config = lib.mkIf config.jchw.amdgpu.enable {
    hardware = {
      graphics = {
        extraPackages = [
          pkgs.amdvlk
        ];
        extraPackages32 = [
          pkgs.driversi686Linux.amdvlk
        ];
      };
    };
  };
}
