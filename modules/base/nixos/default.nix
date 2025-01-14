{
  imports = [
    ../common
    ./i18n.nix
    ./programs.nix
    ./samba.nix
    ./shell.nix
    ./ssh.nix
    ./tracing.nix
  ];

  config = {
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

    # Enable rtkit for realtime priority.
    security.rtkit.enable = true;
  };
}
