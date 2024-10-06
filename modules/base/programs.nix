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
      libarchive
      unar

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
  };
}
