{ config, lib, ... }:

let
  cfg = config.host.network.systemd-resolved;
in
with lib;
{
  options.host.network.systemd-resolved = {
    enable = mkEnableOption "systemd-resolved";
  };

  config = mkIf cfg.enable {
    networking.resolvconf.enable = mkForce false;

    services.resolved = {
      enable = true;
      settings.Resolve = {
        DNSSEC = true;
        DNSOverTLS = true;
        FallbackDNS = config.host.network.nameservers;
        LLMNR = "false";
        Domains = [ "~." ];
        MulticastDNS = mkIf config.host.printing.enable "resolve";
      };
    };
  };
}
