{ config, lib, ... }:

let
  cfg = config.host.restic;
in
with lib;
{
  options.host.restic = {
    enable = mkEnableOption "restic";
  };

  config = mkIf cfg.enable {
    sops.secrets = {
      "restic/passwd" = {
        format = "binary";
        sopsFile = "${config.host.root}/hosts/shared/secrets/restic.passwd";
      };
    };

    services.restic = {
      backups = {
        remotebackup = {
          initialize = true;
          passwordFile = config.sops.secrets."restic/passwd".path;
          pruneOpts = [
            "--keep-daily 14"
            "--keep-weekly 4"
            "--keep-monthly 2"
            "--group-by tags"
          ];
          repository = "rclone:gdrive:Restic";
          rcloneConfigFile = config.sops.secrets."rclone/rclone.conf".path;
        };
      };
    };
  };
}
