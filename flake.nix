{
  description = "My NixOS configuration flake";
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
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

    playerctl-inhibit.url = "github:jchv/playerctl-inhibit";
    playerctl-inhibit.inputs.nixpkgs.follows = "nixpkgs";

    nixvim.url = "github:nix-community/nixvim";
    nixvim.inputs.nixpkgs.follows = "nixpkgs";

    disko.url = "github:nix-community/disko";
    disko.inputs.nixpkgs.follows = "nixpkgs";

    flake-utils.url = "github:numtide/flake-utils";
  };
  outputs =
    inputs@{
      self,
      nixpkgs,
      nix-index-database,
      nixos-hardware,
      sops-nix,
      home-manager,
      nur,
      nix-writers,
      playerctl-inhibit,
      nixvim,
      disko,
      flake-utils,
      ...
    }:
    let
      systemFor =
        hostname: modules:
        nixpkgs.lib.nixosSystem {
          system = "x86_64-linux";
          modules = [
            (./modules/machines + "/${hostname}")
            nix-index-database.nixosModules.nix-index
            sops-nix.nixosModules.sops
            home-manager.nixosModules.home-manager
            nur.nixosModules.nur
            disko.nixosModules.disko
            nixvim.nixosModules.nixvim
            { nixpkgs.overlays = [ nix-writers.overlays.default ]; }
          ] ++ modules;
          specialArgs = {
            inherit nixpkgs;
          };
        };
      surface = nixos-hardware.nixosModules.microsoft-surface-common;
      micropc = nixos-hardware.nixosModules.gpd-micropc;
      framework-16-7040-amd = nixos-hardware.nixosModules.framework-16-7040-amd;
      playerctlInhibit = playerctl-inhibit.nixosModules.playerctl-inhibit;
    in
    {
      nixosConfigurations.curly = systemFor "curly" [ ];
      nixosConfigurations.taiga = systemFor "taiga" [ surface ];
      nixosConfigurations.puchiko = systemFor "puchiko" [
        micropc
        playerctlInhibit
      ];
      nixosConfigurations.mii = systemFor "mii" [ framework-16-7040-amd ];
    }
    // flake-utils.lib.eachDefaultSystem (
      system:
      let
        pkgs = nixpkgs.legacyPackages.${system};
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
        packages =
          let
            vim = nixvim.legacyPackages.${system}.makeNixvim (import ./modules/programs/vim/config.nix);
            overlay = (import ./packages/overlay.nix) nur.overlay (overlay // pkgs) pkgs;
          in
          overlay // { inherit vim; };
      }
    );
}
