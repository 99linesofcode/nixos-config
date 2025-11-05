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
          extraConfig = {
            "wireplumber.settings" = {
              "device.routes.default-sink-volume" = 0.5;
              "device.routes.default-source-volume" = 0.32;
            };
          };
        };
      };
    };
  };
}
