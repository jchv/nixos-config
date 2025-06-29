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
  # Trick borrowed from https://discourse.nixos.org/t/whats-the-right-way-to-make-a-custom-kernel-module-available/4636/4 by niggowai
  allKernels =
    with lib.attrsets;
    with builtins;
    filterAttrs (n: v: match "linuxPackagesFor" n == null && match "linuxPackages_custom.*" n == null) (
      filterAttrs (n: v: match "linuxPackages.*" n != null) prev
    );
  kernelModules = kernel: {
    gcadapter-oc = callPackage ./gcadapter-oc { inherit kernel; };
  };
in
{
  unfree = import "${final.inputs.nixpkgs}" {
    config.allowUnfree = true;
    system = prev.system;
  };
  firefoxAddons = lib.recurseIntoAttrs (callPackage ./firefox-addons { inherit (final) nur; });
  mediaplayer = callPackage ./mediaplayer { };
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
  olm = prev.olm.overrideAttrs (
    finalAttrs: prevAttrs: {
      meta = prevAttrs.meta // {
        knownVulnerabilities = [ ];
      };
    }
  );
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
  ]);
  lttng-ust = prev.lttng-ust.overrideAttrs (
    finalAttrs: prevAttrs: {
      version = "2.14.0";
      src = final.fetchurl {
        url = "https://lttng.org/files/lttng-ust/lttng-ust-2.14.0.tar.bz2";
        hash = "sha256-gs39MEu7Kyt9F8yVGmdWs3qfc4aOwLp9tEig1cpRt2M=";
      };
      buildInputs = (prevAttrs.buildInputs or [ ]) ++ [ final.babeltrace2.dev ];
    }
  );
  lttng-tools = prev.lttng-tools.overrideAttrs (
    finalAttrs: prevAttrs: {
      version = "2.14.0";
      src = final.fetchurl {
        url = "https://lttng.org/files/lttng-tools/lttng-tools-2.14.0.tar.bz2";
        hash = "sha256-2MOcJs7BO3vYJVHNUqIu/DWLiI4268+cG2DvHDo8L9M=";
      };
      buildInputs = (prevAttrs.buildInputs or [ ]) ++ [ final.babeltrace2.dev ];
    }
  );
  babeltrace2 = prev.babeltrace2.overrideAttrs (
    finalAttrs: prevAttrs: {
      version = "2.1.1";
      src = final.fetchFromGitHub {
        owner = "efficios";
        repo = "babeltrace";
        rev = "v2.1.1";
        hash = "sha256-ppSPly4HR/oemsX069o6VqwSB1AU1mKRwRepwPORf7I=";
      };
      patches = [ ];
    }
  );
}
// builtins.mapAttrs (n: v: v.extend (self: super: (kernelModules self.kernel))) allKernels
