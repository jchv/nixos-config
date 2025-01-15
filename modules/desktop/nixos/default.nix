{
  imports = [
    ../common

    ./kde
    ./sway

    ./compat.nix
    ./fonts.nix
    ./fluidsynth.nix
    ./nas.nix
    ./network.nix
    ./pipewire.nix
    ./printing.nix
    ./ssh.nix
    ./u2f.nix
    ./virt.nix
    ./vpn-ns.nix
    ./vpn-proxy.nix
  ];

  config = {
    # Enable Flatpak.
    services.flatpak.enable = true;
    services.packagekit.enable = true;
  };
}
