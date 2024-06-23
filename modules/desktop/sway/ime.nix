{
  config,
  lib,
  pkgs,
  ...
}:
{
  config = lib.mkIf config.jchw.desktop.sway.enable {
    i18n.inputMethod = {
      enabled = "fcitx5";
      fcitx5.addons = with pkgs; [
        fcitx5-anthy
        fcitx5-gtk
        fcitx5-mozc
      ];
    };

    programs.sway.extraSessionCommands = ''
      export QT_IM_MODULE=fcitx
    '';
  };
}
