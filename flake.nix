{
  description = "My NixOS configuration flake";
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    nixos-hardware.url = "github:NixOS/nixos-hardware/master";

    sops-nix.url = "github:Mic92/sops-nix";
    sops-nix.inputs.nixpkgs.follows = "nixpkgs";

    nix-writers.url = "git+https://cgit.krebsco.de/nix-writers";
    nix-writers.inputs.nixpkgs.follows = "nixpkgs";

    dwarffs.url = "github:edolstra/dwarffs";
    dwarffs.inputs.nixpkgs.follows = "nixpkgs";

    playerctl-inhibit.url = "github:jchv/playerctl-inhibit";
    playerctl-inhibit.inputs.nixpkgs.follows = "nixpkgs";

    nixvim.url = "github:nix-community/nixvim";
    nixvim.inputs.nixpkgs.follows = "nixpkgs";
  };
  outputs = { self, nixpkgs, nixos-hardware, sops-nix, nix-writers, dwarffs, playerctl-inhibit, nixvim, ...}:
    let
      systemFor = hostname: modules:
        nixpkgs.lib.nixosSystem {
          system = "x86_64-linux";
          modules = [
            (./machines + "/${hostname}")
            sops-nix.nixosModules.sops
            dwarffs.nixosModules.dwarffs
            nixvim.nixosModules.nixvim
            {
              nixpkgs.overlays = [
                nix-writers.overlays.default
              ];
            }
          ] ++ modules;
          specialArgs = { inherit nixpkgs; };
        };
      surface = nixos-hardware.nixosModules.microsoft-surface-common;
      micropc = nixos-hardware.nixosModules.gpd-micropc;
      playerctlInhibit = playerctl-inhibit.nixosModules.playerctl-inhibit;
    in {
      nixosConfigurations.curly = systemFor "curly" [];
      nixosConfigurations.taiga = systemFor "taiga" [ surface ];
      nixosConfigurations.puchiko = systemFor "puchiko" [ micropc playerctlInhibit ];
    };
}
