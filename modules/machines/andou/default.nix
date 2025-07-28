{ lib, ... }:
{
  config = {
    networking.hostName = "andou";
    system.stateVersion = 5;
    nix.linux-builder.enable = true;
    nix.settings.sandbox = lib.mkForce false;
  };
}
