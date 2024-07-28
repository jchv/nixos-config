{ pkgs, ... }:
{
  config = {
    environment.systemPackages = [
      (pkgs.writeShellApplication {
        name = "nixos-commit-config-to-root";
        runtimeInputs = [
          pkgs.moreutils
          pkgs.jq
        ];
        text = ''
          # Commits the configuration to root so that it is picked up in future
          # unattended upgrades.
          if [[ $EUID -ne 0 ]]; then
            exec sudo bash "$0" "$@"
          fi

          ROOTCFG="/etc/nixos"
          USERCFG="/home/john/nixos-config"

          ROOTLCK="''${ROOTCFG}/flake.lock"
          USERLCK="''${USERCFG}/flake.lock"

          ROOTMOD=$(jq '.nodes.nixpkgs.locked.lastModified' "''${ROOTLCK}")
          USERMOD=$(jq '.nodes.nixpkgs.locked.lastModified' "''${USERLCK}")

          if [ "$USERMOD" -gt "$ROOTMOD" ]; then
            echo "User config has newer nixpkgs lock than root."
            echo "Updating root nixpkgs lock."

            jq --argjson user "$(cat "''${USERLCK}")" \
              '.nodes.nixpkgs.locked = $user.nodes.nixpkgs.locked' \
              "''${ROOTLCK}" \
            | sponge "''${ROOTLCK}"
          elif [ "$USERMOD" -lt "$ROOTMOD" ]; then
            echo "User config has older nixpkgs lock than root."
            echo "Updating user nixpkgs lock."

            jq --argjson root "$(cat "''${ROOTLCK}")" \
              '.nodes.nixpkgs.locked = $root.nodes.nixpkgs.locked' \
              "''${USERLCK}" \
            | sponge "''${USERLCK}"
          fi

          nix flake lock --update-input nixos-config "''${ROOTCFG}"
        '';
      })
      (pkgs.writeScriptBin "nixos-upgrade-nixpkgs" ''
        #!${pkgs.bash}/bin/bash
        # Commits the configuration to root so that it is picked up in future
        # unattended upgrades.
        nix flake lock --update-input nixpkgs --commit-lock-file $HOME/nixos-config
        sudo nix flake lock --update-input nixos-config --update-input nixpkgs /etc/nixos
      '')
      (pkgs.writeScriptBin "nixos-update-config-rebuild" ''
        #!${pkgs.bash}/bin/bash
        nixos-commit-config-to-root && sudo nixos-rebuild switch
      '')
      (pkgs.writeScriptBin "nixos-rebuild-with" ''
        #!${pkgs.bash}/bin/bash
        # Thin wrapper around nixos-rebuild for convenience.
        if [ "$#" == "0" ] || [ "$1" == "--help" ]; then
          echo "Usage: $0 <host> [options...]"
          exit 1
        fi
        HOST="$1"
        shift
        sudo -E HOME=/root SUDO_USER= nixos-rebuild switch --fast --build-host "$HOST" "$@"
      '')
      (pkgs.writeScriptBin "nixos-update-config-rebuild-with" ''
        #!${pkgs.bash}/bin/bash
        if [ "$#" == "0" ] || [ "$1" == "--help" ]; then
          echo "Usage: $0 <host> [options...]"
          exit 1
        fi
        nixos-commit-config-to-root && nixos-rebuild-with "$@"
      '')
    ];
  };
}
