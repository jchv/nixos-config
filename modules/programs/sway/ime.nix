{ pkgs, ... }: {
  config = {
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
