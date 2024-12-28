{
  config = {
    nixpkgs.overlays = [ (import ../../packages/overlay.nix) ];
  };
}
