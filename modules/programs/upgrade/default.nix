{ pkgs, ... }:
{
  config = {
    environment.systemPackages = [
      (pkgs.writeScriptBin "nixos-commit-config-to-root" ''
        #!${pkgs.bash}/bin/bash
        # Commits the configuration to root so that it is picked up in future
        # unattended upgrades.
        sudo nix flake lock --update-input nixos-config /etc/nixos
      '')
      (pkgs.writeScriptBin "nixos-upgrade-nixpkgs" ''
        #!${pkgs.bash}/bin/bash
        # Commits the configuration to root so that it is picked up in future
        # unattended upgrades.
        nix flake lock --update-input nixpkgs --commit-lock-file $HOME/nixos-config
        sudo nix flake lock --update-input nixos-config --update-input nixpkgs /etc/nixos
      '')
      (pkgs.writeScriptBin "nixos-rebuild-with" ''
        #!${pkgs.bash}/bin/bash
        # Thin wrapper around nixos-rebuild for convenience.
        if [ "$#" == "0" ] || [ "$1" == "--help" ]; then
          echo "Usage: $0 <host> [options...]"
          exit 1
        fi
        HOST=$1
        shift
        sudo -E HOME=/root SUDO_USER= nixos-rebuild switch --fast --build-host $HOST "$@"
      '')
    ];
  };
}
