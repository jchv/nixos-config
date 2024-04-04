{ pkgs, ... }:
{
  config = {
    fonts.packages = with pkgs; [
      comic-neue
      dina-font
      ipafont
      noto-fonts
      noto-fonts-cjk
      noto-fonts-emoji
      nerdfonts
      font-awesome
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
