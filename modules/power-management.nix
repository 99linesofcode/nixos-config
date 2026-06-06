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
  options.host.power-management = {
    enable = mkEnableOption "automatic power management";
  };

  config = mkIf cfg.enable {
    services = {
      thermald.enable = true;

      tlp = {
        enable = true;
        # see: https://linrunner.de/tlp/settings/index.html
        settings = {
          CPU_SCALING_GOVERNOR_ON_AC = "performance";
          CPU_ENERGY_PERF_POLICY_ON_AC = "balance_performance";
          CPU_ENERGY_PERF_POLICY_ON_BAT = "balance_power";
          CPU_MAX_PERF_ON_AC = 90;
          CPU_MAX_PERF_ON_BAT = 80;
          DEVICES_TO_DISABLE_ON_BAT_NOT_IN_USE = "bluetooth";
          DEVICES_TO_ENABLE_ON_AC = "bluetooth";
          PLATFORM_PROFILE_ON_AC = "balance_performance";
          PLATFORM_PROFILE_ON_BAT = "balance_power";
          START_CHARGE_THRESH_BAT0 = 75;
          STOP_CHARGE_THRESH_BAT0 = 80;
          SOUND_POWER_SAVE_ON_AC = 10;
          SOUND_POWER_SAVE_ON_BAT = 10;
          RUNTIME_PM_ON_AC = "auto";
          RUNTIME_PM_DRIVER_DENYLIST = "mei_me nvidia xhci_hcd";
          USB_AUTOSUSPEND = 0;
          WIFI_PWR_ON_BAT = "off";
        };
      };
    };
  };
}
