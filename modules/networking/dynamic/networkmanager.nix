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
    # networking = {
    #   dhcpcd.enable = false;
    #   hostName = config.host.networking.hostname;
    #   networkmanager = {
    #     enable = true;
    #     dns = "systemd-resolved";
    #   };
    #   nameservers = [
    #     "9.9.9.9"
    #     "2620:fe::fe"
    #     "149.112.112.112"
    #     "2620:fe::9"
    #   ];
    #   useDHCP = false;
    # };
  };
}
