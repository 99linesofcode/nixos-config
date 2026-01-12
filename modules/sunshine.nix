{ config, lib, ... }:

let
  cfg = config.host.sunshine;
in
with lib;
{
  options.host.sunshine = {
    enable = mkEnableOption "sunshine - game streaming host";
  };

  config = mkIf cfg.enable {
    services.sunshine = {
      enable = true;
      autoStart = false;
      capSysAdmin = true;
      openFirewall = true;
      settings = {
        sunshine_name = config.host.network.hostname;
        capture = "kms";
      };
    };
  };
}
