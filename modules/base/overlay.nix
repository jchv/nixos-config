{ config, ... }:
{
  config = {
    nixpkgs.overlays = [ ((import ../../packages/overlay.nix) config.nur) ];
  };
}
