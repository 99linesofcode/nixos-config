{ lib, ... }:

with lib;
{
  imports = [
    ./home-manager.nix
    ./locale.nix
    ./nix.nix
    ./security.nix
  ];

  host = {
    sops.enable = true;
  };

  services = {
    keyd = {
      enable = true;
      keyboards.default.settings = {
        main = {
          capslock = "escape";
          escape = "capslock";
        };
      };
    };
  };
}
