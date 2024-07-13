{ pkgs, ... }:
{
  imports = [
    ./ghidra
    ./kitty
    ./ruffle
    ./syncthing
    ./tailscale
    ./upgrade
    ./vim
    ./wine
  ];

  config =
    let
      patchDesktopFilesForKioFuse =
        pkg:
        pkgs.symlinkJoin {
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
      elementDesktopWayland = pkgs.symlinkJoin {
        name = "element-desktop-wayland";
        paths = [ pkgs.element-desktop ];
        postBuild = ''
          . ${pkgs.makeWrapper}/nix-support/setup-hook
          unlink $out/bin/element-desktop
          makeWrapper '${pkgs.element-desktop}/bin/element-desktop' "$out/bin/element-desktop" \
            --add-flags --ozone-platform-hint=auto \
            --add-flags --enable-features=WaylandWindowDecorations \
            --add-flags --enable-wayland-ime
        '';
      };
    in
    {
      environment.systemPackages = [
        # Multimedia
        pkgs.audacity
        pkgs.gst_all_1.gst-plugins-bad
        pkgs.gst_all_1.gst-plugins-base
        pkgs.gst_all_1.gst-plugins-good
        pkgs.gst_all_1.gst-plugins-ugly
        pkgs.gst_all_1.gstreamer
        pkgs.inkscape
        pkgs.krita
        (patchDesktopFilesForKioFuse pkgs.mpv)
        (patchDesktopFilesForKioFuse pkgs.vlc)

        # Multimedia support in Qt apps
        pkgs.kdePackages.phonon
        pkgs.kdePackages.phonon-vlc

        # Internet/Networking
        pkgs.vesktop
        elementDesktopWayland
        pkgs.fractal-next
        pkgs.gnome-network-displays
        pkgs.kdePackages.neochat
        pkgs.ktailctl
        pkgs.jitsi-meet-electron
        pkgs.magic-wormhole-rs
        pkgs.remmina
        pkgs.thunderbird
        pkgs.waypipe
        pkgs.wayvnc
        pkgs.wireshark

        # File utilities
        pkgs.kdePackages.ark
        pkgs.kdePackages.dolphin
        pkgs.kdePackages.gwenview
        pkgs.obsidian
        pkgs.okteta
        pkgs.kdePackages.okular
        pkgs.syncthingtray
        pkgs.xarchiver

        # I/O
        pkgs.kdePackages.kio
        pkgs.kdePackages.kio-extras
        pkgs.kdePackages.kio-fuse
        pkgs.kdePackages.solid

        # Utilities
        pkgs.bubblewrap
        pkgs.keepassxc
        pkgs.nixos-generators
        pkgs.toolbox
        pkgs.veracrypt
        pkgs.virtualboxKvm
        pkgs.xorg.xkill
        pkgs.xorg.xmodmap

        # Text Editors
        pkgs.kdePackages.kate
        pkgs.zed-editor
        pkgs.yaml-language-server
      ];

      nixpkgs.config.permittedInsecurePackages = [ "electron-25.9.0" ];

      xdg.mime = {
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
          "application/zip" = "org.kde.ark.desktop";
          "image/gif" = "org.kde.gwenview.desktop";
          "image/jpeg" = "org.kde.gwenview.desktop";
          "image/png" = "org.kde.gwenview.desktop";
          "inode/directory" = "org.kde.dolphin.desktop";
          "text/plain" = "org.kde.kwrite.desktop";
          "text/x-readme" = "org.kde.kwrite.desktop";
          "video/webm" = "org.kde.gwenview.desktop";
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

      programs.wireshark.enable = true;
    };
}
