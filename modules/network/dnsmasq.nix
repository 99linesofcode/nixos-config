{
  config,
  lib,
  pkgs,
  ...
}:

let
  cfg = config.host.network.dnsmasq;
in
with lib;
{
  options.host.network.dnsmasq = {
    enable = mkEnableOption "dnsmasq";
  };

  config = mkIf cfg.enable {
    networking = {
      nameservers = [ "127.0.0.1" ]; # dnsmasq
    };

    services = {
      dnsmasq = {
        enable = true;
        resolveLocalQueries = true;
        settings = {
          address = "/test/127.0.0.1";
          bogus-priv = true;
          conf-file = "${pkgs.dnsmasq}/share/dnsmasq/trust-anchors.conf";
          dnssec = true;
          dnssec-check-unsigned = true;
          domain-needed = true;
          expand-hosts = true;
          interface = "wlan0";
          no-resolv = true;
          server = [
            "9.9.9.9"
            "149.112.112.112"
            "2620:fe::fe"
            "2620:fe::9"
            "1.1.1.1"
            "1.0.0.1"
            "2606:4700:4700::1111"
            "2606:4700:4700::1001"
          ];
        };
      };
      resolved.enable = mkForce false;
    };
  };
}
