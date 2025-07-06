{ config, lib, ... }:

let
  cfg = config.host.k3s;
in
with lib;
{
  options = {
    host.k3s.enable = mkEnableOption "k3s - lightweight Kubernetes distribution";
  };

  config = mkIf cfg.enable {
    services.k3s = {
      enable = true;
      role = "server";
      extraFlags = toString [
        "--debug" # optional arguments
      ];
    };

    networking.firewall = {
      allowedTCPPorts = [
        6443 # required so pods can reach API server
      ];
    };
  };
}
