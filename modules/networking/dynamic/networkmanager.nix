{
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.host.networking.dynamic.networkmanager;
in
with lib;
{
  options = {
    host.networking.dynamic.networkmanager.enable =
      mkEnableOption "dynamic networking through networkmanager";
  };

  config = mkIf cfg.enable {
    networking = {
      hostName = config.host.networking.hostname;
      dhcpcd.enable = false;
      networkmanager = {
        enable = true;
        dns = "systemd-resolved";
      };
      nameservers = [
        "9.9.9.9"
        "149.112.112.112"
        "2620:fe::fe"
        "2620:fe::9"
      ];
      useDHCP = false;
    };
  };
}
