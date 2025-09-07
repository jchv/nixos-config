{
  pkgs,
  config,
  lib,
  ...
}:
let
  xTerminalEmulator = (
    pkgs.runCommand "x-terminal-emulator" { } ''
      mkdir -p $out/bin
      ln -s ${lib.getExe pkgs.kitty} $out/bin/x-terminal-emulator
    ''
  );
in
{
  imports = [
    ./kde
  ];
  config = {
    boot = {
      extraModulePackages = [
        config.boot.kernelPackages.gcadapter-oc-kmod
      ];
    };
    environment = {
      etc = {
        "xdg/kitty/kitty.conf".source = ./kitty.conf;
      };
      systemPackages = [
        pkgs.gdb
        pkgs.kitty
        pkgs.kdePackages.kio-fuse
        pkgs.kdePackages.phonon
        pkgs.kdePackages.phonon-vlc
        pkgs.libnotify
        pkgs.libwacom
        pkgs.networkmanagerapplet
        pkgs.nixos-rebuild-ng
        pkgs.pulsemixer
        pkgs.qemu
        pkgs.spice-gtk
        pkgs.tailscale
        pkgs.virt-manager
        pkgs.virt-viewer
        pkgs.virtiofsd
        pkgs.waypipe
        pkgs.wl-clipboard
        pkgs.wl-mirror
        xTerminalEmulator
      ];
      shellInit = ''
        export DOCKER_HOST=unix://$XDG_RUNTIME_DIR/podman/podman.sock
      '';
      variables = {
        # Prevents WINE from creating desktop entries/associations, at the cost of
        # some noise in the logs.
        WINEDLLOVERRIDES = "winemenubuilder.exe=d";
      };
    };
    fonts = {
      packages = [
        pkgs.comic-neue
        pkgs.dina-font
        pkgs.ipafont
        pkgs.noto-fonts
        pkgs.noto-fonts-cjk-sans
        pkgs.noto-fonts-emoji
        pkgs.nerd-fonts.go-mono
        pkgs.nerd-fonts.sauce-code-pro
        pkgs.font-awesome
      ];
      fontconfig.defaultFonts = {
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
    hardware = {
      graphics.enable32Bit = true;
      bluetooth = {
        enable = true;
        package = pkgs.bluez;
        settings = {
          General = {
            Experimental = true;
            KernelExperimental = true;
          };
        };
      };
    };
    networking = {
      firewall.enable = false;
      networkmanager.enable = true;
      search = [ "jchw.io" ];
    };
    programs = {
      nix-ld = {
        enable = true;
        libraries = [
          pkgs.SDL2
          pkgs.SDL2_image
          pkgs.SDL2_mixer
          pkgs.SDL2_ttf
          pkgs.alsa-lib
          pkgs.at-spi2-atk
          pkgs.at-spi2-core
          pkgs.atk
          pkgs.bzip2
          pkgs.cairo
          pkgs.cups
          pkgs.curlWithGnuTls
          pkgs.dbus
          pkgs.dbus-glib
          pkgs.desktop-file-utils
          pkgs.e2fsprogs
          pkgs.expat
          pkgs.flac
          pkgs.fontconfig
          pkgs.freeglut
          pkgs.freetype
          pkgs.fribidi
          pkgs.fuse
          pkgs.gdk-pixbuf
          pkgs.glew110
          pkgs.glib
          pkgs.gmp
          pkgs.gst_all_1.gst-plugins-bad
          pkgs.gst_all_1.gst-plugins-base
          pkgs.gst_all_1.gst-plugins-good
          pkgs.gst_all_1.gst-plugins-ugly
          pkgs.gst_all_1.gstreamer
          pkgs.gtk2
          pkgs.gtk3
          pkgs.harfbuzz
          pkgs.icu # Needed by dotnet apps
          pkgs.keyutils.lib
          pkgs.libGL
          pkgs.libGLU
          pkgs.libappindicator-gtk2
          pkgs.libcaca
          pkgs.libcanberra
          pkgs.libcap
          pkgs.libdrm
          pkgs.libgcrypt
          pkgs.libgpg-error
          pkgs.libidn
          pkgs.libjack2
          pkgs.libjpeg
          pkgs.libmikmod
          pkgs.libogg
          pkgs.libpng12
          pkgs.libpulseaudio
          pkgs.librsvg
          pkgs.libsamplerate
          pkgs.libtheora
          pkgs.libtiff
          pkgs.libtool.lib
          pkgs.libudev0-shim
          pkgs.libusb1
          pkgs.libuuid
          pkgs.libvdpau
          pkgs.libvorbis
          pkgs.libvpx
          pkgs.libxkbcommon
          pkgs.mesa
          pkgs.nspr
          pkgs.nss
          pkgs.openssl
          pkgs.p11-kit
          pkgs.pango
          pkgs.pixman
          pkgs.speex
          pkgs.stdenv.cc.cc.lib
          pkgs.tbb
          pkgs.udev
          pkgs.vulkan-loader
          pkgs.wayland
          pkgs.xorg.libICE
          pkgs.xorg.libSM
          pkgs.xorg.libX11
          pkgs.xorg.libXScrnSaver
          pkgs.xorg.libXcomposite
          pkgs.xorg.libXcursor
          pkgs.xorg.libXdamage
          pkgs.xorg.libXext
          pkgs.xorg.libXfixes
          pkgs.xorg.libXft
          pkgs.xorg.libXi
          pkgs.xorg.libXinerama
          pkgs.xorg.libXmu
          pkgs.xorg.libXrandr
          pkgs.xorg.libXrender
          pkgs.xorg.libXt
          pkgs.xorg.libXtst
          pkgs.xorg.libXxf86vm
          pkgs.xorg.libpciaccess
          pkgs.xorg.libxcb
          pkgs.xorg.libxshmfence
          pkgs.xorg.xcbutil
          pkgs.xorg.xcbutilimage
          pkgs.xorg.xcbutilkeysyms
          pkgs.xorg.xcbutilrenderutil
          pkgs.xorg.xcbutilwm
          pkgs.xorg.xkeyboardconfig
          pkgs.zlib
        ];
      };
      obs-studio = {
        enable = true;
        plugins = [
          pkgs.obs-studio-plugins.wlrobs
          pkgs.obs-studio-plugins.obs-pipewire-audio-capture
          pkgs.obs-studio-plugins.obs-vkcapture
        ];
      };
      steam = {
        enable = true;
        package = pkgs.unfree.steam;
        remotePlay.openFirewall = true;
        dedicatedServer.openFirewall = true;
        localNetworkGameTransfers.openFirewall = true;
      };
      ssh = {
        startAgent = true;
        enableAskPassword = true;
      };
      wireshark = {
        enable = true;
        package = pkgs.wireshark;
        usbmon.enable = true;
      };
    };
    services = {
      apcupsd.enable = true;
      flatpak.enable = true;
      fwupd.enable = true;
      packagekit.enable = true;
      pcscd.enable = true;
      pipewire = {
        enable = true;
        package = pkgs.pipewire.overrideAttrs (
          finalAttrs: prevAttrs: {
            patches = (prevAttrs.patches or [ ]) ++ [
              (pkgs.writeText "pipewire-32khz.diff" ''
                diff --git a/spa/plugins/bluez5/bap-codec-lc3.c b/spa/plugins/bluez5/bap-codec-lc3.c
                index e9b7723..8e0d882 100644
                --- a/spa/plugins/bluez5/bap-codec-lc3.c
                +++ b/spa/plugins/bluez5/bap-codec-lc3.c
                @@ -647,13 +647,17 @@ static bool select_config(bap_lc3_t *conf, const struct pac_data *pac,	struct sp
                 	 * Frame length is not limited by ISO MTU, as kernel will fragment
                 	 * and reassemble SDUs as needed.
                 	 */
                -	if (pac->sink && pac->duplex) {
                +	if (pac->duplex) {
                 		/* 16KHz input is mandatory in BAP v1.0.1 Table 3.5, so prefer
                -		 * it for now for input rate in duplex configuration.
                +		 * it or 32kHz for now for input rate in duplex configuration.
                +		 *
                +		 * It appears few devices support 48kHz out + input, so in duplex mode
                +		 * try 32 kHz or 16 kHz also for output direction.
                 		 *
                 		 * Devices may list other values but not certain they will work properly.
                 		 */
                -		bap_qos = select_bap_qos(rate_mask & LC3_FREQ_16KHZ, duration_mask, framelen_min, framelen_max);
                +		bap_qos = select_bap_qos(rate_mask & (LC3_FREQ_16KHZ & LC3_FREQ_32KHZ),
                +				duration_mask, framelen_min, framelen_max);
                 	}
                 	if (!bap_qos)
                 		bap_qos = select_bap_qos(rate_mask, duration_mask, framelen_min, framelen_max);
                @@ -752,8 +756,8 @@ static int conf_cmp(const bap_lc3_t *conf1, int res1, const bap_lc3_t *conf2, in
                 	PREFER_BOOL(conf->channels & LC3_CHAN_2);
                 	PREFER_BOOL(conf->channels & LC3_CHAN_1);

                -	if (conf->sink && conf->duplex)
                -		PREFER_BOOL(conf->rate & LC3_CONFIG_FREQ_16KHZ);
                +	if (conf->duplex)
                +		PREFER_BOOL(conf->rate & (LC3_CONFIG_FREQ_16KHZ | LC3_CONFIG_FREQ_32KHZ));

                 	PREFER_EXPR(conf->priority);

              '')
            ];
          }
        );
        alsa = {
          enable = true;
          support32Bit = true;
        };
        jack.enable = true;
        pulse.enable = true;
      };
      printing.enable = true;
      syncthing = {
        enable = true;
        user = "john";
        group = "users";
        dataDir = "/home/john/.local/state/syncthing";
        configDir = "/home/john/.config/syncthing";
        overrideDevices = false;
        overrideFolders = false;
        settings.gui = {
          user = "john";
          password = "todo";
        };
      };
      tailscale.enable = true;
      resolved.enable = true;
      udev.packages = [ pkgs.android-udev-rules ];
      udev.extraRules = ''
        # GameCube Controller Adapter
        SUBSYSTEM=="usb", ENV{DEVTYPE}=="usb_device", ATTRS{idVendor}=="057e", ATTRS{idProduct}=="0337", MODE="0666"
        # Brother QL-800
        SUBSYSTEM=="usb", ENV{DEVTYPE}=="usb_device", ATTRS{idVendor}=="04f9", ATTRS{idProduct}=="209b", MODE="0666"
      '';
    };
    system = {
      activationScripts.binbash = ''
        mkdir -m 0755 -p /bin
        ln -sfn "${pkgs.bash.out}/bin/bash" "/bin/.bash.tmp"
        mv "/bin/.bash.tmp" "/bin/bash"
      '';
    };
    virtualisation = {
      podman = {
        enable = true;
        dockerCompat = true;
      };
      libvirtd = {
        enable = true;
        nss.enableGuest = true;
      };
      virtualbox.host = {
        enable = true;
        enableKvm = true;
        enableExtensionPack = true;
        addNetworkInterface = false;
      };
    };
    nixpkgs.config.allowUnfreePredicate = pkg: builtins.elem (lib.getName pkg) [
      "Oracle_VirtualBox_Extension_Pack"
    ];
    systemd.user.services.kio-fuse = {
      unitConfig = {
        Description = "Fuse interface for KIO";
        PartOf = "graphical-session.target";
      };
      serviceConfig = {
        ExecStart = "${pkgs.kdePackages.kio-fuse}/libexec/kio-fuse -f";
        BusName = "org.kde.KIOFuse";
        Slice = "background.slice";
      };
    };
    xdg = {
      mime = {
        addedAssociations = {
          "application/pdf" = "librewolf.desktop";
          "application/x-wine-extension-ini" = "org.kde.kwrite.desktop";
          "inode/directory" = "neovide.desktop";
          "text/html" = "librewolf.desktop";
          "text/plain" = "org.kde.kwrite.desktop";
          "text/x-readme" = "org.kde.kwrite.desktop";
          "x-scheme-handler/about" = "librewolf.desktop";
          "x-scheme-handler/http" = "librewolf.desktop";
          "x-scheme-handler/https" = "librewolf.desktop";
          "x-scheme-handler/mailto" = "thunderbird.desktop";
          "x-scheme-handler/mid" = "thunderbird.desktop";
          "audio/x-opus+ogg" = "vlc.desktop";
        };
        defaultApplications = {
          "application/pdf" = "org.kde.okular.desktop";
          "application/vnd.rar" = "org.kde.ark.desktop";
          "application/x-7z-compressed" = "org.kde.ark.desktop";
          "application/x-tar" = "org.kde.ark.desktop";
          "application/x-compressed-tar" = "org.kde.ark.desktop";
          "application/zip" = "org.kde.ark.desktop";
          "image/gif" = "org.kde.gwenview.desktop";
          "image/jpeg" = "org.kde.gwenview.desktop";
          "image/png" = "org.kde.gwenview.desktop";
          "image/bmp" = "org.kde.gwenview.desktop";
          "inode/directory" = "org.kde.dolphin.desktop";
          "text/plain" = "org.kde.kwrite.desktop";
          "text/x-readme" = "org.kde.kwrite.desktop";
          "video/webm" = "vlc.desktop";
          "x-scheme-handler/https" = "librewolf.desktop";
          "x-scheme-handler/mailto" = "thunderbird.desktop";
          "x-scheme-handler/mid" = "thunderbird.desktop";
          "application/x-shockwave-flash" = "ruffle.desktop";
          "application/vnd.adobe.flash.movie" = "ruffle.desktop";
          # Set most common audio formats to VLC as a good program to listen to
          # random audio files.
          "audio/aac" = "vlc.desktop";
          "audio/flac" = "vlc.desktop";
          "audio/m4a" = "vlc.desktop";
          "audio/midi" = "vlc.desktop";
          "audio/mp3" = "vlc.desktop";
          "audio/ogg" = "vlc.desktop";
          "audio/opus" = "vlc.desktop";
          "audio/vorbis" = "vlc.desktop";
          "audio/wav" = "vlc.desktop";
          "audio/x-aac" = "vlc.desktop";
          "audio/x-adpcm" = "vlc.desktop";
          "audio/x-aiff" = "vlc.desktop";
          "audio/x-ape" = "vlc.desktop";
          "audio-x-flac" = "vlc.desktop";
          "audio/x-it" = "vlc.desktop";
          "audio-x-m4a" = "vlc.desktop";
          "audio/x-mod" = "vlc.desktop";
          "audio/x-mp3" = "vlc.desktop";
          "audio/x-ms-asf" = "vlc.desktop";
          "audio/x-ms-wma" = "vlc.desktop";
          "audio/x-s3m" = "vlc.desktop";
          "audio/x-opus+ogg" = "vlc.desktop";
          "audio/x-vorbis" = "vlc.desktop";
          "audio/x-vorbis+ogg" = "vlc.desktop";
          "audio/x-wav" = "vlc.desktop";
          "audio/x-wavpack" = "vlc.desktop";
          "audio/x-xm" = "vlc.desktop";
        };
      };
    };
  };
}
