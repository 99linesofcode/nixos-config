{
  config,
  lib,
  ...
}:

let
  cfg = config.host.sound;
in
with lib;
{
  options.host.sound = {
    enable = mkEnableOption "sound with pipewire and wireplumber";
  };

  config = mkIf cfg.enable {
    security = {
      rtkit.enable = true;
    };

    services = {
      pipewire = {
        enable = true;
        alsa = {
          enable = true;
          support32Bit = true;
        };
        pulse.enable = true;
        wireplumber = {
          enable = true;
          extraConfig."overrides-10" = {
            "monitor.bluez.rules" = [
              {
                matches = [
                  {
                    "device.name" = "~bluez_card.*";
                  }
                ];
                actions = {
                  update-props = {
                    # set quality to high quality instead of the default variable bitrate ("auto")
                    "bluez5.a2dp.ldac.quality" = "hq";
                  };
                };
              }
            ];
          };
        };
      };
    };
  };
}
