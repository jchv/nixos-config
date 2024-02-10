{ pkgs, ... }: {
  imports = [
    ./kitty
    ./sway
    ./syncthing
    ./tailscale
    ./upgrade
    ./vim
    ./wine
  ];

  config = let
    patchDesktopFilesForKioFuse = pkg: pkgs.symlinkJoin {
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
  in {
    environment.systemPackages = with pkgs; with libsForQt5; [
      # Multimedia
      audacity
      gst_all_1.gst-plugins-bad
      gst_all_1.gst-plugins-base
      gst_all_1.gst-plugins-good
      gst_all_1.gst-plugins-ugly
      gst_all_1.gstreamer
      inkscape
      krita
      (patchDesktopFilesForKioFuse mpv)
      (patchDesktopFilesForKioFuse vlc)

      # Multimedia support in Qt apps
      phonon-backend-gstreamer
      phonon-backend-vlc

      # Internet/Networking
      discord
      fractal-next
      gnome-network-displays
      jitsi-meet-electron
      remmina
      thunderbird
      waypipe
      wayvnc
      wireshark

      # File utilities
      ark
      dolphin
      gwenview
      obsidian
      okteta
      okular
      xarchiver

      # I/O
      kio
      kio-extras
      kio-fuse
      solid

      # Utilities
      bubblewrap
      keepassxc
      nixos-generators
      toolbox
      veracrypt
      xorg.xkill
      xorg.xmodmap
      zeal-qt6

      # Text Editors
      kate
      neovide
    ];

    nixpkgs.config.permittedInsecurePackages = [
      "electron-25.9.0"
    ];

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
      };
    };

    programs.wireshark.enable = true;
  };
}
