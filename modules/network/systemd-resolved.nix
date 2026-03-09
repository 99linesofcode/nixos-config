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
    services.resolved = {
      enable = true;
      settings.Resolve = {
        DNSSEC = true;
        DNSOverTLS = true;
        FallbackDNS = [
          "1.1.1.1"
          "1.0.0.1"
          "2606:4700:4700::1111"
          "2606:4700:4700::1001"
          "1.1.1.1"
          "1.0.0.1"
          "2606:4700:4700::1111"
          "2606:4700:4700::1001"
        ];
        LLMNR = "false";
        Domains = [ "~." ];
        MulticastDNS = mkIf config.host.printing.enable "resolve";
      };
    };
  };
}
