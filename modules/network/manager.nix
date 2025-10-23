{
  config,
  lib,
  ...
}:

let
  cfg = config.host.network.manager;
in
with lib;
{
  options = {
    host.network = {
      manager.enable = mkEnableOption "dynamic network manager configuration";
      hostname = mkOption {
        type = types.str;
      };
    };
  };

  config = mkIf cfg.enable {
    networking = {
      hostName = config.host.network.hostname;
      nameservers = [
        "9.9.9.9"
        "149.112.112.112"
        "2620:fe::fe"
        "2620:fe::9"
      ];
      resolvconf.enable = false;
      stevenblack.enable = true; # stevenblack hosts file blocklist
      useNetworkd = true;
      wireless = {
        interfaces = [ "wlan0" ];
        iwd.enable = true;
      };
    };
  };
}
