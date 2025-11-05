{ config, lib, ... }:

let
  cfg = config.host.avahi;
in
with lib;
{
  options.host.avahi = {
    enable = mkEnableOption "avahi";
  };

  config = mkIf cfg.enable {
    services.avahi = {
      enable = true;
      nssmdns4 = true;
      openFirewall = true;
    };
  };
}
