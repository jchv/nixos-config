{ pkgs, ... }: {
  config = {
    qt = {
      enable = true;
      style = "breeze";
    };

    environment.systemPackages = with pkgs; with libsForQt5; [
      breeze-icons
      oxygen-icons5
    ];

    programs.sway.extraSessionCommands = ''
      export QT_WAYLAND_DISABLE_WINDOWDECORATION=1
    '';

    environment.etc."xdg/baloofilerc".source = (pkgs.formats.ini {}).generate "baloorc" {
      "Basic Settings" = {
        "Indexing-Enabled" = false;
      };
    };
  };
}
