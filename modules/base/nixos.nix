{
  imports = [
    ./common.nix
  ];
  config = {
    boot = {
      loader = {
        systemd-boot = {
          enable = true;
          memtest86.enable = true;
          netbootxyz.enable = true;
          edk2-uefi-shell.enable = true;
        };
        efi.canTouchEfiVariables = true;
      };
      kernel.sysctl = {
        # Increase max file limit
        "fs.file-max" = 2097152;
      };
    };
    hardware = {
      cpu.amd.updateMicrocode = true;
      cpu.intel.updateMicrocode = true;
    };
    services = {
      # Enable firmware updater.
      fwupd.enable = true;
      openssh = {
        settings.X11Forwarding = true;
      };
    };
    # Localization/internationalization
    console.keyMap = "us";
    i18n = {
      defaultLocale = "en_US.UTF-8";
      supportedLocales = [
        "en_US.UTF-8/UTF-8"
        "ja_JP.UTF-8/UTF-8"
        "ko_KR.UTF-8/UTF-8"
      ];
    };
    programs.zsh = {
      ohMyZsh = {
        enable = true;
        plugins = [
          "git"
          "man"
        ];
        theme = "agnoster";
      };
    };
    security = {
      # Allow sudo using ssh-agent authentication
      pam.sshAgentAuth.enable = true;
      # Enable rtkit for realtime priority.
      rtkit.enable = true;
    };
  };
}
