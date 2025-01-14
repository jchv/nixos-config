{
  config,
  lib,
  pkgs,
  ...
}:
{
  config = lib.mkIf config.jchw.desktop.sway.enable {
    qt = {
      enable = true;
      style = "breeze";
    };

    environment.systemPackages = [
      pkgs.kdePackages.breeze
      pkgs.kdePackages.breeze-icons
      pkgs.kdePackages.oxygen-icons
      pkgs.kdePackages.qtwayland
      pkgs.kdePackages.qtsvg
    ];

    environment.etc."xdg/baloofilerc".source = (pkgs.formats.ini { }).generate "baloorc" {
      "Basic Settings" = {
        "Indexing-Enabled" = false;
      };
    };
  };
}
