{ lib, pkgs, ... }:
{
  imports = [
    ../../base/darwin
    ../../desktop/darwin
    ../../programs/darwin
    ../../users/darwin
  ];

  config = {
    networking.hostName = "andou";
    system.stateVersion = 5;
  };
}
