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
      nameservers = mkForce [
        "127.0.0.1"
      ];
    };

    services = {
      dnsmasq = {
        enable = true;
        alwaysKeepRunning = true;
        resolveLocalQueries = true;
        settings = {
          bind-interfaces = true;
          bogus-priv = true;
          cache-size = 1000;
          conf-file = "${pkgs.dnsmasq}/share/dnsmasq/trust-anchors.conf";
          dnssec = true;
          dnssec-check-unsigned = true;
          local = [
            "/local/"
            "/test/"
          ];
          server =
            config.host.network.nameservers
            ++ optionals config.host.avahi.enable [
              "/local/127.0.0.1#5353" # forward mDNS queries to Avahi
            ];
        }
        // optionalAttrs config.host.k3s.enable {
          address = "/.test/192.168.1.81"; # support wildcard domains for k3s
        };
      };
      resolved.enable = mkForce false;
    };
  };
}
