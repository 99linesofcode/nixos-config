{
  description = "NixOS configuration";

  nixConfig = {
    experimental-features = [
      "nix-command"
      "flakes"
    ];
    extra-substitutes = [
      "https://hyprland.cachix.org"
    ];
    extra-trusted-public-keys = [
      "hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc="
    ];
  };

  # NOTE: nix version is manually kept in sync with home-manager
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    sops-nix = {
      url = "github:Mic92/sops-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    {
      self,
      nixpkgs,
      sops-nix,
      ...
    }@inputs:
    let
      inherit (self) outputs;

      systems = [
        "aarch64-darwin"
        "aarch64-linux"
        "x86_64-darwin"
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
            sops-nix.nixosModules.sops
            (import ./modules)
            (import ./users)
          ] ++ args.modules;
          specialArgs = {
            inherit inputs outputs;
          } // args.specialArgs;
        };
    in
    {
      formatter = forEachSystem (s: nixpkgs.nixfmt-rfc-style);

      packages = forEachSystem (s: pkgsForSystem s nixpkgs);

      nixosConfigurations = {
        luna = NixosConfiguration {
          modules = [ ./hosts/luna ];
          specialArgs = {
            hostname = "luna";
          };
        };
      };
    };
}
