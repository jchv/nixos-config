{ nixpkgs, ... }:
{
  config = {
    nix = {
      settings = {
        sandbox = true;
        cores = 0;
      };

      gc = {
        automatic = true;
        dates = "00:15";
        options = "--delete-older-than 14d";
      };
    };

    nix.registry.nixpkgs.flake = nixpkgs;
    nix.nixPath = [ "nixpkgs=${nixpkgs}" ];
    environment.etc."channels/nixpkgs".source = nixpkgs.outPath;
  };
}
