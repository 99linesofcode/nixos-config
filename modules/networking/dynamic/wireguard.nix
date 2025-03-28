{
  config,
  lib,
  pkgs,
  ...
}:

let
  cfg = config.host.networking.dynamic.wireguard;
in
with lib;
{
  options = {
    host.networking.dynamic.wireguard.enable =
      mkEnableOption "dynamic wireguard tunnel through network manager";
  };

  # FIXME: appeared broken, test before enabling
  config = mkIf cfg.enable {
    # sops.secrets.wireguard-private-key = {
    #   format = "binary";
    #   sopsFile = "${config.host.root}/hosts/${config.host.networking.hostname}/secrets/wireguard-private-key";
    #   mode = "0640";
    #   group = "systemd-network";
    # };
    #
    # boot = {
    #   kernel.sysctl = {
    #     # ensure VPN packets have a valid source address
    #     "net.ipv4.conf.all.src_valid_mark" = 1;
    #   };
    # };
    #
    # networking = {
    #   firewall = {
    #     allowedUDPPorts = [ 51820 ];
    #   };
    #   wireguard = {
    #     enable = true;
    #     interfaces = {
    #       wg0 = {
    #         fwMark = "51820";
    #         table = "wireguard";
    #         ips = [ "100.64.61.22/32" ];
    #         listenPort = 51820;
    #         privateKeyFile = config.sops.secrets.wireguard-private-key.path;
    #         peers = [
    #           {
    #             publicKey = "KgTUh3KLijVluDvNpzDCJJfrJ7EyLzYLmdHCksG4sRg=";
    #             allowedIPs = [ "0.0.0.0/0" ];
    #             endpoint = "91.148.237.21:51820";
    #             persistentKeepalive = 25;
    #           }
    #         ];
    #       };
    #     };
    #   };
    # };
  };
}
