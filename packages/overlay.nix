final: prev:
let
  inherit (prev) lib;
  inherit (final) callPackage;
  patchDesktopFilesForKioFuse =
    pkg:
    prev.symlinkJoin {
      name = "${pkg.name}-kio-fuse-workaround";
      paths = [ pkg ];
      postBuild = ''
        for dst in $out/share/applications/*.desktop
        do
          src=$(readlink $dst)
          unlink $dst
          echo "patching KDE protocols $src -> $dst"
          sed -e '/X-KDE-Protocols/ s/,sftp,smb//' $src > $dst
        done
      '';
    };
in
{
  unfree = import "${final.inputs.nixpkgs}" {
    config.allowUnfree = true;
    system = prev.system;
  };
  firefoxAddons = lib.recurseIntoAttrs (callPackage ./firefox-addons { inherit (final) nur; });
  kiofuse-mpv = patchDesktopFilesForKioFuse prev.mpv;
  kiofuse-vlc = patchDesktopFilesForKioFuse prev.vlc;
  element-desktop-wayland = prev.symlinkJoin {
    name = "element-desktop-wayland";
    paths = [ prev.element-desktop ];
    postBuild = ''
      . ${prev.makeWrapper}/nix-support/setup-hook
      unlink $out/bin/element-desktop
      makeWrapper '${prev.element-desktop}/bin/element-desktop' "$out/bin/element-desktop" \
        --add-flags --ozone-platform-hint=auto \
        --add-flags --enable-features=WaylandWindowDecorations \
        --add-flags --enable-wayland-ime
    '';
  };
  ruffle = prev.symlinkJoin {
    name = "ruffle-wrapped";
    paths = [
      prev.ruffle
      (prev.makeDesktopItem {
        name = "ruffle";
        icon = "ruffle";
        exec = "${prev.ruffle.out}/bin/ruffle %U";
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
      (prev.runCommand "ruffle-icon" { } ''
        mkdir -p $out/share/icons/hicolor/scalable/apps
        cp ${prev.ruffle.src}/desktop/assets/Assets.xcassets/RuffleMacIcon.iconset/icon_512x512@2x.png \
          $out/share/icons/hicolor/scalable/apps/ruffle.svg
      '')
    ];
  };
  ghidra-with-extensions = prev.ghidra.withExtensions (_: [
    prev.ghidra-extensions.ghidra-delinker-extension
    (prev.callPackage ./ghidra-gamecube-loader { })
  ]);
}
