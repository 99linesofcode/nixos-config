{ config, lib, ... }:

let
  cfg = config.host.catt;
in
with lib;
{
  options = {
    host.catt.enable = mkEnableOption "Cast All The Things - Chromecast";
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      catt
    ];

    networking.firewall = {
      enable = true;
      allowedTCPPortRanges = [
        {
          from = 45000;
          to = 47000;
        }
      ];
    };
  };
}
