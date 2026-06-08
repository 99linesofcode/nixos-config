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
  options.host.network = with types; {
    manager.enable = mkEnableOption "dynamic network manager configuration";
    hostname = mkOption {
      type = str;
    };
  };

  config = mkIf cfg.enable {
    networking = {
      nameservers = mkDefault config.host.network.nameservers;
      # stevenblack.enable = true; # stevenblack hosts file blocklist # FIXME: results in a corrupt /etc/hosts file that causes dnsmasq to crash
      useNetworkd = true;
      resolvconf.enable = mkDefault false;
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
