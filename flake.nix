{
  description = "NixOS configuration";

  nixConfig = {
    experimental-features = [
      "nix-command"
      "flakes"
    ];
    extra-substitutes = [
      "https://nix-community.cachix.org"
      "https://hyprland.cachix.org"
    ];
    extra-trusted-public-keys = [
      "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
      "hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc="
    ];
  };

  # NOTE: nix version is manually kept in sync with home-manager
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    impermanence.url = "github:nix-community/impermanence";
    sops-nix = {
      url = "github:Mic92/sops-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    disko = {
      url = "github:nix-community/disko";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    {
      nixpkgs,
      self,
      sops-nix,
      disko,
      impermanence,
      ...
    }@inputs:
    let
      inherit (self) outputs;

      systems = [
        "aarch64-linux"
        "x86_64-linux"
      ];

      forEachSystem = f: nixpkgs.lib.genAttrs systems f;

      pkgsForSystem =
        system: nixpkgsSource:
        import nixpkgsSource {
          inherit system;
          overlays = [
            #NOTE: add your custom overlays here
          ];
        };

      NixosConfiguration =
        args:
        nixpkgs.lib.nixosSystem {
          modules = [
            disko.nixosModules.disko
            impermanence.nixosModules.impermanence
            (import ./modules)
            (import ./users)
          ]
          ++ args.modules;
          specialArgs = {
            inherit self inputs outputs;
          }
          // (args.specialArgs or { });
        };
    in
    {
      formatter = forEachSystem (s: nixpkgs.legacyPackages.${s}.nixfmt-rfc-style);

      packages = forEachSystem (s: pkgsForSystem s nixpkgs);

      nixosConfigurations = {
        luna = NixosConfiguration {
          modules = [ ./hosts/luna ];
        };
        mars = NixosConfiguration {
          modules = [ ./hosts/mars ];
        };
      };
    };
}
