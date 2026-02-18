{
  description = "My NixOS configuration flake";
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable-small";
    nixos-hardware.url = "github:NixOS/nixos-hardware/master";

    nix-index-database.url = "github:nix-community/nix-index-database";
    nix-index-database.inputs.nixpkgs.follows = "nixpkgs";

    sops-nix.url = "github:Mic92/sops-nix";
    sops-nix.inputs.nixpkgs.follows = "nixpkgs";

    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    nur.url = "github:nix-community/NUR";

    nix-writers.url = "git+https://cgit.krebsco.de/nix-writers";
    nix-writers.inputs.nixpkgs.follows = "nixpkgs";

    disko.url = "github:nix-community/disko";
    disko.inputs.nixpkgs.follows = "nixpkgs";

    flake-utils.url = "github:numtide/flake-utils";

    nix-darwin.url = "github:LnL7/nix-darwin";
    nix-darwin.inputs.nixpkgs.follows = "nixpkgs";
  };
  outputs =
    inputs@{
      nixpkgs,
      nix-index-database,
      nixos-hardware,
      sops-nix,
      home-manager,
      nur,
      nix-writers,
      disko,
      flake-utils,
      nix-darwin,
      ...
    }:
    let
      machineModuleFor = hostname: ./modules/machines + "/${hostname}";
      nixInputsOverlay = final: prev: { inherit inputs; };
      nixpkgsOverlays = [
        nixInputsOverlay
        nix-writers.overlays.default
        (import ./packages/overlay.nix)
      ];
      nixOSModules = [
        ./modules/base/nixos.nix
        ./modules/desktop
        ./modules/users
        ./modules/vpn
        nix-index-database.nixosModules.nix-index
        sops-nix.nixosModules.sops
        home-manager.nixosModules.home-manager
        nur.modules.nixos.default
        disko.nixosModules.disko
        { nixpkgs.overlays = nixpkgsOverlays; }
      ];
      nixOSSystemFor =
        hostname: modules:
        nixpkgs.lib.nixosSystem {
          system = "x86_64-linux";
          modules =
            [
              (machineModuleFor hostname)
            ]
            ++ nixOSModules
            ++ modules;
          specialArgs = {
            inherit inputs;
          };
        };
      nixDarwinModules = [
        ./modules/base/darwin.nix
        nix-index-database.darwinModules.nix-index
        sops-nix.darwinModules.sops
        home-manager.darwinModules.home-manager
        { nixpkgs.overlays = nixpkgsOverlays; }
      ];
      nixDarwinSystemFor =
        hostname: modules:
        nix-darwin.lib.darwinSystem {
          system = "aarch64-darwin";
          modules =
            [
              (machineModuleFor hostname)
            ]
            ++ nixDarwinModules
            ++ modules;
          specialArgs = {
            inherit inputs;
          };
        };
      surface = nixos-hardware.nixosModules.microsoft-surface-common;
      micropc = nixos-hardware.nixosModules.gpd-micropc;
      framework-16-7040-amd = nixos-hardware.nixosModules.framework-16-7040-amd;
    in
    {
      nixosConfigurations.curly = nixOSSystemFor "curly" [ ];
      nixosConfigurations.taiga = nixOSSystemFor "taiga" [ surface ];
      nixosConfigurations.puchiko = nixOSSystemFor "puchiko" [ micropc ];
      nixosConfigurations.mii = nixOSSystemFor "mii" [ framework-16-7040-amd ];
      darwinConfigurations.andou = nixDarwinSystemFor "andou" [ ];
    }
    // flake-utils.lib.eachDefaultSystem (
      system:
      let
        pkgs = import nixpkgs {
          inherit system;
          overlays = nixpkgsOverlays ++ [
            nur.overlays.default
          ];
        };
      in
      {
        apps.updateMozillaAddons = {
          type = "app";
          program = toString (
            pkgs.writers.writeBash "update-firefox-addons" ''
              nix run git+https://git.sr.ht/~rycee/mozilla-addons-to-nix -- ./packages/firefox-addons/addons.json ./packages/firefox-addons/addons.nix
            ''
          );
        };
        legacyPackages = pkgs;
      }
    );
}
