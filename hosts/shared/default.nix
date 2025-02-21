{ lib, ... }:
with lib;
{
  imports = [
    ./home-manager.nix
    ./locale.nix
    ./nix.nix
    ./security.nix
  ];

  # swap ESC and CAPSLOCK in console and beyond
  console.useXkbConfig = mkDefault true;
  services.xserver.xkb.options = mkDefault "caps:swapescape";

  services = {
    automatic-timezoned.enable = true;
    geoclue2.geoProviderUrl = "https://beacondb.net/v1/geolocate";
  };
}
