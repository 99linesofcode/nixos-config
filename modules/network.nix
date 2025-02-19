{ specialArgs, ... }:
let
  hostname = specialArgs.hostname;
in
{
  networking = {
    firewall = {
      enable = true;
      allowedTCPPorts = [
        80
        443
      ];
    };
    hostName = hostname;
    nameservers = [
      "9.9.9.9"
      "149.112.112.112"
    ];
    # TODO: add example of wireguard configuration
    wireguard.enable = true;
    wireless.iwd.enable = true;
  };

  services.resolved = {
    enable = true;
    dnssec = "true";
    dnsovertls = "true";
    domains = [ "~." ];
    fallbackDns = [
      "1.1.1.1"
      "1.0.0.1"
    ];
    llmnr = "false";
  };
}
