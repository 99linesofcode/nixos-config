{
  config,
  lib,
  pkgs,
  ...
}:

let
  cfg = config.host.networking.static.systemd-networkd;
in
with lib;
{
  options.host.networking.static.systemd-networkd = {
    enable = mkEnableOption "static networking using systemd-networkd";
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      impala
      iw
    ];

    systemd = {
      network = {
        enable = true;
        config = {
          networkConfig = {
            SpeedMeter = "yes";
          };
        };
        links = {
          "wlan0" = {
            matchConfig.Name = "wlan0";
            linkConfig.MACAddressPolicy = "random";
          };
        };
        networks = {
          "10-${config.host.networking.hostname}" = {
            matchConfig.Name = "wlan0";
            networkConfig = {
              DHCP = true;
              DNS = [
                "9.9.9.9"
                "149.112.112.112"
                "2620:fe::fe"
                "2620:fe::9"
              ];
              IgnoreCarrierLoss = "3s";
            };
            linkConfig = {
              RequiredForOnline = "routable";
            };
          };
        };
      };
    };

    networking = {
      hostName = config.host.network.hostname;
      dhcpcd.enable = false;
      useDHCP = false;
      useNetworkd = true;
      wireless.iwd.enable = true;
      firewall.allowedUDPPorts = [ 5353 ]; # mDNS
    };
  };
}
