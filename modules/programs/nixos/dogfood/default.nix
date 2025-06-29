{
  lib,
  config,
  pkgs,
  ...
}:
{
  options = {
    jchw.dogfood = {
      enable = lib.mkEnableOption "Upstream patch dogfooding" // {
        default = true;
      };
    };
  };

  config = lib.mkIf config.jchw.dogfood.enable {
    # All upstreamed for now :)
  };
}
