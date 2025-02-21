{
  lib,
  config,
  pkgs,
  ...
}:
{
  options = {
    jchw.steam = {
      enable = lib.mkEnableOption "Steam" // {
        default = true;
      };
    };
  };

  config = lib.mkIf config.jchw.steam.enable {
    programs.steam = {
      enable = true;
      package = pkgs.unfree.steam;
      remotePlay.openFirewall = true;
      dedicatedServer.openFirewall = true;
      localNetworkGameTransfers.openFirewall = true;
    };
  };
}
