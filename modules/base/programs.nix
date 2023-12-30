{ config, pkgs, lib, ... }: {
  config = {
    environment.systemPackages = with pkgs; [
      # Toolchains/Interpreters
      go
      python3

      # Development Tools
      gitFull
      gnumake
      golines
      lazygit
      nixd

      # Archivers/Compression
      lz4
      p7zip
      unar
      unzip
      zip

      # Multimedia
      ffmpeg-full
      lame

      # Internet/Networking
      iptables
      tcpdump
      wget

      # Utilities
      age
      fd
      file
      fzf
      killport
      nix-index
      pciutils
      psmisc
      ripgrep
      sops
    ];

    virtualisation = {
      podman = {
        enable = true;
        enableNvidia = true;
      };
    };

    nixpkgs.config.permittedInsecurePackages = [
      "p7zip-16.02"
    ];
  };
}
