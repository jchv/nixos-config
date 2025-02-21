{ pkgs, ... }:
{
  imports = [
    ../common
    ./dogfood
    ./steam
    ./syncthing
    ./wine
  ];

  config = {
    environment.systemPackages = [
      pkgs.kdePackages.phonon
      pkgs.kdePackages.phonon-vlc
      pkgs.kdePackages.kio-fuse
      pkgs.waypipe
      pkgs.wl-mirror
      pkgs.libnotify
      pkgs.gdb
      pkgs.nixos-rebuild-ng
      pkgs.wl-clipboard
    ];

    virtualisation = {
      podman = {
        enable = true;
        dockerCompat = true;
      };
    };

    environment = {
      shellInit = ''
        export DOCKER_HOST=unix://$XDG_RUNTIME_DIR/podman/podman.sock
      '';
    };

    programs.obs-studio = {
      enable = true;
      enableVirtualCamera = true;
      plugins = [
        pkgs.obs-studio-plugins.wlrobs
        pkgs.obs-studio-plugins.obs-pipewire-audio-capture
        pkgs.obs-studio-plugins.obs-vkcapture
      ];
    };

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
        "application/x-compressed-tar" = "org.kde.ark.desktop";
        "application/zip" = "org.kde.ark.desktop";
        "image/gif" = "org.kde.gwenview.desktop";
        "image/jpeg" = "org.kde.gwenview.desktop";
        "image/png" = "org.kde.gwenview.desktop";
        "image/bmp" = "org.kde.gwenview.desktop";
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
