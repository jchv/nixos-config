{ pkgs, ... }:
{
  config = {
    environment.systemPackages = [
      (pkgs.symlinkJoin {
        name = "ruffle-wrapped";
        paths = [
          pkgs.ruffle
          (pkgs.makeDesktopItem {
            name = "ruffle";
            icon = "ruffle";
            exec = "${pkgs.ruffle.out}/bin/ruffle_desktop %U";
            desktopName = "Ruffle Desktop";
            genericName = "Flash Emulator";
            terminal = false;
            mimeTypes = [
              "application/x-shockwave-flash"
              "application/vnd.adobe.flash.movie"
            ];
            categories = [
              "AudioVideo"
              "Player"
            ];
          })
          (pkgs.runCommand "ruffle-icon" { } ''
            mkdir -p $out/share/icons/hicolor/scalable/apps
            cp ${pkgs.ruffle.src}/desktop/assets/Assets.xcassets/RuffleMacIcon.iconset/icon_512x512@2x.png \
              $out/share/icons/hicolor/scalable/apps/ruffle.svg
          '')
        ];
      })
    ];
  };
}
