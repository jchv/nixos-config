{
  imports = [
    ./amdgpu.nix
    ./android.nix
    ./apc-ups.nix
    ./brother-ql800.nix
    ./gcadapter.nix
    ./nvidia.nix
    ./wacom.nix
  ];

  config = {
    services.pcscd.enable = true;
  };
}
