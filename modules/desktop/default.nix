{ config, pkgs, lib, options, ... }: {
  imports = [
    ./compat.nix
    ./fonts.nix
    ./fluidsynth.nix
    ./nas.nix
    ./network.nix
    ./pipewire.nix
    ./printing.nix
    ./virt.nix
    ./vpn.nix
  ];

  config = {
    # Enable Flatpak.
    services.flatpak.enable = true;
  };
}
