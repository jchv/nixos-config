{
  description = "My NixOS configuration flake";
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    nixos-hardware.url = "github:NixOS/nixos-hardware/master";

    sops-nix.url = "github:Mic92/sops-nix";
    sops-nix.inputs.nixpkgs.follows = "nixpkgs";

    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    nur.url = "github:nix-community/NUR";

    nix-writers.url = "git+https://cgit.krebsco.de/nix-writers";
    nix-writers.inputs.nixpkgs.follows = "nixpkgs";

    dwarffs.url = "github:edolstra/dwarffs";
    dwarffs.inputs.nixpkgs.follows = "nixpkgs";

    playerctl-inhibit.url = "github:jchv/playerctl-inhibit";
    playerctl-inhibit.inputs.nixpkgs.follows = "nixpkgs";

    nixvim.url = "github:nix-community/nixvim";
    nixvim.inputs.nixpkgs.follows = "nixpkgs";

    flake-utils.url = "github:numtide/flake-utils";
  };
  outputs = inputs@{
    self,
    nixpkgs,
    nixos-hardware,
    sops-nix,
    home-manager,
    nur,
    nix-writers,
    dwarffs,
    playerctl-inhibit,
    nixvim,
    flake-utils,
    ...
  }:
    let
      systemFor = hostname: modules:
        nixpkgs.lib.nixosSystem {
          system = "x86_64-linux";
          modules = [
            (./modules/machines + "/${hostname}")
            sops-nix.nixosModules.sops
            home-manager.nixosModules.home-manager
            nur.nixosModules.nur
            # broken:
            # "dwarffs.cc:13:10: fatal error: environment-variables.hh: No such file or directory"
            # dwarffs.nixosModules.dwarffs
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
    } // flake-utils.lib.eachDefaultSystem (system:
      let pkgs = nixpkgs.legacyPackages.${system}; in {
        apps.updateMozillaAddons = {
          type = "app";
          program = toString (pkgs.writers.writeBash "update-firefox-addons" ''
            nix run git+https://git.sr.ht/~rycee/mozilla-addons-to-nix -- ./packages/firefox-addons/addons.json ./packages/firefox-addons/addons.nix
          '');
        };
        packages.vim = nixvim.legacyPackages.${system}.makeNixvim (
          import ./modules/programs/vim/config.nix
        );
      }
    );
}
