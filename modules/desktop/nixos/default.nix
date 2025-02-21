{
  imports = [
    ../common

    ./hardware
    ./kde
    ./sway

    ./compat.nix
    ./fonts.nix
    ./network.nix
    ./pipewire.nix
    ./printing.nix
    ./ssh.nix
    ./virtualization.nix
    ./vpn-ns.nix
    ./vpn-proxy.nix
  ];

  config = {
    # Enable Flatpak.
    services.flatpak.enable = true;
    services.packagekit.enable = true;
  };
}
