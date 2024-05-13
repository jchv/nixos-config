{
  imports = [
    ./i18n.nix
    ./nixos.nix
    ./overlay.nix
    ./programs.nix
    ./samba.nix
    ./shell.nix
  ];

  config = {
    # Enable flakes.
    nix.settings.experimental-features = [
      "nix-command"
      "flakes"
      "repl-flake"
    ];

    # Secrets configuration
    sops.defaultSopsFile = ../../secrets/default.yaml;
    sops.age.sshKeyPaths = [ "/etc/ssh/ssh_host_ed25519_key" ];

    # Use systemd-boot
    boot.loader.systemd-boot.enable = true;
    boot.loader.efi.canTouchEfiVariables = true;

    # Increase max file limit
    boot.kernel.sysctl = {
      "fs.file-max" = 2097152;
    };

    # Update microcode on AMD/Intel
    hardware.cpu.amd.updateMicrocode = true;
    hardware.cpu.intel.updateMicrocode = true;

    # Enable firmware updater.
    services.fwupd.enable = true;

    # Enable scanner support
    hardware.sane.enable = true;

    # Allow broken packages (for nixos-unstable)
    nixpkgs.config.allowBroken = true;

    # Enable rtkit for realtime priority.
    security.rtkit.enable = true;
  };
}
