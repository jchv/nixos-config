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
    ];

    #programs.sway.extraSessionCommands = ''
    #  export QT_WAYLAND_DISABLE_WINDOWDECORATION=1
    #'';

    environment.etc."xdg/baloofilerc".source = (pkgs.formats.ini { }).generate "baloorc" {
      "Basic Settings" = {
        "Indexing-Enabled" = false;
      };
    };
  };
}
