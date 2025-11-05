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
      dnssec = "true";
      dnsovertls = "true";
      domains = [ "~." ];
      extraConfig = mkIf config.host.printing.enable "MulticastDNS=resolve";
      fallbackDns = [
        "1.1.1.1"
        "1.0.0.1"
        "2606:4700:4700::1111"
        "2606:4700:4700::1001"
        "1.1.1.1"
        "1.0.0.1"
        "2606:4700:4700::1111"
        "2606:4700:4700::1001"
      ];
      llmnr = "false";
    };
  };
}
