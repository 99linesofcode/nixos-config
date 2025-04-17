{ ... }:

{
  imports = [
    ./home-manager.nix
    ./locale.nix
    ./nix.nix
    ./security.nix
  ];

  services = {
    automatic-timezoned.enable = true;
    geoclue2.geoProviderUrl = "https://beacondb.net/v1/geolocate";
    # keyd - low level key remapping daemon
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
