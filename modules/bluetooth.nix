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
  options.host.bluetooth = {
    enable = mkEnableOption "bluetooth";
  };

  config = mkIf cfg.enable {
    hardware.bluetooth = {
      enable = true;
      settings = {
        General = {
          Experimental = true; # see: https://wiki.nixos.org/wiki/Bluetooth#Showing_battery_charge_of_bluetooth_devices
          ControllerMode = "bredr";
        };
      };
    };

    system.activationScripts = {
      rfKillUnblockBluetooth = {
        text = ''
          rfkill unblock bluetooth
        '';
        deps = [ ];
      };
    };

    host.impermanence.directories = mkIf config.host.impermanence.enable [
      "/var/lib/bluetooth"
    ];
  };
}
