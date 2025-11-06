{
  config,
  lib,
  pkgs,
  ...
}:

let
  cfg = config.host.printing;
in
with lib;
{
  options.host.printing = {
    enable = mkEnableOption "printing capabilities";
  };

  config = mkIf cfg.enable {
    host.avahi.enable = true; # enable autodiscovery of network printers that support the IPP Everywhere protocol

    services.printing = {
      enable = true;
      drivers = with pkgs; [
        brlaser
      ];
    };

    host.impermanence.directories = mkIf config.host.impermanence.enable [
      "/var/lib/cups"
    ];
  };
}
