{ pkgs, ... }: {
  config = {
    environment.systemPackages = with pkgs; [
      libwacom
    ];

    nixpkgs.config.hardware.wacom.enabled = true;
  };
}
