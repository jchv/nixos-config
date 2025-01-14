{ pkgs, ... }:
{
  imports = [
    ./ghidra
    ./kitty
    ./tailscale
    ./vim
  ];

  config =
    {
      environment.systemPackages = [
        # Multimedia
        pkgs.gst_all_1.gst-plugins-bad
        pkgs.gst_all_1.gst-plugins-base
        pkgs.gst_all_1.gst-plugins-good
        pkgs.gst_all_1.gst-plugins-ugly
        pkgs.gst_all_1.gstreamer

        # Internet/Networking
        pkgs.vesktop
        pkgs.magic-wormhole-rs

        # Development
        pkgs.gh
        pkgs.nixpkgs-review
        pkgs.nix-prefetch-github

        # File utilities
        pkgs.syncthing
        pkgs.syncthingtray

        # Utilities
        pkgs.keepassxc
        pkgs.nixos-generators
        pkgs.xorg.xkill
        pkgs.xorg.xmodmap

        # Text Editors
        pkgs.zed-editor
      ];
    };
}
