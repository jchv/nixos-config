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

  config = {
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
      mpv
      vlc

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

    environment.sessionVariables.XDG_DATA_DIRS =
    let
      desktopOverrides = pkgs.runCommand "desktop-overrides" {} ''
        mkdir -p $out/share/applications

        # We use kio-fuse so this makes matters worse, not better.
        sed \
          -e '/X-KDE-Protocols/ s/,sftp,smb//' \
          ${pkgs.mpv.out}/share/applications/mpv.desktop \
          > $out/share/applications/mpv.desktop
        sed \
          -e '/X-KDE-Protocols/ s/,sftp,smb//' \
          ${pkgs.vlc}/share/applications/vlc.desktop \
          > $out/share/applications/vlc.desktop
      '';
    in [
      "${desktopOverrides}/share"
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
