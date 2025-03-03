{ pkgs, specialArgs, ... }:
let
  hostname = specialArgs.hostname;
in
{
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
        "10-${hostname}" = {
          matchConfig.Name = "wlan0";
          networkConfig = {
            DHCP = "yes";
            DNS = [
              "9.9.9.9"
              "2620:fe::fe"
              "149.112.112.112"
              "2620:fe::9"
            ];
            IgnoreCarrierLoss = "3s";
          };
          linkConfig.RequiredForOnline = "routable";
        };
      };
    };
  };

  networking = {
    useDHCP = false;
    useNetworkd = true;
    wireless.iwd.enable = true;
  };

  services.resolved = {
    enable = true;
    dnssec = "true";
    dnsovertls = "true";
    domains = [ "~." ];
    fallbackDns = [
      "1.1.1.1"
      "2606:4700:4700::1111"
      "1.0.0.1"
      "2606:4700:4700::1001"
    ];
    llmnr = "false";
  };
}
