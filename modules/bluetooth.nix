{
  config,
  lib,
  ...
}:
let
  cfg = config.host.bluetooth;
in
with lib;
{
  options = {
    host.bluetooth.enable = mkEnableOption "bluetooth";
  };

  config = mkIf cfg.enable {
    hardware = {
      bluetooth = {
        enable = true;
        settings = {
          general.experimental = true; # see: https://nixos.wiki/wiki/Bluetooth#Showing_battery_charge_of_bluetooth_devices
        };
      };
    };

    services = {
      blueman.enable = true;
    };

    system.activationScripts = {
      rfKillUnblockBluetooth = {
        text = ''
          rfkill unblock bluetooth
        '';
        deps = [ ];
      };
    };
  };
}
