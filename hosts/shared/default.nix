{ lib, ... }:

with lib;
{
  imports = [
    ./home-manager.nix
    ./locale.nix
    ./nix.nix
    ./security.nix
  ];

  services = {
    automatic-timezoned.enable = true;
    geoclue2 = {
      enableDemoAgent = mkForce true; # FIXME: see https://github.com/NixOS/nixpkgs/issues/68489#issuecomment-1484030107
      geoProviderUrl = "https://beacondb.net/v1/geolocate";
    };
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
