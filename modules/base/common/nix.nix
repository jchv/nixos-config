{ inputs, ... }:
{
  config = {
    nix = {
      settings = {
        sandbox = true;
        cores = 0;
      };

      gc = {
        automatic = true;
        options = "--delete-older-than 14d";
      };
    };

    nix.registry.nixpkgs.flake = inputs.nixpkgs;
    nix.registry.system.flake = inputs.self;
    nix.nixPath = [
      "nixpkgs=${inputs.nixpkgs}"
      "system=${inputs.self}"
    ];
    environment.etc."channels/nixpkgs".source = inputs.nixpkgs.outPath;
    environment.etc."channels/system".source = inputs.self.outPath;
  };
}
