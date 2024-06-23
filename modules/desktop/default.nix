{
  imports = [
    ./kde
    ./sway

    ./compat.nix
    ./fonts.nix
    ./fluidsynth.nix
    ./nas.nix
    ./network.nix
    ./pipewire.nix
    ./printing.nix
    ./u2f.nix
    ./virt.nix
    ./vpn.nix
  ];

  config = {
    # Enable Flatpak.
    services.flatpak.enable = true;
  };
}
