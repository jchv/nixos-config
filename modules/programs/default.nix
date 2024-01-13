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

      # Multimedia support in Qt apps
      phonon-backend-gstreamer
      phonon-backend-vlc

      # Internet/Networking
      discord
      fractal-next
      gnome-network-displays
      jitsi-meet-electron
      librewolf-wayland
      remmina
      thunderbird
      waypipe
      wayvnc
      wireshark

      # File utilities
      ark
      dolphin
      gwenview
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

    programs.wireshark.enable = true;
  };
}
