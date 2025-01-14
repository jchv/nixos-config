{
  imports = [
    ./i18n.nix
    ./nix.nix
    ./overlay.nix
    ./programs.nix
    ./shell.nix
    ./ssh.nix
  ];

  config = {
    # Enable flakes.
    nix.settings.experimental-features = [
      "nix-command"
      "flakes"
    ];

    # Secrets configuration
    sops.defaultSopsFile = ../../../secrets/default.yaml;
    sops.age.sshKeyPaths = [ "/etc/ssh/ssh_host_ed25519_key" ];

    # Allow broken packages (for nixos-unstable)
    nixpkgs.config.allowBroken = true;
  };
}
