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
      ripgrep
      sops
    ];
  };
}
