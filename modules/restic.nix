{ config, lib, ... }:

let
  cfg = config.host.restic;
in
with lib;
{
  options.host.restic = {
    enable = mkEnableOption "restic";

    repository = mkOption {
      type = types.str;
      default = "rclone:gdrive:Restic";
      description = "Restic repository to back up to.";
    };

    paths = mkOption {
      type = types.listOf types.str;
      default = [ ];
      description = "Paths to include in the backup.";
    };
  };

  config = mkIf cfg.enable {
    assertions = [
      {
        assertion = config.host.rclone.enable;
        message = "host.restic depends on host.rclone for the gdrive repository and rclone.conf secret.";
      }
    ];

    sops.secrets = {
      "restic/passwd" = {
        format = "binary";
        sopsFile = "${config.host.root}/hosts/shared/secrets/restic.passwd";
      };
    };

    services.restic = {
      backups = {
        remote = {
          initialize = true;
          passwordFile = config.sops.secrets."restic/passwd".path;
          pruneOpts = [
            "--keep-daily 14"
            "--keep-weekly 4"
            "--keep-monthly 2"
            "--group-by tags"
          ];
          repository = cfg.repository;
          rcloneConfigFile = config.sops.secrets."rclone/rclone.conf".path;
          paths = cfg.paths;
        };
      };
    };
  };
}
