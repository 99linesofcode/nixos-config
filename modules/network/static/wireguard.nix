{
  config,
  lib,
  pkgs,
  ...
}:

let
  cfg = config.host.network.static.wireguard;
in
with lib;
{
  options.host.network.static.wireguard = {
    enable = mkEnableOption "static wireguard tunnel using systemd-networkd";
  };

  config = mkIf cfg.enable {
    sops.secrets.wireguard-private-key = {
      format = "binary";
      sopsFile = "${config.host.root}/hosts/${config.host.network.hostname}/secrets/wireguard-private-key";
      mode = "0640";
      group = "systemd-network";
    };

    environment.systemPackages = with pkgs; [
      wireguard-tools
    ];

    boot = {
      kernel.sysctl = {
        # ensure VPN packets have a valid source address
        "net.ipv4.conf.all.src_valid_mark" = 1;
      };
      kernelModules = [ "wireguard" ];
    };

    systemd = {
      network = {
        config.routeTables = {
          wireguard = 51820;
        };
        netdevs = {
          "90-wg0" = {
            netdevConfig = {
              Name = "wg0";
              Kind = "wireguard";
              MTUBytes = "1420"; # optimal for wireguard
            };
            wireguardConfig = {
              PrivateKeyFile = config.sops.secrets.wireguard-private-key.path;
              FirewallMark = 51820;
              RouteTable = "wireguard";
            };
            wireguardPeers = [
              {
                PublicKey = "KgTUh3KLijVluDvNpzDCJJfrJ7EyLzYLmdHCksG4sRg=";
                AllowedIPs = [ "0.0.0.0/0" ];
                Endpoint = "91.148.237.21:51820";
              }
            ];
          };
        };
        networks.wg0 = {
          matchConfig.Name = "wg0";
          networkConfig = {
            Address = "100.64.61.22/32";
          };
          routingPolicyRules = [
            # route packets without fwmark 51820 through table 51820
            {
              FirewallMark = "51820";
              InvertRule = true;
              Table = "wireguard";
            }
            # ensure VPN tunnel route has priority
            {
              Table = "main";
              SuppressPrefixLength = 0;
            }
          ];
        };
      };
    };
  };
}
