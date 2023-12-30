{ pkgs, ... }: {
  config = {
    fonts.fontconfig.antialias = true;
    fonts.fontconfig.subpixel.rgba = "none";
    fonts.fontconfig.hinting.enable = false;

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
  };
}
