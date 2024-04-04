{ config, pkgs, ... }:
{
  config = {
    # Localization/internationalization
    time.timeZone = "America/Detroit";
    console.keyMap = "us";
    i18n = {
      defaultLocale = "en_US.UTF-8";
      glibcLocales =
        (pkgs.glibcLocales.overrideAttrs (
          finalAttrs: previousAttrs: {
            preBuild = builtins.replaceStrings [ "false" ] [ "# false" ] previousAttrs.preBuild;
          }
        )).override
          {
            locales = config.i18n.supportedLocales;
            allLocales = false;
          };
      supportedLocales = [
        "en_US.UTF-8/UTF-8"
        "ja_JP.UTF-8/UTF-8"
        "ja_JP.EUC-JP/EUC-JP"
        "ja_JP.SJIS/SHIFT_JIS"
        "ko_KR.UTF-8/UTF-8"
      ];
    };
  };
}
