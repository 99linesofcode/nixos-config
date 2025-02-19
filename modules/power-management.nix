{
  config,
  lib,
  ...
}:
let
  cfg = config.host.power-management;
in
with lib;
{
  options = {
    host.power-management.enable = mkEnableOption "automatic power management";
  };

  config = mkIf cfg.enable {
    services = {
      thermald.enable = true;

      tlp = {
        enable = true;
        # NOTE: https://linrunner.de/tlp/settings/index.html for additional settings
        settings = {
          CPU_ENERGY_PERF_POLICY_ON_AC = "performance";
          DEVICES_TO_DISABLE_ON_STARTUP = "bluetooth";
          DEVICES_TO_DISABLE_ON_BAT_NOT_IN_USE = "bluetooth";
          START_CHARGE_THRESH_BAT0 = 75;
          STOP_CHARGE_THRESH_BAT0 = 80;
          SOUND_POWER_SAVE_ON_AC = 10;
          SOUND_POWER_SAVE_ON_BAT = 10;
          USB_AUTOSUSPEND = 0;
          WIFI_PWR_ON_BAT = "off";
        };
      };
    };
  };
}
