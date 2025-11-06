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
  options.host.network = {
    manager.enable = mkEnableOption "dynamic network manager configuration";
    hostname = mkOption {
      type = types.str;
    };
  };

  config = mkIf cfg.enable {
    networking = {
      hostName = config.host.network.hostname;
      nameservers = [
        "9.9.9.9"
        "149.112.112.112"
        "1.1.1.1"
        "1.0.0.1"
        "8.8.8.8"
        "8.8.4.4"
      ];
      resolvconf.enable = false;
      stevenblack.enable = true; # stevenblack hosts file blocklist
      useNetworkd = true;
      wireless = {
        interfaces = [ "wlan0" ];
        iwd.enable = true;
      };
    };

    host.impermanence.directories = mkIf config.host.impermanence.enable [
      "/var/lib/iwd"
    ];
  };
}
