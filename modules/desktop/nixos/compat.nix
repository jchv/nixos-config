{ pkgs, ... }:
{
  config = {
    # Nix-LD linker, allows many standard Linux binaries to work (AppImage, etc.)
    programs.nix-ld = {
      enable = true;
      libraries = with pkgs; [
        fuse
        desktop-file-utils
        xorg.libXcomposite
        xorg.libXtst
        xorg.libXrandr
        xorg.libXext
        xorg.libX11
        xorg.libXfixes
        libGL

        gst_all_1.gstreamer
        gst_all_1.gst-plugins-ugly
        gst_all_1.gst-plugins-base
        libdrm
        xorg.xkeyboardconfig
        xorg.libpciaccess

        glib
        gtk2
        bzip2
        zlib
        gdk-pixbuf

        xorg.libXinerama
        xorg.libXdamage
        xorg.libXcursor
        xorg.libXrender
        xorg.libXScrnSaver
        xorg.libXxf86vm
        xorg.libXi
        xorg.libSM
        xorg.libICE
        freetype
        curlWithGnuTls
        nspr
        nss
        fontconfig
        cairo
        pango
        expat
        dbus
        cups
        libcap
        SDL2
        libusb1
        udev
        dbus-glib
        atk
        at-spi2-atk
        libudev0-shim

        xorg.libXt
        xorg.libXmu
        xorg.libxcb
        xorg.xcbutil
        xorg.xcbutilwm
        xorg.xcbutilimage
        xorg.xcbutilkeysyms
        xorg.xcbutilrenderutil
        libGLU
        libuuid
        libogg
        libvorbis
        SDL
        SDL2_image
        glew110
        openssl
        libidn
        tbb
        wayland
        mesa
        libxkbcommon
        vulkan-loader

        flac
        freeglut
        libjpeg
        libpng12
        libpulseaudio
        libsamplerate
        libmikmod
        libtheora
        libtiff
        pixman
        speex
        SDL2_ttf
        SDL2_mixer
        libappindicator-gtk2
        libcaca
        libcanberra
        libgcrypt
        libvpx
        librsvg
        xorg.libXft
        libvdpau
        alsa-lib

        harfbuzz
        e2fsprogs
        libgpg-error
        keyutils.lib
        libjack2
        fribidi
        p11-kit

        gmp

        libtool.lib
        xorg.libxshmfence
        at-spi2-core
        gtk3
        icu # Needed by dotnet apps
        stdenv.cc.cc.lib
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
