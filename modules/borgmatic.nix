{ config, lib, ... }:

let
  cfg = config.host.borgmatic;
in
with lib;
{
  options.host.borgmatic = {
    enable = mkEnableOption "borgmatic";
  };

  config = mkIf cfg.enable {
    services.borgmatic = {
      enable = true;
      settings = {
        repositories = [
          {
            label = "Google Drive";
            path = "rclone:gdrive/backup";
          }
        ];
      };
    };
  };
}
