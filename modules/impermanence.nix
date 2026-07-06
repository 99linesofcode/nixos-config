{
  config,
  lib,
  pkgs,
  ...
}:

let
  cfg = config.host.impermanence;
in
with lib;
{
  options.host.impermanence = with types; {
    enable = mkEnableOption "impermanence";
    directories = mkOption {
      type = listOf (oneOf [
        str
        (submodule {
          options = {
            directory = mkOption {
              type = str;
            };
            user = mkOption {
              type = str;
            };
            group = mkOption {
              type = str;
            };
            mode = mkOption {
              type = str;
            };
          };
        })
      ]);
      description = "Either a list or submodule of files and folders to /persist";
    };
  };

  config = mkIf cfg.enable {
    environment.persistence."/persist" = {
      directories = [
        "/root"
        "/var/log/journal"
        "/var/lib/nixos"
      ]
      ++ config.host.impermanence.directories;
      hideMounts = true;
    };
  };
}
