{ pkgs, ... }:
{
  config = {
    fonts.packages = [
      pkgs.comic-neue
      pkgs.dina-font
      pkgs.ipafont
      pkgs.noto-fonts
      pkgs.noto-fonts-cjk
      pkgs.noto-fonts-emoji
      pkgs.nerdfonts
      pkgs.font-awesome
      (pkgs.nerdfonts.override {
        fonts = [
          "Go-Mono"
          "SourceCodePro"
          "JetBrainsMono"
        ];
      })
    ];

    fonts.fontconfig.defaultFonts = {
      monospace = [
        "GoMono Nerd Font"
        "Noto Sans Mono"
        "Noto Sans Mono CJK JP"
        "IPAGothic"
      ];
      sansSerif = [
        "Noto Sans"
        "Noto Sans CJK JP"
        "IPAPGothic"
      ];
      serif = [
        "Noto Serif"
        "Noto Serif CJK JP"
        "IPAPMincho"
      ];
      emoji = [ "Noto Color Emoji" ];
    };
  };
}
