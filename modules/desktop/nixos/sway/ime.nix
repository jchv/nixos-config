{
  config,
  lib,
  pkgs,
  ...
}:
{
  config = lib.mkIf config.jchw.desktop.sway.enable {
    i18n.inputMethod = {
      enable = true;
      type = "fcitx5";
      fcitx5.addons = [
        pkgs.fcitx5-anthy
        pkgs.fcitx5-gtk
        pkgs.fcitx5-mozc
      ];
    };

    programs.sway.extraSessionCommands = ''
      export QT_IM_MODULE=fcitx
    '';
  };
}
