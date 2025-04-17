{ lib, pkgs, ... }:
with lib;
{
  imports = [
    ./home-manager.nix
    ./locale.nix
    ./nix.nix
    ./security.nix
  ];

  # QMK
  environment.systemPackages = with pkgs; [
    via
  ];
  services.udev.packages = [ pkgs.via ];
  hardware.keyboard.qmk.enable = true;

  # low level key remapping daemon
  services.keyd = {
    enable = true;
    keyboards.default.settings = {
      main = {
        capslock = "escape";
        rightalt = "capslock";
      };
    };
  };

  services = {
    automatic-timezoned.enable = true;
    geoclue2.geoProviderUrl = "https://beacondb.net/v1/geolocate";
  };
}
