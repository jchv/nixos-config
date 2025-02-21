{ pkgs, ... }:
{
  config = {
    # Nix-LD linker, allows many standard Linux binaries to work (AppImage, etc.)
    programs.nix-ld = {
      enable = true;
      libraries = [
        pkgs.fuse
        pkgs.desktop-file-utils
        pkgs.xorg.libXcomposite
        pkgs.xorg.libXtst
        pkgs.xorg.libXrandr
        pkgs.xorg.libXext
        pkgs.xorg.libX11
        pkgs.xorg.libXfixes
        pkgs.libGL

        pkgs.gst_all_1.gstreamer
        pkgs.gst_all_1.gst-plugins-ugly
        pkgs.gst_all_1.gst-plugins-base
        pkgs.libdrm
        pkgs.xorg.xkeyboardconfig
        pkgs.xorg.libpciaccess

        pkgs.glib
        pkgs.gtk2
        pkgs.bzip2
        pkgs.zlib
        pkgs.gdk-pixbuf

        pkgs.xorg.libXinerama
        pkgs.xorg.libXdamage
        pkgs.xorg.libXcursor
        pkgs.xorg.libXrender
        pkgs.xorg.libXScrnSaver
        pkgs.xorg.libXxf86vm
        pkgs.xorg.libXi
        pkgs.xorg.libSM
        pkgs.xorg.libICE
        pkgs.freetype
        pkgs.curlWithGnuTls
        pkgs.nspr
        pkgs.nss
        pkgs.fontconfig
        pkgs.cairo
        pkgs.pango
        pkgs.expat
        pkgs.dbus
        pkgs.cups
        pkgs.libcap
        pkgs.SDL2
        pkgs.libusb1
        pkgs.udev
        pkgs.dbus-glib
        pkgs.atk
        pkgs.at-spi2-atk
        pkgs.libudev0-shim

        pkgs.xorg.libXt
        pkgs.xorg.libXmu
        pkgs.xorg.libxcb
        pkgs.xorg.xcbutil
        pkgs.xorg.xcbutilwm
        pkgs.xorg.xcbutilimage
        pkgs.xorg.xcbutilkeysyms
        pkgs.xorg.xcbutilrenderutil
        pkgs.libGLU
        pkgs.libuuid
        pkgs.libogg
        pkgs.libvorbis
        pkgs.SDL
        pkgs.SDL2_image
        pkgs.glew110
        pkgs.openssl
        pkgs.libidn
        pkgs.tbb
        pkgs.wayland
        pkgs.mesa
        pkgs.libxkbcommon
        pkgs.vulkan-loader

        pkgs.flac
        pkgs.freeglut
        pkgs.libjpeg
        pkgs.libpng12
        pkgs.libpulseaudio
        pkgs.libsamplerate
        pkgs.libmikmod
        pkgs.libtheora
        pkgs.libtiff
        pkgs.pixman
        pkgs.speex
        pkgs.SDL2_ttf
        pkgs.SDL2_mixer
        pkgs.libappindicator-gtk2
        pkgs.libcaca
        pkgs.libcanberra
        pkgs.libgcrypt
        pkgs.libvpx
        pkgs.librsvg
        pkgs.xorg.libXft
        pkgs.libvdpau
        pkgs.alsa-lib

        pkgs.harfbuzz
        pkgs.e2fsprogs
        pkgs.libgpg-error
        pkgs.keyutils.lib
        pkgs.libjack2
        pkgs.fribidi
        pkgs.p11-kit

        pkgs.gmp

        pkgs.libtool.lib
        pkgs.xorg.libxshmfence
        pkgs.at-spi2-core
        pkgs.gtk3
        pkgs.icu # Needed by dotnet apps
        pkgs.stdenv.cc.cc.lib
      ];
    };

    # Ensures that /bin/bash exists, since some things will expect it.
    system.activationScripts.binbash = ''
      mkdir -m 0755 -p /bin
      ln -sfn "${pkgs.bash.out}/bin/bash" "/bin/.bash.tmp"
      mv "/bin/.bash.tmp" "/bin/bash"
    '';

    # 32-bit OpenGL support, for Steam/etc.
    hardware.graphics.enable32Bit = true;
  };
}
