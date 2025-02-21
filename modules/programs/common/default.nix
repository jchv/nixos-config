{ pkgs, ... }:
{
  imports = [
    ./kitty
    ./tailscale
    ./vim
  ];

  config = {
    environment.systemPackages = [
      pkgs.gst_all_1.gst-plugins-bad
      pkgs.gst_all_1.gst-plugins-base
      pkgs.gst_all_1.gst-plugins-good
      pkgs.gst_all_1.gst-plugins-ugly
      pkgs.gst_all_1.gstreamer
      pkgs.magic-wormhole-rs
      pkgs.gh
      pkgs.go
      pkgs.jq
      pkgs.nix-output-monitor
    ];
  };
}
