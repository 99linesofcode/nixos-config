{ config, lib, ... }:

let
  cfg = config.host.logrotate;
in
with lib;
{
  options.host.logrotate = {
    enable = mkEnableOption "log rotation for agent state logs";

    user = mkOption {
      type = types.str;
      description = "The user whose agent logs are rotated.";
    };

    group = mkOption {
      type = types.str;
      default = "users";
      description = "The group that owns the rotated logs.";
    };

    rotate = mkOption {
      type = types.int;
      default = 12;
      description = "How many rotations to keep.";
    };
  };

  config = mkIf cfg.enable {
    services.logrotate = {
      enable = true;
      settings."/home/${cfg.user}/.local/state/opencode-skill-router/*.jsonl" = {
        frequency = "weekly";
        rotate = cfg.rotate;
        missingok = true;
        notifempty = true;
        compress = true;
        delaycompress = true;
        create = "0600 ${cfg.user} ${cfg.group}";
        su = "${cfg.user} ${cfg.group}";
      };
    };
  };
}
