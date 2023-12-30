{ pkgs, ... }: {
  config = {
    environment.systemPackages = [
      (pkgs.writeScriptBin "nixos-upgrade-with" ''
        #!${pkgs.bash}/bin/bash
        # TODO: better way to acquire root privileges (that sticks, but keeps agent)

        # HACK: Ensure NSCD is running, for local domains
        sudo systemctl start nscd

        # Copy build from target machine
        sudo -E nix-copy-closure -j8 --from "$1" $(ssh "$1" -- nix build /etc/nixos#nixosConfigurations."$(hostname)".config.system.build.toplevel --print-out-paths)

        # Rebuild + switch
        # TODO: try to update git and ensure everything is synced?
        sudo nixos-rebuild switch
      '')
    ];
  };
}
