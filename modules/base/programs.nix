{ pkgs, ... }:
{
  config = {
    environment.systemPackages = with pkgs; [
      # Development Tools
      bear
      gitFull
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
        dockerCompat = true;
      };
    };

    nixpkgs.config.permittedInsecurePackages = [
      "p7zip-16.02"
      "olm-3.2.16"
    ];
  };
}
